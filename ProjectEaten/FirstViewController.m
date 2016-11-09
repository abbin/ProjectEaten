//
//  FirstViewController.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 05/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "FirstViewController.h"
#import "UIViewController+YMSPhotoHelper.h"
#import "PEAddTableViewControllerOne.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)launchImagePicker:(id)sender {
    PEAddTableViewControllerOne *addViewControllerOne = [self.storyboard instantiateViewControllerWithIdentifier:@"PEAddTableViewControllerOne"];
    addViewControllerOne.tableView.alpha = 0;
    
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:addViewControllerOne];
    navigationController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [navigationController setNavigationBarHidden:YES];
    
    [self presentViewController:navigationController animated:NO completion:^{
        YMSPhotoPickerViewController *pickerViewController = [[YMSPhotoPickerViewController alloc] init];
        pickerViewController.numberOfPhotoToSelect = 3;
        pickerViewController.theme.titleLabelFont = [UIFont fontWithName:@".SFUIText-Semibold" size:16];
        pickerViewController.theme.albumNameLabelFont = [UIFont systemFontOfSize:[UIFont labelFontSize]];
        [navigationController yms_presentCustomAlbumPhotoView:pickerViewController delegate:addViewControllerOne];
    }];
}

@end
