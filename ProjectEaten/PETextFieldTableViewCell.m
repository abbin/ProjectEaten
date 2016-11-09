//
//  PETextFieldTableViewCell.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 09/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PETextFieldTableViewCell.h"

@implementation PETextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForReuse{
    [super prepareForReuse];
    self.cellTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.cellTextField.keyboardType = UIKeyboardTypeDefault;
    self.cellTextField.autocorrectionType = UITextAutocorrectionTypeDefault;
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITextFieldDelegate -

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textFieldCellShouldBeginEditing:with:)]) {
        return [self.delegate textFieldCellShouldBeginEditing:textField with:self.cellIndexPath];
    }
    else{
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textFieldCellDidBeginEditing:with:)]) {
        [self.delegate textFieldCellDidBeginEditing:textField with:self.cellIndexPath];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textFieldCellShouldEndEditing:with:)]) {
        return [self.delegate textFieldCellShouldEndEditing:textField with:self.cellIndexPath];
    }
    else{
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textFieldCellDidEndEditing:with:)]) {
        [self.delegate textFieldCellDidEndEditing:textField with:self.cellIndexPath];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.delegate respondsToSelector:@selector(textFieldCell:shouldChangeCharactersInRange:replacementString:with:)]) {
        return [self.delegate textFieldCell:textField shouldChangeCharactersInRange:range replacementString:string with:self.cellIndexPath];
    }
    else{
        return YES;
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textFieldCellShouldClear:with:)]) {
        return [self.delegate textFieldCellShouldClear:textField with:self.cellIndexPath];
    }
    else{
        return YES;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textFieldCellShouldReturn:with:)]) {
        return [self.delegate textFieldCellShouldReturn:textField with:self.cellIndexPath];
    }
    else{
        return YES;
    }
}

@end
