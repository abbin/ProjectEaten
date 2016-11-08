//
//  PEAccountSetUpViewController.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 08/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PEAccountSetUpViewController.h"
#import <CloudKit/CloudKit.h>
#import "PEConstants.h"
#import "AppDelegate.h"

@import GooglePlaces;

@interface PEAccountSetUpViewController ()

@property (strong, nonatomic) GMSPlacesClient *placesClient;
@property (weak, nonatomic) IBOutlet UILabel *logLabel;
@property (assign, nonatomic) BOOL shouldLog;

@end

@implementation PEAccountSetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.placesClient = [GMSPlacesClient sharedClient];
    self.shouldLog = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self performSelector:@selector(doSciencyStuff) withObject:nil afterDelay:3];
    [self performSelector:@selector(doFinishingUp) withObject:nil afterDelay:6];
    if (self.placeName.length == 0) {
        [self.placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
            if (error != nil) {
                [self alertWithError:error];
                return;
            }
            if (placeLikelihoodList != nil) {
                GMSPlace *place = [[[placeLikelihoodList likelihoods] firstObject] place];
                if (place != nil) {
                    for (GMSAddressComponent *component in place.addressComponents) {
                        if ([component.type isEqualToString:@"locality"]) {
                            self.placeName = component.name;
                        }
                    }
                    self.coordinate = place.coordinate;
                    [self updateUser];
                }
            }
        }];
    }
    else{
        [self updateUser];
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Other -

-(void)updateUser{
    CKContainer *myContainer = [CKContainer defaultContainer];
    [myContainer fetchUserRecordIDWithCompletionHandler:^(CKRecordID * _Nullable recordID, NSError * _Nullable error3) {
        if (!error3) {
            CKRecordID *userRecordID = [[CKRecordID alloc] initWithRecordName:[NSString stringWithFormat:@"%@%@",kPEUserRecordTypeKey,recordID.recordName]];
            CKRecord *userRecord = [[CKRecord alloc] initWithRecordType:kPEUserRecordTypeKey recordID:userRecordID];
            userRecord[kPECurrentUserNameKey] = self.userName;
            userRecord[kPECurrentUserLocationNameKey] = self.placeName;
            userRecord[kPECurrentUserLocationCoordinateKey] = [[CLLocation alloc]initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
            
            CKDatabase *publicDatabase = [myContainer publicCloudDatabase];
            [publicDatabase saveRecord:userRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error2) {
                if (!error2) {
                    [self synchronizeRecord:record];
                    [self switchRootViewController];
                }
                else if (error2.code == kPERecordAlreadyExistsErrorCodeKey){
                    CKRecord *serverRecord = [error2.userInfo objectForKey:@"ServerRecord"];
                    serverRecord[kPECurrentUserNameKey] = self.userName;
                    serverRecord[kPECurrentUserLocationNameKey] = self.placeName;
                    serverRecord[kPECurrentUserLocationCoordinateKey] = [[CLLocation alloc]initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
                    [publicDatabase saveRecord:serverRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error1) {
                        if (!error1) {
                            [self synchronizeRecord:record];
                            [self switchRootViewController];
                        }
                        else{
                            [self alertWithError:error1];
                        }
                    }];
                }
                else{
                    [self alertWithError:error2];
                }
            }];
        }
        else{
            [self alertWithError:error3];
        }
    }];
}

-(void)switchRootViewController{
    NSLog(@"Switching RootViewController");
    self.shouldLog = NO;
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

-(void)alertWithError:(NSError*)error{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Somthing went wrong" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)doFinishingUp{
    if (self.shouldLog) {
        [UIView animateWithDuration:0.3 animations:^{
            self.logLabel.alpha = 0;
        } completion:^(BOOL finished) {
            self.logLabel.text = @"Finishing up...";
            [UIView animateWithDuration:0.3 animations:^{
                self.logLabel.alpha = 1;
            } completion:nil];
        }];
    }
}

-(void)doSciencyStuff{
    if (self.shouldLog) {
        [UIView animateWithDuration:0.3 animations:^{
            self.logLabel.alpha = 0;
        } completion:^(BOOL finished) {
            self.logLabel.text = @"Doing more stuff...";
            [UIView animateWithDuration:0.3 animations:^{
                self.logLabel.alpha = 1;
            } completion:nil];
        }];
    }
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
