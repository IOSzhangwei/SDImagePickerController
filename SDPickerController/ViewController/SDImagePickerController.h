//
//  SDImagePickerContriller.h
//  SDImagePickerController
//
//  Created by 张伟 on 16/11/14.
//  Copyright © 2016年 张伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDAssetModel.h"
#import "SDPickerVCType.h"
@protocol SDImagePickControllerDelegate;
@interface SDImagePickerController : UIViewController




/**
   是否开启游览选择方式，默认关闭NO， 开启YES：点击左上角为选中效果，点击其他区域为进入游览选择方式
 */
@property(nonatomic,assign)BOOL browserSelect;
/**
  默认最大可选9张图片
 */
@property (nonatomic, assign) NSInteger maxImagesCount;
/**
   最小照片必选张数,至少选择一张
 */
@property (nonatomic, assign) NSInteger minImagesCount;

/**
 @property (nonatomic, assign) NSInteger timeout; 超时时间
 */
/**
 照片列数，默认4列
 */
@property (nonatomic, assign) NSInteger columnNumber;

/**
 @property (nonatomic, assign) BOOL originalPhoto;
 */

/**
  选择视频
 */
@property (nonatomic, assign) BOOL pickingVideo;
/**
  选择相册
 */
@property(nonatomic, assign) BOOL pickingImage;
/**
  默认600像素宽
 */
@property (nonatomic, assign) CGFloat photoPreviewMaxWidth;
/**
  对照片排序，按修改时间升序，默认是NO。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个
 */
@property (nonatomic, assign) BOOL sortAscendingByModificationDate;
/**
  是否显示相机按钮 默认为yes
 */
@property(nonatomic,assign)BOOL cameraBtn;
/**
  用户选中过的图片数组
 */
@property (nonatomic, strong) NSMutableArray *selectedAssets;

/**
  选择页的UI样式：toolbar 和Nav
 */
@property(nonatomic,assign)SDPickerVCUI pickerVCType;
/**
  当前选中的图片数组
 */
@property (nonatomic, strong) NSMutableArray<SDAssetModel *> *selectedModels;

@property (nonatomic, weak) id<SDImagePickControllerDelegate> pickerDelegate;
/**
   maxImagesCount 为1时，自动进入单选模式（无选中与非选中UI图）
 */
- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount columnNumber:(NSInteger)columnNumber delegate:(id<SDImagePickControllerDelegate>)delegate;

@end


@protocol SDImagePickControllerDelegate <NSObject>


/**
 
  获取选中的image
 @param picker                SDImagePickerController
 @param photos                选中的图片（大图）
 @param assets                选择的asstes。可根据manager里的方法获取到原图
 @param isSelectOriginalPhoto nil
 */
- (void)imagePickerController:(SDImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto;

/** 
 拍照按钮点击事件
 @param picker SDImagePickerController
 @param info   为nil 。作为扩展参数
 */
- (void)imagePickerController:(SDImagePickerController *)picker seletedCamera:(id)info;


@end

@interface SDCollectionView : UICollectionView

@end


