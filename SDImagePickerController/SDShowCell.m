//
//  SDShowCell.m
//  SDImagePickerController
//
//  Created by 张伟 on 16/11/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SDShowCell.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
@implementation SDShowCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    _bottomView =[[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:_bottomView];
    
    _imageView =[[UIImageView alloc]initWithFrame:self.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
    [self addSubview:_imageView];
}





@end
