//
//  PEDualTextFieldTableViewCell.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 10/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PEDualTextFieldTableViewCell.h"

@implementation PEDualTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITextFieldDelegate -

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(dualTextFieldCellShouldBeginEditing:with:)]) {
        return [self.delegate dualTextFieldCellShouldBeginEditing:textField with:self.cellIndexPath];
    }
    else{
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(dualTextFieldCellDidBeginEditing:with:)]) {
        [self.delegate dualTextFieldCellDidBeginEditing:textField with:self.cellIndexPath];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(dualTextFieldCellShouldEndEditing:with:)]) {
        return [self.delegate dualTextFieldCellShouldEndEditing:textField with:self.cellIndexPath];
    }
    else{
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(dualTextFieldCellDidEndEditing:with:)]) {
        [self.delegate dualTextFieldCellDidEndEditing:textField with:self.cellIndexPath];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.delegate respondsToSelector:@selector(dualTextFieldCell:shouldChangeCharactersInRange:replacementString:with:)]) {
        return [self.delegate dualTextFieldCell:textField shouldChangeCharactersInRange:range replacementString:string with:self.cellIndexPath];
    }
    else{
        return YES;
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(dualTextFieldCellShouldClear:with:)]) {
        return [self.delegate dualTextFieldCellShouldClear:textField with:self.cellIndexPath];
    }
    else{
        return YES;
    }
}

@end
