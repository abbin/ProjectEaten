//
//  PECoordinatesPickerController.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 10/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PECoordinatesPickerController.h"

@interface PECoordinatesPickerController ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapsView;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (assign, nonatomic) BOOL firstUpdateOver;
@property (nonatomic, strong) void(^completionHandler)(CLLocationCoordinate2D);

@end

@implementation PECoordinatesPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - CLLocationManagerDelegate -

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (!self.firstUpdateOver) {
        self.currentLocation = [locations lastObject];;
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.currentLocation.coordinate.latitude
                                                                longitude:self.currentLocation.coordinate.longitude
                                                                     zoom:15];
        [self.mapsView animateToCameraPosition:camera];
    }
    [self.locationManager stopUpdatingLocation];
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - IBAction -

- (IBAction)cancelPicker:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goToCurrentLocation:(id)sender {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.currentLocation.coordinate.latitude
                                                            longitude:self.currentLocation.coordinate.longitude
                                                                 zoom:15];
    [self.mapsView animateToCameraPosition:camera];
}

- (IBAction)donePickingLocation:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        _completionHandler(self.mapsView.camera.target);
    }];
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Completion Handler -

-(void)withCompletionHandler:(void(^)(CLLocationCoordinate2D coordinates))handler{
    _completionHandler = handler;
}

@end
