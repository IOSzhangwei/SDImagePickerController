//
//  BottomToolBar.h
//  SDImagePickerController
//
//  Created by 张伟 on 16/11/16.
//  Copyright © 2016年 张伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SD.h"
#import "SDImagePicker.h"
typedef void (^ToolBarBtnBlock)(UIButton * Btn);
@interface BottomToolBar : UIView

@property(nonatomic,copy)NSString *titlePhoto;

@property(nonatomic,copy)ToolBarBtnBlock toolBarBtnBlock;
@property(nonatomic,strong)UIButton *doneBtn;
@property(nonatomic,strong)UILabel *numberLable;
@property(nonatomic,strong)UIImageView *numberView;
@property(nonatomic,strong)UIButton *photoAlbumBtn;

@property(nonatomic,assign)BOOL oneSelect;
/**
   刷新ToolBar 状态
 */
-(void)refreshToolBarStatus:(NSInteger)selectedCount;
@end
