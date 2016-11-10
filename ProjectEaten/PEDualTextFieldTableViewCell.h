//
//  PEDualTextFieldTableViewCell.h
//  ProjectEaten
//
//  Created by Abbin Varghese on 10/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PEDualTextFieldTableViewCellDelegate <NSObject>

@optional

- (BOOL)dualTextFieldCellShouldBeginEditing:(UITextField *)textField with:(NSIndexPath*)indexPath;
- (void)dualTextFieldCellDidBeginEditing:(UITextField *)textField with:(NSIndexPath*)indexPath;
- (BOOL)dualTextFieldCellShouldEndEditing:(UITextField *)textField with:(NSIndexPath*)indexPath;
- (void)dualTextFieldCellDidEndEditing:(UITextField *)textField with:(NSIndexPath*)indexPath;
- (BOOL)dualTextFieldCell:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string with:(NSIndexPath*)indexPath;
- (BOOL)dualTextFieldCellShouldClear:(UITextField *)textField with:(NSIndexPath*)indexPath;

@end

@interface PEDualTextFieldTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *cellTextFieldOne;
@property (weak, nonatomic) IBOutlet UITextField *cellTextFieldTwo;
@property (weak, nonatomic) IBOutlet UILabel *cellHeaderOne;
@property (weak, nonatomic) IBOutlet UILabel *cellHeaderTwo;

@property (strong, nonatomic) NSIndexPath *cellIndexPath;
@property id <PEDualTextFieldTableViewCellDelegate> delegate;

@end
