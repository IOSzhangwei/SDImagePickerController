//
//  BottomToolBar.m
//  SDImagePickerController
//
//  Created by 张伟 on 16/11/16.
//  Copyright © 2016年 张伟. All rights reserved.
//

#import "BottomToolBar.h"
#import "SDAutoLayout.h"
#import "UIImage+SD.h"
@interface BottomToolBar ()


@end
@implementation BottomToolBar



-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor =UIColorFromRGB(0x141414);
        [self createUI];
        
    }
    return self;
}
-(void)createUI{
    
    UIButton *backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    
    backBtn.tag = 200;
    backBtn.backgroundColor =[UIColor clearColor];
    backBtn.titleLabel.font =[UIFont systemFontOfSize:18];
    backBtn.frame = CGRectMake(0, 0, 70, self.height);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    
    
    _photoAlbumBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _photoAlbumBtn.tag = 201;
    [self addSubview:_photoAlbumBtn];
    _photoAlbumBtn.backgroundColor =[UIColor clearColor];
    _photoAlbumBtn.titleLabel.font =[UIFont systemFontOfSize:18];
    _photoAlbumBtn.sd_layout.heightIs(self.height).centerXEqualToView(self);
    _photoAlbumBtn.titleLabel.sd_layout.leftSpaceToView(_photoAlbumBtn,5);
    [_photoAlbumBtn setTitle:@"相机胶卷" forState:UIControlStateNormal];
    [_photoAlbumBtn addTarget:self action:@selector(photoAlbumBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_photoAlbumBtn setupAutoSizeWithHorizontalPadding:10 buttonHeight:self.height];
    
    
    _doneBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _doneBtn.tag = 202;
    _doneBtn.backgroundColor =[UIColor clearColor];
    _doneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _doneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    _doneBtn.frame = CGRectMake(WIDTH - 70, 0, 70, self.height);
    [self addSubview:_doneBtn];
    _doneBtn.titleLabel.font =[UIFont systemFontOfSize:18];
    [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_doneBtn addTarget:self action:@selector(doneClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _numberView =[UIImageView new];
    [self addSubview:_numberView];
    _numberView.backgroundColor =[UIColor clearColor];
    _numberView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 80,10, 30, 30);
    _numberView.centerY = _doneBtn.centerY;
    _numberView.image =[UIImage SD_imageNamed:@"photo_number_icon"];

    _numberLable =[UILabel new];
    [self addSubview:_numberLable];
    _numberLable.frame =_numberView.frame;
    _numberLable.backgroundColor =[UIColor clearColor];
    //_numberLable.text = @"1";
    _numberLable.textColor =[UIColor whiteColor];
    _numberLable.backgroundColor =[UIColor clearColor];
    _numberLable.textAlignment = NSTextAlignmentCenter;
    _numberLable.font =[UIFont systemFontOfSize:15];
    
    
    
}

-(void)setOneSelect:(BOOL)oneSelect{
    _oneSelect=oneSelect;
    if (_oneSelect) {
        _doneBtn.hidden = YES;
        _numberView.hidden =YES;
        _numberLable.hidden = YES;
    }else{
        _doneBtn.hidden = NO;
        _numberView.hidden =NO;
        _numberLable.hidden = NO;
    }
}

-(void)doneClick:(UIButton *)btn{
    if (_toolBarBtnBlock) {
        _toolBarBtnBlock(btn);
    }
}

-(void)photoAlbumBtnClick:(UIButton *)btn{
    if (_toolBarBtnBlock) {
        _toolBarBtnBlock(btn);
    }
}

-(void)backBtn:(UIButton *)btn{
    if (_toolBarBtnBlock) {
        _toolBarBtnBlock(btn);
    }
}

-(void)refreshToolBarStatus:(NSInteger)selectedCount{
    
    if (_oneSelect) {
        return;
    }
    _doneBtn.enabled = selectedCount>0;
    _numberView.hidden=selectedCount<=0;
    _numberLable.hidden =selectedCount<=0;
    _numberLable.text = [NSString stringWithFormat:@"%zd",selectedCount];
    [UIView showOscillatoryAnimationWithLayer:_numberView.layer type:SDAnimationToBigger];
}


@end
