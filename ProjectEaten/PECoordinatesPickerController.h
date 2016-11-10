//
//  PECoordinatesPickerController.h
//  ProjectEaten
//
//  Created by Abbin Varghese on 10/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMaps;

@interface PECoordinatesPickerController : UIViewController

-(void)withCompletionHandler:(void(^)(CLLocationCoordinate2D coordinates))handler;

@end
