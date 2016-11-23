//
//  AuthorityView.m
//  SDImagePickerController
//
//  Created by 张伟 on 16/11/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AuthorityView.h"

@implementation AuthorityView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    _titleLabel =[[UILabel alloc]init];
    [self addSubview:_titleLabel];
    _titleLabel.font =[UIFont systemFontOfSize:17];
    _titleLabel.textColor =[UIColor blackColor];
    _titleLabel.text =@"请先去设置中打开相册访问权限";
    _titleLabel.backgroundColor =[UIColor clearColor];
    _titleLabel.sd_layout.topSpaceToView(self,5).heightIs(25).centerXEqualToView(self).autoHeightRatio(0);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:[UIScreen mainScreen].bounds.size.width];
 
    
    _setupBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [_setupBtn addTarget:self action:@selector(setupClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_setupBtn];
    [_setupBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_setupBtn setTitle:@"去设置" forState:UIControlStateNormal];
    _setupBtn.titleLabel.font =[UIFont systemFontOfSize:17];
    _setupBtn.sd_layout.topSpaceToView(_titleLabel,10).heightIs(30).centerXEqualToView(self);
    [_setupBtn setupAutoSizeWithHorizontalPadding:10 buttonHeight:30];
    
}
-(void)setupClick{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}
@end
