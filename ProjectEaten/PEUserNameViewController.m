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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
