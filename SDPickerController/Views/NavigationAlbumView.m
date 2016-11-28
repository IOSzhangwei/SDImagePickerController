//
//  NavigationAlbumView.m
//  SDImagePickerController
//
//  Created by 张伟 on 16/11/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NavigationAlbumView.h"
#import "NavAlbumCell.h"
#import "SDImagePicker.h"
@interface NavigationAlbumView ()<UITableViewDelegate,UITableViewDataSource>{
    CGFloat _selfWIDTH;
}

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation NavigationAlbumView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
        self.backgroundColor =[UIColor orangeColor];
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.separatorStyle = NO;
    _tableView.rowHeight = 64;
    [_tableView registerClass:[NavAlbumCell class] forCellReuseIdentifier:@"NavAlbumCell"];
    _tableView.backgroundColor =UIColorFromRGB(0x353338);
    [self addSubview:_tableView];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _albumData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NavAlbumCell *cell =[tableView dequeueReusableCellWithIdentifier:@"NavAlbumCell" forIndexPath:indexPath];
    cell.model = _albumData [indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   [self dismiss];
    if (_navCollectionaViewBlock) {
        _navCollectionaViewBlock(_albumData[indexPath.row]);
    }
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)setAlbumData:(NSMutableArray *)albumData{
    _albumData = albumData;
    _selfWIDTH = albumData.count *64;
    if (_selfWIDTH>HEIGHT-44) {
        _selfWIDTH =HEIGHT-74;
    }
    
}

-(void)showPhotoAlbum{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame =CGRectMake(0, 44, WIDTH, _selfWIDTH);
        _tableView.height =_selfWIDTH;
    }];
}

-(void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame =CGRectMake(0, 0, WIDTH, 0);
        _tableView.height = 0;
    }];
}

@end
