//
//  PEAddViewControllerOne.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 08/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PEAddViewControllerOne.h"

@interface PEAddViewControllerOne ()

@property (strong, nonatomic) NSMutableArray *imagesArray;

@end

@implementation PEAddViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    
    // The access denied of camera is always happened on picker, present alert on it to follow the view hierarchy
    [picker presentViewController:alertController animated:YES completion:nil];
}

- (void)photoPickerViewController:(YMSPhotoPickerViewController *)picker didFinishPickingImages:(NSArray *)photoAssets{
    self.view.backgroundColor = [UIColor whiteColor];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
