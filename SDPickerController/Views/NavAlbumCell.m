//
//  NavAlbumCell.m
//  SDImagePickerController
//
//  Created by 张伟 on 16/11/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NavAlbumCell.h"
#import "SDImagePicker.h"
@interface NavAlbumCell ()

@property(nonatomic,strong)UIImageView *albumImageView;

@property(nonatomic,strong)UILabel *titleLabel;


@end

@implementation NavAlbumCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor =UIColorFromRGB(0x353338);
        [self createUI];
        
    }
    return self;
}

-(void)createUI{
    
    CGFloat albumWH = 64 - 8;
    _albumImageView =[[UIImageView alloc]initWithFrame:CGRectMake(5, 64 -albumWH -4 , albumWH, albumWH)];
    [self.contentView addSubview:_albumImageView];
    
    _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_albumImageView.frame)+22, 0, 200, 20)];
    _titleLabel.centerY =_albumImageView.centerY;
    _titleLabel.textColor =[UIColor whiteColor];
    _titleLabel.font =[UIFont systemFontOfSize:13];
    [self.contentView addSubview:_titleLabel];
    _albumImageView.contentMode =UIViewContentModeScaleAspectFill;
    _albumImageView.clipsToBounds = YES;
    
    UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 63, WIDTH, 1)];
    lineView.backgroundColor =UIColorFromRGB(0x3A383D);
    [self.contentView addSubview:lineView];
    
}

-(void)setModel:(SDAlbumModel *)model{
    [[SDImageManager manager] getPostImageWithAlbumModel:model completion:^(UIImage *postImage) {
        _albumImageView.image =postImage;
    }];
    _titleLabel.text = [NSString stringWithFormat:@"%@  (%zd)",model.name,model.count];
}


@end
