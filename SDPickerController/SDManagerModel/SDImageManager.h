//
//  SDImageManager.h
//  SDImagePickerController
//
//  Created by 张伟 on 2016/11/21.
//  Copyright © 2016年 张伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "SDAssetModel.h"
#import "SDImagePicker.h"
@interface SDImageManager : NSObject

@property (nonatomic, strong) PHCachingImageManager *cachingImageManager;

+ (instancetype)manager;




@property (nonatomic, assign) BOOL fixOrientation; //修成图片方向，相机获取图片会用到

@property (nonatomic, assign) CGFloat photoPreviewMaxWidth; // 默认600像素宽

/**
    ==需要展示照片的列数，通过此确定要取出的image size
 */
@property (nonatomic, assign) NSInteger columnNumber;
/**
    对照片排序，按修改时间升序
 */
@property (nonatomic, assign) BOOL sortAscendingByModificationDate;
/**
    最小可选中的图片宽高，默认是0，小于这个宽度的图片不可选中
    防止columnNumber 属性出错
 */
@property (nonatomic, assign) NSInteger minPhotoWidthSelectable;
@property (nonatomic, assign) NSInteger minPhotoHeightSelectable;
@property (nonatomic, assign) BOOL hideWhenCanNotSelect;

/**
   图片选择
 */
@property(nonatomic,assign)BOOL pickingImage;
/**
   视频选择
 */
@property(nonatomic,assign)BOOL pickingVideo;

/**
    返回YES如果得到了授权
 */
- (BOOL)authorizationStatusAuthorized;
/**
    获取所有照片
 */
-(void)getCameraRollVideo:(BOOL)pickingVideo PickingImage:(BOOL)PickingImage completion:(void(^)(SDAlbumModel *model))completion;
/**
   获取所有分组
 */
- (void)getAllAlbums:(BOOL)pickingVideo PickingImage:(BOOL)PickingImage completion:(void (^)(NSArray<SDAlbumModel *> *models))completion;
/**
  获得Asset数组
 */
- (void)getAssetsFromFetchResult:(id)result allowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<SDAssetModel *> *models))completion;
/**
  获取相薄分组封面图
 */
- (void)getPostImageWithAlbumModel:(SDAlbumModel *)model completion:(void (^)(UIImage *postImage))completion;
/**
 获得照片数据
 */
- (PHImageRequestID)getPhotoWithAsset:(id)asset photoWidth:(CGFloat)photoWidth completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;
//获得照片zw
- (PHImageRequestID)getPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;
/**
   通过asste获得原图
 */
- (void)getOriginalPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info))completion;
/**
 通过asste data
 */
- (void)getOriginalPhotoDataWithAsset:(id)asset completion:(void (^)(NSData *data,NSDictionary *info))completion;
/**
  判断一个assets数组是否包含这个asset
 */
- (BOOL)isAssetsArray:(NSArray *)assets containAsset:(id)asset;
- (NSString *)getAssetIdentifier:(id)asset;
- (BOOL)isPhotoSelectableWithAsset:(id)asset;


#pragma mark ========相册创建========
/**
 创建一个相册，存在的话不会创建

 @param albumName  创建的相册名字
 @param completion success为YES 创建成功
 */
-(void)createAssetAlbumForName:( NSString *)albumName completion:( void(^)(BOOL success, NSError * error))completion;

/**
 
 保存image 到指定相册中。。如果没有该相册，自动创建并保存

 @param image     image
 @param albumName albumName
 */
-(void)saveImage:(UIImage *)image AlbumForName:(NSString *)albumName;
@end
