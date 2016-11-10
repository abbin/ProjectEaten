//
//  PETagTableViewCell.h
//  ProjectEaten
//
//  Created by Abbin Varghese on 10/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTagsControl.h"

@interface PETagTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet TLTagsControl *cellTagControl;

@end
