//
//  YYIconImgManager.m
//  ArrQTool
//
//  Created by admin on 2018/7/17.
//  Copyright © 2018年 ArrQ. All rights reserved.
//

#import "YYIconImgManager.h"

@interface YYIconImgManager ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property(nonatomic,copy) void(^blockFinish)(UIImagePickerController *picker,UIImage *image,NSData *imageData,NSDictionary *editingInfo);
@property(nonatomic,copy) void(^blockCancel)(UIImagePickerController *picker);

@end


@implementation YYIconImgManager

+ (instancetype)shareManager{
    static YYIconImgManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YYIconImgManager alloc] init];
    });
    return manager;
}

#pragma mark - 获取 iocnImg

- (void)getChangeIconImgWithVC:(UIViewController *)selfVC andTitles:(NSArray *)titlesArr andCancelBlock:(void (^)(UIImagePickerController *))CancelBlock andFinishBlock:(void (^)(UIImagePickerController *, UIImage *, NSData *, NSDictionary *))FinishBlock{
    
    self.blockCancel = CancelBlock;
    self.blockFinish = FinishBlock;
    
    if (titlesArr.count == 0 || titlesArr == nil) {
        
        titlesArr = @[@"取消",@"拍照",@"相册"];
        
    }
    
    
    NSMutableArray *dataArr = [NSMutableArray array];
    [dataArr removeAllObjects];
    [dataArr addObjectsFromArray:titlesArr];
 
    
     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];

    for (int i = 0; i<dataArr.count; i++) {

        UIImagePickerController *pickerController =[[UIImagePickerController alloc] init];

        NSString *titlestr = dataArr[i];

        if ([titlestr containsString:@"取消"]) {

            UIAlertAction *actionSheet = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:actionSheet];


        }

        if ([titlestr containsString:@"拍照"]) {


            __block UIAlertAction *actionSheet = [UIAlertAction actionWithTitle:titlestr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"拍照");
                pickerController.allowsEditing = YES;
                pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                pickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                pickerController.showsCameraControls = YES;
                pickerController.delegate = self;

                [selfVC presentViewController:pickerController animated:YES completion:nil];
            }];

            [alertController addAction:actionSheet];

        }


        if ([titlestr containsString:@"相册"]) {

             __block UIAlertAction *actionSheet = [UIAlertAction actionWithTitle:titlestr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"从手机相册选择");
                pickerController.allowsEditing = YES;
                //设置打开类型
                pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                pickerController.delegate = self;


                //模态
                [selfVC presentViewController:pickerController animated:YES completion:nil];


            }];

            [alertController addAction:actionSheet];

            
            
        }


    }
    
    
    
    [selfVC presentViewController:alertController animated:YES completion:nil];
    
    
    
    
}



#pragma mark UIImagePickerController delegate

// 获取拍照照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    
    
    NSData *imageData;
    if (image.size.width > 1000) {
        imageData = UIImageJPEGRepresentation(image, 0.3);
    }else{
        imageData = UIImageJPEGRepresentation(image, 0.5);
    }
    
    
    if (self.blockFinish) {
        
        self.blockFinish(picker, image, imageData, editingInfo);
    }
    
    
    [self getDismissVC:picker];

}

// 相机或相册的取消代理方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"用户取消了");
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    if (self.blockCancel) {
        
        self.blockCancel(picker);
    }
    
    [self getDismissVC:picker];
}



// 取消方法
- (void)getDismissVC:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



@end
