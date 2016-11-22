//
//  SDAssetModel.h
//  SDImagePickerController
//
//  Created by 张伟 on 2016/11/21.
//  Copyright © 2016年 张伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    SDAssetModelTypePhoto = 0,
    SDAssetModelTypeLivePhoto,
    SDAssetModelTypeVideo,
    SDAssetModelTypeAudio
} SDAssetModelType;
@class PHAsset;
@interface SDAssetModel : NSObject

@property (nonatomic, strong) id asset;  // PHAsset 和 ALAsset 类型

@property (nonatomic, assign) BOOL isSelected; //选中状态

@property (nonatomic, assign) SDAssetModelType type; //获取到的数asset类型

@property (nonatomic, copy) NSString *timeLength; //视频时长

/**
 asset（PHAsset/ALAsset实例）转成照片模型
 
 */
+ (instancetype)modelWithAsset:(id)asset type:(SDAssetModelType)type;
//video
+ (instancetype)modelWithAsset:(id)asset type:(SDAssetModelType)type timeLength:(NSString *)timeLength;

@end

/**=====相薄分组model*/
@class PHFetchResult;
@interface SDAlbumModel : NSObject
@property (nonatomic, strong) NSString *name; //分组名

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) id result; // PHAsset 和 ALAsset 类型

@property (nonatomic, strong) NSArray *models;

@property (nonatomic, strong) NSArray *selectedModels;

@property (nonatomic, assign) NSUInteger selectedCount;


@end
