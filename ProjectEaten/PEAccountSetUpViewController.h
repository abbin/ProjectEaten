//
//  PEAccountSetUpViewController.h
//  ProjectEaten
//
//  Created by Abbin Varghese on 08/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PEAccountSetUpViewController : UIViewController

@property (strong, nonatomic) NSString *placeName;
@property (strong, nonatomic) NSString *userName;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@end
