//
//  PETextFieldTableViewCell.h
//  ProjectEaten
//
//  Created by Abbin Varghese on 09/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PETextFieldTableViewCellDelegate <NSObject>

@optional

- (BOOL)textFieldCellShouldBeginEditing:(UITextField *)textField with:(NSIndexPath*)indexPath;
- (void)textFieldCellDidBeginEditing:(UITextField *)textField with:(NSIndexPath*)indexPath;
- (BOOL)textFieldCellShouldEndEditing:(UITextField *)textField with:(NSIndexPath*)indexPath;
- (void)textFieldCellDidEndEditing:(UITextField *)textField with:(NSIndexPath*)indexPath;
- (BOOL)textFieldCell:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string with:(NSIndexPath*)indexPath;
- (BOOL)textFieldCellShouldClear:(UITextField *)textField with:(NSIndexPath*)indexPath;
- (BOOL)textFieldCellShouldReturn:(UITextField *)textField with:(NSIndexPath*)indexPath;

@end

@interface PETextFieldTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *cellTextField;

@property (strong, nonatomic) NSIndexPath *cellIndexPath;
@property id <PETextFieldTableViewCellDelegate> delegate;

@end
