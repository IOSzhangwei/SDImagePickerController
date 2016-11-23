//
//  SDAssetCell.m
//  SDImagePickerController
//
//  Created by 张伟 on 16/11/14.
//  Copyright © 2016年 张伟. All rights reserved.
//

#import "SDAssetCell.h"
#import "UIImage+SD.h"
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)

@interface SDAssetCell ()

@property(nonatomic,strong)UIImageView *photoImageView;
@property (nonatomic,strong) UIImageView *selectImageView;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation SDAssetCell


-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
        [self createUI];
        self.backgroundColor =[UIColor blueColor];
    }
    return self;
}

-(void)createUI{
    
    _bottomView = [[UIView alloc]initWithFrame:self.bounds];
    [self.contentView addSubview:_bottomView];
    
    _selectBtn.frame = CGRectMake(self.frame.size.width-44, 0, 44, 44);
    _selectBtn =[[UIButton alloc]init];
    
    
    [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_selectBtn];
    
    _selectImageView =[[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width -27, 0, 27, 27)];
    [self.contentView addSubview:_selectImageView];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imageView.frame.origin.x + _imageView.frame.size.width, 0, 60, 17)];  //改下布局
    _timeLabel.font =[UIFont boldSystemFontOfSize:11];
    _timeLabel.textColor =[UIColor whiteColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [self.bottomView addSubview:_timeLabel];
    
    _imageView =[[UIImageView alloc]initWithFrame:self.bounds];
    _imageView.contentMode =UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:_imageView];
    [self.contentView bringSubviewToFront:_selectImageView];
    [self.contentView bringSubviewToFront:_selectBtn];
    [self.contentView bringSubviewToFront:_bottomView];
}



-(void)setModel:(SDAssetModel *)model{
    _model= model;
    if (_photoBrowseSelect) {
        
        _selectBtn.frame = CGRectMake(self.frame.size.width-44, 0, 44, 44);
    }else{
        _selectBtn.frame= self.bounds;
    }
    
    if (iOS8Later) {
        self.representedAssetIdentifier =[[SDImageManager manager] getAssetIdentifier:model.asset];
    }
    
    PHImageRequestID imageRequestID=[[SDImageManager manager] getPhotoWithAsset:model.asset photoWidth:self.frame.size.width completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
       
        if (!iOS8Later) {
            self.imageView.image = photo; return;
        }
        
        if ([self.representedAssetIdentifier isEqualToString:[[SDImageManager manager] getAssetIdentifier:model.asset]]) {
            self.imageView.image = photo;
        } else {
            // NSLog(@"this cell is showing other asset");
            [[PHImageManager defaultManager] cancelImageRequest:self.imageRequestID];
        }
        
        if (!isDegraded) {
            self.imageRequestID = 0;
        }
        
    }];
    
    if (imageRequestID && self.imageRequestID && imageRequestID != self.imageRequestID) {
        [[PHImageManager defaultManager] cancelImageRequest:self.imageRequestID];
    }
     self.imageRequestID = imageRequestID;
    self.selectBtn.selected = model.isSelected;
    self.selectImageView.image =self.selectBtn.isSelected?[UIImage SD_imageNamed:@"photo_sel_photoPickerVc.png"]:[UIImage SD_imageNamed:@"photo_def_photoPickerVc.png"];
    self.type = SDAssetCellTypePhoto;
    if (model.type == SDAssetModelTypePhoto){
        self.type = SDAssetCellTypeLivePhoto;
    }else if (model.type == SDAssetModelTypeAudio){
        self.type = SDAssetCellTypeAudio;
    }else if (model.type == SDAssetModelTypeVideo){
        self.type = SDAssetCellTypeVideo;
    }
    
    if (![[SDImageManager manager] isPhotoSelectableWithAsset:model.asset]) {
        if (_selectImageView.hidden == NO) {
            _selectImageView.hidden = YES;
        }
    }
    
}

-(void)setMaxImagesCount:(NSInteger)maxImagesCount{
    _maxImagesCount = maxImagesCount;
    if (self.selectBtn.hidden) {
        self.selectBtn.hidden = maxImagesCount= 1;
    }
    if (!self.selectImageView.hidden) {
        self.selectImageView.hidden = maxImagesCount =1;
    }
}

-(void)setType:(SDAssetCellType)type{
    _type = type;
    if (type == SDAssetCellTypePhoto ||type == SDAssetCellTypeLivePhoto) {
        _selectImageView.hidden =NO;
        _selectBtn.hidden = NO;
        _bottomView.hidden = YES;
    }else{
        _selectImageView.hidden =YES;
        _selectBtn.hidden = YES;
        _bottomView.hidden = NO;
    }
}
-(void)selectBtnClick:(UIButton *)btn{
    
    if (self.selectBtnBlock) {
        self.selectBtnBlock(btn.isSelected);
    }
    self.selectImageView.image =btn.isSelected?[UIImage SD_imageNamed:@"photo_sel_photoPickerVc.png"]:[UIImage SD_imageNamed:@"photo_def_photoPickerVc.png"];
    if (btn.isSelected) {
        [UIView showOscillatoryAnimationWithLayer:_selectImageView.layer type:SDAnimationToBigger];
    }
}

@end



//相机cell
@implementation SDAssetCameraCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _cameraView = [[UIImageView alloc] init];
        _cameraView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _cameraView.contentMode = UIViewContentModeScaleAspectFill;
        //_cameraView.image =[UIImage imageNamed:@"camera.png"];
        [self addSubview:_cameraView];
        
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _cameraView.frame = self.bounds;
}
@end

@implementation SDAlbumCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        
    }
    return self;
}


-(void)setModel:(SDAlbumModel *)model{
    
    _model = model;
    
   
    
    _groupTitleLabel.text=model.name;
    _numberLabel.text =[NSString stringWithFormat:@"%zd",model.count];
    //此方法可获取封面图
//    [[TZImageManager manager] getPostImageWithAlbumModel:model completion:^(UIImage *postImage) {
//        
//    }];
}

-(void)createUI{
    
    _groupTitleLabel =[UILabel new];
    [self addSubview:_groupTitleLabel];
    _groupTitleLabel.textColor=UIColorFromRGB(0x262626);
    _groupTitleLabel.font =[UIFont systemFontOfSize:17];
    _groupTitleLabel.sd_layout.leftSpaceToView(self,24).centerYEqualToView(self).autoHeightRatio(0);
    [_groupTitleLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    
    _numberLabel=[UILabel new];
    [self addSubview:_numberLabel];
    _numberLabel.font =[UIFont systemFontOfSize:16];
    _numberLabel.textColor =UIColorFromRGB(0xadadad);
    _numberLabel.sd_layout.rightSpaceToView(self,24).centerYEqualToView(self).autoHeightRatio(0);
    [_numberLabel setSingleLineAutoResizeWithMaxWidth:50];
    
    _lineView =[UIView new];
    [self addSubview:_lineView];
    _lineView.sd_layout.rightSpaceToView(self,0).leftSpaceToView(self,0).bottomSpaceToView(self,0).heightIs(1);
    _lineView.backgroundColor =UIColorFromRGB(0xeeeeee);
    
}

@end
