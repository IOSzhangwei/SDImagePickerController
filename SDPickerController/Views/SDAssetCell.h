//
//  SDAssetCell.h
//  SDImagePickerController
//
//  Created by 张伟 on 16/11/14.
//  Copyright © 2016年 张伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "SDAssetModel.h"
#import "SDImageManager.h"
#import "UIView+SD.h"
#import "SDAutoLayout.h"
#import "SDImagePicker.h"
typedef enum : NSUInteger {
    SDAssetCellTypePhoto = 0,
    SDAssetCellTypeLivePhoto,
    SDAssetCellTypeVideo,
    SDAssetCellTypeAudio,
} SDAssetCellType;

@interface SDAssetCell : UICollectionViewCell

@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic, strong) SDAssetModel *model;
@property(nonatomic,copy)void (^selectBtnBlock)(BOOL);
@property(nonatomic,assign)SDAssetCellType type;
@property (nonatomic, copy) NSString *representedAssetIdentifier;
@property (nonatomic, assign) PHImageRequestID imageRequestID;

@property (nonatomic, copy) NSString *photoSelImageName;
@property (nonatomic, copy) NSString *photoDefImageName;

@property (nonatomic, assign) NSInteger maxImagesCount;

/**
  是否游览选择
 */
@property(nonatomic)BOOL photoBrowseSelect;

/**
  单选模式
 */
@property(nonatomic,assign)BOOL oneSelect;

@end






//相机cell
@interface SDAssetCameraCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *cameraView;

@end

//相薄分组cell
@interface SDAlbumCell : UITableViewCell

@property (nonatomic, strong) SDAlbumModel *model;
@property (nonatomic, strong) UILabel *groupTitleLabel;
@property(nonatomic,strong)UILabel *numberLabel;
@property(nonatomic,strong)UIView *lineView;
@end




