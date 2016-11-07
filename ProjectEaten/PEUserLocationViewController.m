//
//  PEUserLocationViewController.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 06/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PEUserLocationViewController.h"
#import <CloudKit/CloudKit.h>
#import "PEConstants.h"
#import "AppDelegate.h"

@import GooglePlaces;

@interface PEUserLocationViewController ()<GMSAutocompleteViewControllerDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) GMSPlacesClient *placesClient;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) BOOL firstUpdateFinished;

@end

@implementation PEUserLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.placesClient = [GMSPlacesClient sharedClient];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (!self.firstUpdateFinished) {
        self.firstUpdateFinished = YES;
        [self.placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
            if (error != nil) {
                NSLog(@"Pick Place error %@", [error localizedDescription]);
                return;
            }
            
            if (placeLikelihoodList != nil) {
                GMSPlace *place = [[[placeLikelihoodList likelihoods] firstObject] place];
                NSString *name = @"";
                if (place != nil) {
                    for (GMSAddressComponent *component in place.addressComponents) {
                        if ([component.type isEqualToString:@"locality"]) {
                            name = component.name;
                        }
                    }
                    [self updateUserWithPlaceName:name coordinate:place.coordinate];
                }
            }
        }];
    }
    [self.locationManager stopUpdatingLocation];
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Actions -

- (IBAction)autoDectectLocation:(id)sender {
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (IBAction)selectManually:(id)sender {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterCity;
    acController.autocompleteFilter = filter;
    acController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    acController.primaryTextHighlightColor = [UIColor blackColor];
    acController.primaryTextColor = [UIColor lightGrayColor];
    acController.tableCellBackgroundColor = [UIColor whiteColor];
    [self presentViewController:acController animated:YES completion:nil];
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - GMSAutocompleteViewControllerDelegate -

- (void)viewController:(GMSAutocompleteViewController *)viewController didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:^{
        [self updateUserWithPlaceName:place.name coordinate:place.coordinate];
    }];
}

- (void)viewController:(GMSAutocompleteViewController *)viewController didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Error: %@", [error description]);
}

- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Other -

-(void)updateUserWithPlaceName:(NSString*)placeName coordinate:(CLLocationCoordinate2D)coordinate{
    CKContainer *myContainer = [CKContainer defaultContainer];
    [myContainer fetchUserRecordIDWithCompletionHandler:^(CKRecordID * _Nullable recordID, NSError * _Nullable error) {
        if (!error) {
            CKRecordID *userRecordID = [[CKRecordID alloc] initWithRecordName:[NSString stringWithFormat:@"%@%@",kPEUserRecordTypeKey,recordID.recordName]];
            CKRecord *userRecord = [[CKRecord alloc] initWithRecordType:kPEUserRecordTypeKey recordID:userRecordID];
            userRecord[kPECurrentUserNameKey] = self.userName;
            userRecord[kPECurrentUserLocationNameKey] = placeName;
            userRecord[kPECurrentUserLocationCoordinateKey] = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
            
            CKDatabase *publicDatabase = [myContainer publicCloudDatabase];
            [publicDatabase saveRecord:userRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
                if (!error) {
                    [self synchronizeRecord:record];
                    [self switchRootViewController];
                }
                else if (error.code == kPERecordAlreadyExistsErrorCodeKey){
                    CKRecord *serverRecord = [error.userInfo objectForKey:@"ServerRecord"];
                    serverRecord[kPECurrentUserNameKey] = self.userName;
                    serverRecord[kPECurrentUserLocationNameKey] = placeName;
                    serverRecord[kPECurrentUserLocationCoordinateKey] = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
                    [publicDatabase saveRecord:serverRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
                        if (!error) {
                            [self synchronizeRecord:record];
                            [self switchRootViewController];
                        }
                        else{
                            // Handle Error
                        }
                    }];
                }
                else{
                    // Handle Error
                }
            }];
        }
        else{
            // Handle Error
        }
    }];
}

-(void)switchRootViewController{
    NSLog(@"Switching RootViewController");
    dispatch_async(dispatch_get_main_queue(), ^{
        UITabBarController *newRootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PETabBarController"];
        AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [delegate changeRootViewControllerToViewController:newRootViewController];
    });
}

-(void)synchronizeRecord:(CKRecord*)record{
    NSMutableDictionary *userDictionary = [[NSMutableDictionary alloc]init];
    [userDictionary setObject:record[kPECurrentUserNameKey] forKey:kPECurrentUserNameKey];
    [userDictionary setObject:record[kPECurrentUserLocationNameKey] forKey:kPECurrentUserLocationNameKey];
    
    CLLocation *location = record[kPECurrentUserLocationCoordinateKey];
    
    [userDictionary setObject:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:kPECurrentUserLocationLatitudeKey];
    [userDictionary setObject:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:kPECurrentUserLocationLongitudeKey];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userDictionary forKey:kPECurrentUserKey];
    [defaults synchronize];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
