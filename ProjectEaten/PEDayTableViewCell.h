//
//  PEDayTableViewCell.h
//  ProjectEaten
//
//  Created by Abbin Varghese on 10/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PEDayTableViewCell;

@protocol PEDayTableViewCellDelegate <NSObject>

-(void)dayTableViewCell:(PEDayTableViewCell*)cell didChangeStatus:(BOOL)status withIndexPath:(NSIndexPath*)indexPath;

@end

@interface PEDayTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellTextLabel;
@property (weak, nonatomic) IBOutlet UISwitch *cellSwitch;

@property (strong, nonatomic) NSIndexPath *cellIndexPath;
@property id <PEDayTableViewCellDelegate> delegate;

@end
