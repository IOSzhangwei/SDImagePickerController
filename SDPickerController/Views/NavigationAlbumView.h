//
//  NavigationAlbumView.h
//  SDImagePickerController
//
//  Created by 张伟 on 16/11/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDAssetModel.h"
typedef void(^NavCollectionaViewBlock)(SDAlbumModel *model);
@interface NavigationAlbumView : UIView

@property(nonatomic,copy)NavCollectionaViewBlock navCollectionaViewBlock;

@property(nonatomic,strong)NSMutableArray *albumData;


-(void)showPhotoAlbum;

-(void)dismiss;

@end
