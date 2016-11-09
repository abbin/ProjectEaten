//
//  PEUserLocationViewController.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 06/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PEUserLocationViewController.h"
#import "AppDelegate.h"
#import "PEAccountSetUpViewController.h"

@import GooglePlaces;

@interface PEUserLocationViewController ()<GMSAutocompleteViewControllerDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *autoDectectButton;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) BOOL firstUpdateFinished;

@end

@implementation PEUserLocationViewController

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.autoDectectButton setTitle:@"Auto-dectect location" forState:UIControlStateNormal];
    self.firstUpdateFinished = NO;
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - CLLocationManagerDelegate -

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.autoDectectButton setTitle:@"Auto-dectect location" forState:UIControlStateNormal];
    [self.locationManager stopUpdatingLocation];
    self.firstUpdateFinished = NO;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (!self.firstUpdateFinished) {
        self.firstUpdateFinished = YES;
        PEAccountSetUpViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"PEAccountSetUpViewController"];
        VC.userName = self.userName;
        [self.navigationController pushViewController:VC animated:YES];
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
    [self.autoDectectButton setTitle:@"Dectecting..." forState:UIControlStateNormal];
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
        PEAccountSetUpViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"PEAccountSetUpViewController"];
        VC.userName = self.userName;
        VC.placeName = place.name;
        VC.coordinate = place.coordinate;
        [self.navigationController pushViewController:VC animated:YES];
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

@end
