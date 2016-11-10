//
//  PEDayTableViewCell.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 10/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PEDayTableViewCell.h"

@implementation PEDayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchChanged:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(dayTableViewCell:didChangeStatus:withIndexPath:)]) {
        [self.delegate dayTableViewCell:self didChangeStatus:sender.isOn withIndexPath:self.cellIndexPath];
    }
}

@end
