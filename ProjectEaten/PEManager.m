//
//  PEManager.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 06/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PEManager.h"
#import "PEConstants.h"

@implementation PEManager

+(BOOL)isUserSet{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kPECurrentUserKey]) {
        return YES;
    }
    else{
        return NO;
    }
}

@end
