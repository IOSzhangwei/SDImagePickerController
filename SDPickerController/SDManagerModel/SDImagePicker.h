//
//  SDImagePicker.h
//  SDImagePickerController
//
//  Created by 张伟 on 2016/11/21.
//  Copyright © 2016年 张伟. All rights reserved.
//

#ifndef SDImagePicker_h
#define SDImagePicker_h

#import "SDAutoLayout.h"
#import "SDImageManager.h"
#import "SDAssetModel.h"
#import "SDAssetModel.h"
#import "UIView+SD.h"
#import "SDImagePickerController.h"

#define SD_DEBUG [SDImageManager manager].isLog

#define SDiOS7 ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define SDiOS8 ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define SDiOS9 ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define SDiOS9_1 ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)
// 屏幕宽
#define WIDTH [UIScreen mainScreen].bounds.size.width
// 屏幕高
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define SDUserDefault [NSUserDefaults standardUserDefaults]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d  \t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


#endif /* SDImagePicker_h */
