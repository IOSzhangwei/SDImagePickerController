//
//  PhotoAlbumView.h
//  SDImagePickerController
//
//  Created by 张伟 on 16/11/18.
//  Copyright © 2016年 张伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDAssetModel.h"
typedef void(^ReloadCollectionaViewBlock)(SDAlbumModel *model);
@interface PhotoAlbumView : UIView


@property(nonatomic,strong)NSMutableArray *albumData;

@property(nonatomic,copy)ReloadCollectionaViewBlock reloadCollectionaViewBlock;

-(void)showPhotoAlbum:(UIView *)view;

-(void)dismiss;

@end
