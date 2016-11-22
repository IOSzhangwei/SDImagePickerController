//
//  SDShowCell.h
//  SDImagePickerController
//
//  Created by 张伟 on 16/11/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDShowCell : UICollectionViewCell

@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)id asset;

@end
