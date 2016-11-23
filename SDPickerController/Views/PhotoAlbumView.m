//
//  PhotoAlbumView.m
//  SDImagePickerController
//
//  Created by 张伟 on 16/11/18.
//  Copyright © 2016年 张伟. All rights reserved.
//

#import "PhotoAlbumView.h"
#import "SDAssetCell.h"
#import "UIView+SD.h"
@interface PhotoAlbumView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIVisualEffectView *effectview;

@property(nonatomic,assign)CGRect layerFrame;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView *angleImageView;
@end

@implementation PhotoAlbumView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        _layerFrame = frame;
        self.backgroundColor =[UIColor clearColor];
        self.layerZ = 25.f;
        [self createUI];
    }
    return self;
}


-(void)createUI{
    _angleImageView.frame = CGRectMake(WIDTH/2.f - 55/2.f, HEIGHT-50, 55, 29);
    _angleImageView =[UIImageView new];
    _angleImageView.image =[UIImage imageNamed:@"Angle_"];
    self.alpha =0.f;
    _tableView =[[UITableView alloc]initWithFrame:self.layer.bounds style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.rowHeight =45;
    [_tableView registerClass:[SDAlbumCell class] forCellReuseIdentifier:@"SDAlbumCell"];
    _tableView.separatorStyle = NO;
    [self addSubview:_tableView];
    
}

#pragma mark ---tableView delegae 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _albumData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SDAlbumCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SDAlbumCell" forIndexPath:indexPath];
    if (indexPath.row==_albumData.count-1) {
        cell.lineView.hidden =YES;
    }
    
    cell.model =_albumData[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self dismiss];
    if (self.reloadCollectionaViewBlock) {
        self.reloadCollectionaViewBlock(_albumData[indexPath.row]);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(void)setAlbumData:(NSMutableArray *)albumData{
    _albumData =albumData;
    //此处修改frame
    _layerFrame = CGRectMake(WIDTH/2.f - 250/2.f, HEIGHT -68 -45*_albumData.count, 250, 45*_albumData.count);
    _tableView.height = 45*_albumData.count;
}

-(void)showPhotoAlbum:(UIView *)view{
    NSLog(@"显示显示");
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    _effectview.frame = CGRectMake(0, 0, WIDTH, HEIGHT-50);
    [view insertSubview:_effectview atIndex:0];
    [view bringSubviewToFront:_effectview];
    [view bringSubviewToFront:self];
    _effectview.alpha =1.f;
    self.alpha =1.f;
    [self.layer setValue:@(0.1) forKeyPath:@"transform.scale"];
    [view addSubview:self];
    [view addSubview:_angleImageView];
    self.layer.frame= CGRectMake(WIDTH/2.f - 250/2.f, HEIGHT -68 -45*_albumData.count+70, 250, 45*_albumData.count);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _effectview.alpha =1;
        self.alpha =1.f;
        
        self.layer.anchorPoint=CGPointMake(0.5, 0.9);
        [self.layer setValue:@(1.08) forKeyPath:@"transform.scale"];
    #pragma mark ---设置弹出View frame
        _angleImageView.frame = CGRectMake(WIDTH/2.f - 55/2.f, HEIGHT -68, 55, 29);
        self.layer.frame=_layerFrame;
        _angleImageView.alpha =1.f;

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
             [self.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            
        }];
    }];
  
}

-(void)dismiss{
    NSLog(@"dismissssss");
    _angleImageView.alpha =0;
    self.layer.frame= CGRectMake(WIDTH/2.f - 250/2.f, HEIGHT -68 -45*_albumData.count+70, 250, 45*_albumData.count);
    _angleImageView.frame = CGRectMake(WIDTH/2.f - 55/2.f, HEIGHT-30, 55, 29);
    self.alpha =0.f;
    [UIView animateWithDuration:0.5*0.618 animations:^{
        
        _effectview.alpha =0;
        
    [self.layer setValue:@(0.1) forKeyPath:@"transform.scale"];
        
    } completion:^(BOOL finished) {
    
        
    }];
}




@end
