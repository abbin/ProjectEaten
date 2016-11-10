//
//  PEAddTableViewControllerOne.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 09/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PEAddTableViewControllerOne.h"
#import "PETextFieldTableViewCell.h"
#import "PETextViewTableViewCell.h"
#import "PEAddTableViewControllerTwo.h"

@interface PEAddTableViewControllerOne ()<PETextFieldTableViewCellDelegate>

@property (strong, nonatomic) NSMutableArray *imagesArray;

@end

@implementation PEAddTableViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextScreen)];
    self.navigationItem.rightBarButtonItem = next;
    self.navigationItem.title = @"Item Details";
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelUpload)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PETextFieldTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PETextFieldTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PETextViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PETextViewTableViewCell"];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - YMSPhotoPickerViewControllerDelegate -

- (void)photoPickerViewControllerDidReceivePhotoAlbumAccessDenied:(YMSPhotoPickerViewController *)picker{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Allow photo album access?", nil) message:NSLocalizedString(@"Need your permission to access photo albumbs", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertController addAction:dismissAction];
    [alertController addAction:settingsAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)photoPickerViewControllerDidReceiveCameraAccessDenied:(YMSPhotoPickerViewController *)picker{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Allow camera access?", nil) message:NSLocalizedString(@"Need your permission to take a photo", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertController addAction:dismissAction];
    [alertController addAction:settingsAction];
    [picker presentViewController:alertController animated:YES completion:nil];
}

- (void)photoPickerViewController:(YMSPhotoPickerViewController *)picker didFinishPickingImages:(NSArray *)photoAssets{
    self.tableView.alpha = 1;
    [self.navigationController setNavigationBarHidden:NO];
    [picker dismissViewControllerAnimated:YES completion:^() {
        
        PHImageManager *imageManager = [[PHImageManager alloc] init];
        
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        options.networkAccessAllowed = YES;
        options.resizeMode = PHImageRequestOptionsResizeModeExact;
        options.synchronous = YES;
        
        if (self.imagesArray == nil) {
            self.imagesArray = [NSMutableArray array];
        }
        for (PHAsset *asset in photoAssets) {
            [imageManager requestImageDataForAsset:asset
                                           options:nil
                                     resultHandler:^(NSData * _Nullable imageData,
                                                     NSString * _Nullable dataUTI,
                                                     UIImageOrientation orientation,
                                                     NSDictionary * _Nullable info) {
                                         UIImage *image = [UIImage imageWithData:imageData];
                                         [self.imagesArray addObject:image];
                                     }];
        }
    }];
}

-(void)photoPickerViewControllerDidCancel:(YMSPhotoPickerViewController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0){
        PETextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PETextFieldTableViewCell" forIndexPath:indexPath];
        cell.cellTextField.placeholder = @"type here";
        cell.cellTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        cell.cellTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        cell.delegate = self;
        return cell;
    }
    else if (indexPath.section == 1) {
        PETextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PETextFieldTableViewCell" forIndexPath:indexPath];
        cell.cellTextField.placeholder = @"type here";
        cell.cellTextField.keyboardType = UIKeyboardTypeDecimalPad;
        return cell;
    }
    else{
        PETextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PETextViewTableViewCell" forIndexPath:indexPath];
        return cell;
    }
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate -

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 1) {
        return 50;
    }
    else{
        return 100;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Name";
    }
    else if (section == 1){
        return @"Price";
    }
    else if (section == 2){
        return @"Description (Optional)";
    }
    else{
        return @"";
    }
}

- (BOOL)textFieldCellShouldReturn:(UITextField *)textField with:(NSIndexPath*)indexPath{
    if (indexPath.section == 0) {
        PETextFieldTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        [cell.cellTextField becomeFirstResponder];
    }
    return YES;
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Actions -

-(void)cancelUpload{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:@"The photos you selected have not finished uploading" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [actionSheet addAction:yes];
    [actionSheet addAction:cancel];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

-(void)nextScreen{
    PEAddTableViewControllerTwo *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PEAddTableViewControllerTwo"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
