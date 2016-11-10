//
//  PEDayPickerController.h
//  ProjectEaten
//
//  Created by Abbin Varghese on 10/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PEDayPickerController : UIViewController

@property (strong, nonatomic) NSMutableArray *workingDaysArray;

-(void)withCompletionHandler:(void(^)(NSMutableArray *days))handler;

@end
