//
//  PEConstants.h
//  ProjectEaten
//
//  Created by Abbin Varghese on 06/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PEConstants : NSObject

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Error Code -

FOUNDATION_EXPORT NSInteger const kPERecordAlreadyExistsErrorCodeKey;



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - User -

FOUNDATION_EXPORT NSString *const kPECurrentUserKey;
FOUNDATION_EXPORT NSString *const kPECurrentUserNameKey;
FOUNDATION_EXPORT NSString *const kPECurrentUserLocationNameKey;
FOUNDATION_EXPORT NSString *const kPECurrentUserLocationCoordinateKey;
FOUNDATION_EXPORT NSString *const kPECurrentUserLocationLatitudeKey;
FOUNDATION_EXPORT NSString *const kPECurrentUserLocationLongitudeKey;



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - RecordType -

FOUNDATION_EXPORT NSString *const kPEUserRecordTypeKey;

@end
