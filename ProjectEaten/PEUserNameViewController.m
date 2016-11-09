//
//  PEUserNameViewController.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 06/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PEUserNameViewController.h"
#import "PEUserLocationViewController.h"

@interface PEUserNameViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

@end

@implementation PEUserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameTextField.inputAccessoryView = self.toolBar;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.userNameTextField becomeFirstResponder];
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Actions -

- (IBAction)next:(id)sender {
    NSString *trimmedString = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (trimmedString.length>0) {
        PEUserLocationViewController *locationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PEUserLocationViewController"];
        locationVC.userName = trimmedString;
        [self.navigationController pushViewController:locationVC animated:YES];
    }
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITextFieldDelegate -

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *trimmedString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (trimmedString.length>0) {
        PEUserLocationViewController *locationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PEUserLocationViewController"];
        locationVC.userName = trimmedString;
        [self.navigationController pushViewController:locationVC animated:YES];
    }
    return YES;
}

@end
