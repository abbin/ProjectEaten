//
//  PEConstants.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 06/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PEConstants.h"

@implementation PEConstants

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Error Code -

NSInteger const kPERecordAlreadyExistsErrorCodeKey          = 14;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - User -

NSString *const kPECurrentUserKey                           = @"currentUserDictionary";
NSString *const kPECurrentUserNameKey                       = @"currentUserName";
NSString *const kPECurrentUserLocationNameKey               = @"currentUserLocationName";
NSString *const kPECurrentUserLocationCoordinateKey         = @"currentUserLocationCoordinate";
NSString *const kPECurrentUserLocationLatitudeKey           = @"currentUserLocationLatitude";
NSString *const kPECurrentUserLocationLongitudeKey          = @"currentUserLocationLongitude";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - RecordType -

NSString *const kPEUserRecordTypeKey                        = @"UserProfile";

@end
