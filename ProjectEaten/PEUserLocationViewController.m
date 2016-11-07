//
//  PEUserLocationViewController.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 06/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PEUserLocationViewController.h"
#import "PELocationPickerController.h"

@import GooglePlaces;

@interface PEUserLocationViewController ()<GMSAutocompleteViewControllerDelegate>

@property (strong, nonatomic) GMSPlacesClient *placesClient;

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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Actions -

- (IBAction)autoDectectLocation:(id)sender {
    [self.placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
        if (error != nil) {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            return;
        }
        
        if (placeLikelihoodList != nil) {
            GMSPlace *place = [[[placeLikelihoodList likelihoods] firstObject] place];
            if (place != nil) {
                NSLog(@"%@",place.name);
                NSLog(@"%@",[[place.formattedAddress componentsSeparatedByString:@", "]
                             componentsJoinedByString:@"\n"]);
            }
        }
    }];
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
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place name %f,%f", place.coordinate.latitude,place.coordinate.longitude);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
