//
//  PEDualTextFieldTableViewCell.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 10/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PEDualTextFieldTableViewCell.h"

@interface PEDualTextFieldTableViewCell ()

@property (nonatomic, strong) UIDatePicker *fromDatePicker;
@property (nonatomic, strong) UIDatePicker *tillDatePicker;

@end

@implementation PEDualTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
        self.fromDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        [self.fromDatePicker setBackgroundColor:[UIColor whiteColor]];
        [self.fromDatePicker setDatePickerMode:UIDatePickerModeTime];
        [self.fromDatePicker addTarget:self action:@selector(fromDatepickerChangedValue:) forControlEvents:UIControlEventValueChanged];
        self.cellTextFieldOne.inputView = self.fromDatePicker;
        
        self.tillDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        NSDate *currentDate = self.fromDatePicker.date;
        NSDate *datePlusOneMinute = [currentDate dateByAddingTimeInterval:60];
        [self.tillDatePicker setMinimumDate:datePlusOneMinute];
        [self.tillDatePicker setBackgroundColor:[UIColor whiteColor]];
        [self.tillDatePicker setDatePickerMode:UIDatePickerModeTime];
        [self.tillDatePicker addTarget:self action:@selector(tillDatepickerChangedValue:) forControlEvents:UIControlEventValueChanged];
        self.cellTextFieldTwo.inputView = self.tillDatePicker;
    });
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



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITextFieldDelegate -

- (void)tillDatepickerChangedValue:(UIDatePicker*)sender{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    self.cellTextFieldTwo.text = [outputFormatter stringFromDate:sender.date];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [outputFormatter setTimeZone:timeZone];
    [outputFormatter setDateFormat:@"HHmm"];
    NSString *dateString = [outputFormatter stringFromDate:sender.date];
    
    if ([self.delegate respondsToSelector:@selector(dualTextFieldTwoDidChangeEditing:)]) {
        [self.delegate dualTextFieldTwoDidChangeEditing:dateString];
    }
}

- (void)fromDatepickerChangedValue:(UIDatePicker*)sender{
    
    NSDate *currentDate = self.fromDatePicker.date;
    NSDate *datePlusOneMinute = [currentDate dateByAddingTimeInterval:60];
    [self.tillDatePicker setMinimumDate:datePlusOneMinute];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    self.cellTextFieldOne.text = [outputFormatter stringFromDate:sender.date];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [outputFormatter setTimeZone:timeZone];
    [outputFormatter setDateFormat:@"HHmm"];
    NSString *dateString = [outputFormatter stringFromDate:sender.date];
  
    if ([self.delegate respondsToSelector:@selector(dualTextFieldOneDidChangeEditing:)]) {
        [self.delegate dualTextFieldOneDidChangeEditing:dateString];
    }
}

@end
