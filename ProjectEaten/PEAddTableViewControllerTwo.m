//
//  PEAddTableViewControllerTwo.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 09/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PEAddTableViewControllerTwo.h"
#import "PETextFieldTableViewCell.h"
#import "PEDualTextFieldTableViewCell.h"
#import "PECoordinatesPickerController.h"
#import "PETagTableViewCell.h"
#import "PEDayPickerController.h"

typedef NS_ENUM(NSInteger, PERestaurantSection) {
    PERestaurantSectionName,
    PERestaurantSectionAddress,
    PERestaurantSectionCity,
    PERestaurantSectionCoordinates,
    PERestaurantSectionPhoneNumber,
    PERestaurantSectionWorkingDays,
    PERestaurantSectionWorkingHours,
};

@interface PEAddTableViewControllerTwo ()<PETextFieldTableViewCellDelegate,PEDualTextFieldTableViewCellDelegate,TLTagsControlDelegate>

@end

@implementation PEAddTableViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *next = [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextScreen)];
    self.navigationItem.rightBarButtonItem = next;
    self.navigationItem.title = @"Restaurant Details";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PETextFieldTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PETextFieldTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PEDualTextFieldTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PEDualTextFieldTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PETagTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PETagTableViewCell"];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == PERestaurantSectionWorkingHours) {
        PEDualTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PEDualTextFieldTableViewCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.cellIndexPath = indexPath;
        cell.cellHeaderOne.text = @"FROM TIME";
        cell.cellHeaderTwo.text = @"TILL TIME";
        cell.cellTextFieldOne.placeholder = @"tap here";
        cell.cellTextFieldTwo.placeholder = @"tap here";
        return cell;
    }
    else if (indexPath.section == PERestaurantSectionPhoneNumber){
        PETagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PETagTableViewCell" forIndexPath:indexPath];
        cell.cellTagControl.tapDelegate = self;
        cell.cellTagControl.tagPlaceholder = @"type here";
        cell.cellTagControl.cellIndexPath = indexPath;
        return cell;
    }
    else if (indexPath.section == PERestaurantSectionWorkingDays){
        PETagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PETagTableViewCell" forIndexPath:indexPath];
        cell.cellTagControl.tapDelegate = self;
        cell.cellTagControl.tagPlaceholder = @"tap here";
        cell.cellTagControl.cellIndexPath = indexPath;
        return cell;
    }
    else{
        PETextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PETextFieldTableViewCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.cellIndexPath = indexPath;
        if (indexPath.section == PERestaurantSectionName) {
            cell.cellTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        }
        else if (indexPath.section == PERestaurantSectionAddress){
            cell.cellTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        }
        else if (indexPath.section == PERestaurantSectionCity){
            cell.cellTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        }
        else if (indexPath.section == PERestaurantSectionCity){
            cell.cellTextField.placeholder = @"tap here";
        }
        return cell;
    }
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate -

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case PERestaurantSectionName:
            return @"Restaurant name";
            break;
        case PERestaurantSectionAddress:
            return @"Address";
            break;
        case PERestaurantSectionCity:
            return @"City";
            break;
        case PERestaurantSectionCoordinates:
            return @"Coordinates";
            break;
        case PERestaurantSectionPhoneNumber:
            return @"Phone number (optional)";
            break;
        case PERestaurantSectionWorkingDays:
            return @"Working days (optional)";
            break;
        case PERestaurantSectionWorkingHours:
            return @"Working time (optional)";
            break;
            
        default:
            return @"";
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == PERestaurantSectionWorkingHours) {
        return 73;
    }
    else{
        return 50;
    }
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - PETextFieldTableViewCellDelegate -

-(BOOL)textFieldCellShouldBeginEditing:(UITextField *)textField with:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case PERestaurantSectionName:
            return YES;
            break;
        case PERestaurantSectionAddress:
            return YES;
            break;
        case PERestaurantSectionCity:
            return YES;
            break;
        case PERestaurantSectionCoordinates:{
            PECoordinatesPickerController *picker = [self.storyboard instantiateViewControllerWithIdentifier:@"PECoordinatesPickerController"];
            [picker withCompletionHandler:^(CLLocationCoordinate2D coordinates) {
                textField.text = [NSString stringWithFormat:@"%f, %f",coordinates.latitude,coordinates.longitude];
            }];
            [self presentViewController:picker animated:YES completion:nil];
            return NO;
        }
            break;
        case PERestaurantSectionPhoneNumber:
            return YES;
            break;
        default:
            return YES;
            break;
    }
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - PEDualTextFieldTableViewCellDelegate -

-(void)dualTextFieldOneDidChangeEditing:(NSString *)string{
    
}

-(void)dualTextFieldTwoDidChangeEditing:(NSString *)string{
    
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - TLTagsControlDelegate -

-(BOOL)tagsControlShouldBeginEditing:(TLTagsControl *)tagsControl withIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == PERestaurantSectionPhoneNumber) {
        return YES;
    }
    else{
        PEDayPickerController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"PEDayPickerController"];
        [VC withCompletionHandler:^(NSMutableArray *days) {
            
        }];
        [self presentViewController:VC animated:YES completion:nil];
        return NO;
    }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Actions -

-(void)nextScreen{
    
}

@end
