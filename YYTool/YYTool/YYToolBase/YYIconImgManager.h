//
//  YYIconImgManager.h
//  ArrQTool
//
//  Created by admin on 2018/7/17.
//  Copyright © 2018年 ArrQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YYIconImgManager : NSObject

+ (instancetype)shareManager;

- (void)getChangeIconImgWithVC:(UIViewController *)selfVC andTitles:(NSArray *)titlesArr andCancelBlock:(void(^)(UIImagePickerController *picker))CancelBlock andFinishBlock:(void(^)(UIImagePickerController *picker,UIImage *image,NSData *imageData,NSDictionary *editingInfo))FinishBlock;


@end
