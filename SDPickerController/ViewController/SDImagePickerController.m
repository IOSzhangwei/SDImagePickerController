//
//  SDImagePickerContriller.m
//  SDImagePickerController
//
//  Created by 张伟 on 16/11/14.
//  Copyright © 2016年 张伟. All rights reserved.
//

#import "SDImagePickerController.h"
#import "BottomToolBar.h"
#import "SDAssetCell.h"
#import "BottomToolBar.h"
#import "PhotoAlbumView.h"
#import "AuthorityView.h"
#import "SDImageManager.h"

@interface SDImagePickerController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    //  BOOL _showCameraBtn;       //从这里开始研究  中间变量的意义
    NSTimer *_timer;
}
@property (nonatomic, strong) SDCollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *modelWithDataS;

@property (nonatomic, strong) SDAlbumModel *model;

@property(nonatomic,strong)BottomToolBar *bottomToolBarView;

@property(nonatomic,strong)PhotoAlbumView *photoAlbumView;

@property(nonatomic,assign)BOOL collectionViewBottom; //collectionView 是否定位到底部()

@property(nonatomic,assign)BOOL albumSelected;

@property(nonatomic,strong)AuthorityView *authorityView;
@end

@implementation SDImagePickerController

-(NSMutableArray *)modelWithDataS{
    if (!_modelWithDataS) {
        _modelWithDataS = [NSMutableArray array];
    }
    return _modelWithDataS;
}

-(instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount columnNumber:(NSInteger)columnNumber delegate:(id<SDImagePickControllerDelegate>)delegate{
    if (self =[super init]) {
        
        _maxImagesCount = maxImagesCount;
        _minImagesCount = _minImagesCount==0?1:_minImagesCount;
        _columnNumber = columnNumber;
        _columnNumber = _columnNumber==0?4:_columnNumber;
        [SDImageManager manager].columnNumber = _columnNumber;
        _cameraBtn = YES;
        self.pickerDelegate=delegate;
        _selectedModels =[NSMutableArray array];
    }
    return self;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES] ;
    [self scrollCollectionViewToBottom];  //定位CollectionView 的frame 底部和顶部
}

-(void)setPickingImage:(BOOL)pickingImage{
    _pickingImage = pickingImage;
    NSString *image=_pickingImage?@"1":@"0";
    [SDUserDefault setObject:image forKey:@"SD_PickingImage"];
    [SDUserDefault synchronize];
}

-(void)setPickingVideo:(BOOL)pickingVideo{
    _pickingVideo = pickingVideo;
    NSString *video=_pickingVideo?@"1":@"0";
    [SDUserDefault setObject:video forKey:@"SD_PickingVideo"];
    [SDUserDefault synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionViewBottom = YES;
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self createCollectionView];
    [self createBottomToolBar];

    
    if (![[SDImageManager manager] authorizationStatusAuthorized]) {
        
        _collectionView.hidden =YES;
        _authorityView =[[AuthorityView alloc]init];
        _authorityView.backgroundColor =[UIColor clearColor];
        //[self.view bringSubviewToFront:_authorityView];
        [self.view addSubview:_authorityView];
        _authorityView.sd_layout.widthIs(WIDTH).centerXEqualToView(self.view).centerYEqualToView(self.view);
        [_authorityView setupAutoHeightWithBottomView:_authorityView.setupBtn bottomMargin:10];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(observeAuthrizationStatusChange) userInfo:nil repeats:YES];
        
    }else{
        [[SDImageManager manager] getCameraRollVideo:_pickingVideo PickingImage:_pickingImage completion:^(SDAlbumModel *model) {
            _model= model;
            self.modelWithDataS =[NSMutableArray arrayWithArray:_model.models];
            [self checkSelectedModels];   //获取数据源之后，检查有没上次选中的图片
            [_collectionView reloadData];
        }];
    }
    
    
}

- (void)checkSelectedModels {
    for (SDAssetModel *model in _modelWithDataS) {
        model.isSelected = NO;
        NSMutableArray *selectedAssets = [NSMutableArray array];
        for (SDAssetModel *model in self.selectedModels) {
            [selectedAssets addObject:model.asset];
        }
        if ([[SDImageManager manager] isAssetsArray:selectedAssets containAsset:model.asset]) {
            model.isSelected = YES;
        }
    }
}

//CollectionView 定位到最低部
- (void)scrollCollectionViewToBottom {
    
    if (_modelWithDataS.count>0&&_sortAscendingByModificationDate) {
        NSInteger item = _modelWithDataS.count - 1;
        if (_cameraBtn) {
            item+=1;
        }
        
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
        _collectionViewBottom = YES;
    }
}

#pragma mark - UICollectionViewDataSource && Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_cameraBtn) {
        return self.modelWithDataS.count+1;
    }
    return self.modelWithDataS.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self hiddenCamera:indexPath] &&[self.pickerDelegate respondsToSelector:@selector(imagePickerController:seletedCamera:)]) {
        [self.pickerDelegate imagePickerController:self seletedCamera:nil];
        return;
    }
    NSLog(@"点击进入游览页面===%@",self.navigationController);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([self hiddenCamera:indexPath]) {
        
        SDAssetCameraCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"SDAssetCameraCell" forIndexPath:indexPath];
        cell.cameraView.image =[UIImage imageNamed:@"120-1"];
        return cell;
    }
    SDAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SDAssetCell" forIndexPath:indexPath];
    cell.photoBrowseSelect =_browserSelect;
    cell.maxImagesCount= _maxImagesCount;
    SDAssetModel *model;
    if (!_cameraBtn||self.sortAscendingByModificationDate) {
        model =_modelWithDataS[indexPath.row];    //隐藏相机
    }else{
        model =_modelWithDataS[indexPath.row-1];  //显示相机
    }
    
    cell.model = model;
    __weak typeof(cell) weakCell =cell;
    cell.selectBtnBlock = ^(BOOL isSelected){
        if (isSelected) {
            model.isSelected = NO;
            weakCell.selectBtn.selected = NO;
            NSArray *selected =[NSArray arrayWithArray:_selectedModels];
            for (SDAssetModel *assetModel in selected) {    //
                if ([[[SDImageManager manager] getAssetIdentifier:model.asset] isEqualToString:[[SDImageManager manager] getAssetIdentifier:assetModel.asset]]) {
                    [_selectedModels removeObject:assetModel];  //取消选择的图片，从 _selectedModels中删除
                    break;
                }
            }
        }else{
            if (_selectedModels.count<_maxImagesCount) {  //判断是否超过最大限制数 ，
                model.isSelected = YES;
                weakCell.selectBtn.selected = YES;
                [_selectedModels addObject:model];  //保存选择的图片
                
            }else{
                NSLog(@"超过最大限制，自己做提示");
            }
        }
        [_bottomToolBarView refreshToolBarStatus:_selectedModels.count];
    };
    
    return cell;
    
}
//是否显示 camera
-(BOOL)hiddenCamera:(NSIndexPath *)indexPath{
    if (((self.sortAscendingByModificationDate &&indexPath.row>=_modelWithDataS.count)||(!self.sortAscendingByModificationDate&&indexPath.row ==0))&&_cameraBtn) {
        return YES;
    }else{
        return NO;
    }
}
- (void)didGetAllPhotos:(NSArray *)photos assets:(NSArray *)assets infoArr:(NSArray *)infoArr{
    
    if ([self.pickerDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:)]) {
        
        [self.pickerDelegate imagePickerController:self didFinishPickingPhotos:photos sourceAssets:assets isSelectOriginalPhoto:NO];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


//将之前用户选择的图片设定为选中状态，并添加到_selectedModels
-(void)setSelectedAssets:(NSMutableArray *)selectedAssets{
    _selectedModels= selectedAssets;
    _selectedModels =[NSMutableArray array];
    for (id asset in selectedAssets) {
        SDAssetModel *model =[SDAssetModel modelWithAsset:asset type:SDAssetModelTypePhoto];
        model.isSelected=YES;
        [_selectedModels addObject:model];
    }
}

- (void)setPhotoPreviewMaxWidth:(CGFloat)photoPreviewMaxWidth {
    _photoPreviewMaxWidth = photoPreviewMaxWidth;
    if (photoPreviewMaxWidth > 800) {
        _photoPreviewMaxWidth = 800;
    } else if (photoPreviewMaxWidth < 500) {
        _photoPreviewMaxWidth = 500;
    }
    [SDImageManager manager].photoPreviewMaxWidth = _photoPreviewMaxWidth;
}

-(void)setSortAscendingByModificationDate:(BOOL)sortAscendingByModificationDate{
    _sortAscendingByModificationDate = sortAscendingByModificationDate;
    [SDImageManager manager].sortAscendingByModificationDate = sortAscendingByModificationDate;
}

#pragma mark ---click---
-(void)photoAlbumBtnClick:(UIButton *)btn{
    
    if (self.albumSelected) {
        self.albumSelected = NO;
        btn.selected=!btn.selected;
    }
    
    if (btn.isSelected) {
        [_photoAlbumView dismiss];
        btn.selected = NO;
    }else{
        [_photoAlbumView showPhotoAlbum:self.view];
        btn.selected = YES;
    }
}
-(void)doneClick{
    
    if (_selectedModels.count <_minImagesCount) {  //判断是否满足最小选中数
        NSLog(@"最小选择%ld张图片,此处做提示",_minImagesCount);
        return;
    }
    NSMutableArray *photos =[NSMutableArray array];
    NSMutableArray *assets = [NSMutableArray array];
    NSMutableArray *infoArr=[NSMutableArray array];
    
    for (int i=0; i<_selectedModels.count; i++) {
        SDAssetModel *model = _selectedModels[i];
        [[SDImageManager manager] getPhotoWithAsset:model.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
            if (isDegraded) {
                return ;
            }
            if (photo) {
                //此处未做缩放，返回原图大小图片
               // photo= [self scaleImage:photo toSize:CGSizeMake(828, 1747)];
                [photos addObject:photo];
            }
            if (info) {
                [infoArr addObject:info];
            }
            [assets addObject:model.asset];
            
            if (photos.count ==_selectedModels.count) {
                [self didGetAllPhotos:photos assets:assets infoArr:infoArr];
            }
        }];
    }
}

-(void)backBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---initView---
-(void)createBottomToolBar{
    __weak typeof(self)weakSelf =self;
   // __weak typeof(_photoAlbumView)weakCell =_photoAlbumView;
    _photoAlbumView =[[PhotoAlbumView alloc]initWithFrame:CGRectMake(WIDTH/2.f - 112, HEIGHT - 360, 250, 300)];
    //分组点击选择事件
    _photoAlbumView.reloadCollectionaViewBlock=^(SDAlbumModel *model){
        weakSelf.albumSelected = YES;
        _modelWithDataS = [NSMutableArray arrayWithArray:model.models];
        [weakSelf.bottomToolBarView.photoAlbumBtn setTitle:model.name forState:UIControlStateNormal];
        [weakSelf checkSelectedModels];
        [weakSelf.collectionView reloadData];
        [weakSelf scrollCollectionViewToBottom];
    };
    
    
    
    [[SDImageManager manager] getAllAlbums:NO PickingImage:YES completion:^(NSArray<SDAlbumModel *> *models) {
        _photoAlbumView.albumData =[NSMutableArray arrayWithArray:models];
    }];
    
    
    _bottomToolBarView =[[BottomToolBar alloc]initWithFrame:CGRectMake(0,HEIGHT-50, WIDTH, 50)];
    _bottomToolBarView.numberLable.hidden =_selectedModels.count<=0;
    _bottomToolBarView.numberView.hidden=_selectedModels.count<=0;
    _bottomToolBarView.numberLable.text =[NSString stringWithFormat:@"%zd",_selectedModels.count];
    _bottomToolBarView.toolBarBtnBlock = ^(UIButton * btn){
        switch (btn.tag-200) {
            case 0:
                [weakSelf backBtnClick];
                break;
            case 1:
                [weakSelf photoAlbumBtnClick:btn];
                break;
            case 2:
                [weakSelf doneClick];
                break;
                
            default:
                break;
        }
        
    };
    [self.view addSubview:_bottomToolBarView];
    
}



-(void)createCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin=2; //item 间距
    CGFloat itemWH =(self.view.frame.size.width - (_columnNumber + 1) * margin) / _columnNumber;  //修改默认个数
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    _collectionView = [[SDCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50) collectionViewLayout:layout];
    _collectionView.backgroundColor = UIColorFromRGB(0x222222);
    _collectionView.delegate =self;
    _collectionView.dataSource =self;
    _collectionView.alwaysBounceHorizontal = NO;
    _collectionView.contentInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    [_collectionView registerClass:[SDAssetCell class] forCellWithReuseIdentifier:@"SDAssetCell"];
    [_collectionView registerClass:[SDAssetCameraCell class] forCellWithReuseIdentifier:@"SDAssetCameraCell"];
    [self.view addSubview:_collectionView];
    
    
}

#pragma mark Scale image / ---缩放图片---
- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    
    if (image.size.width < size.width) {
        return image;
    }
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/**
 是否显示 camera。 如果cameraBtn为yes，默认相机交卷显示，其他分组不显示
 @param albumName 分组名臣
 */
-(BOOL)showCamera:(NSString *)albumName{
    return self.cameraBtn;
    
}
//检测相机权限是否获取
- (void)observeAuthrizationStatusChange {
    if ([[SDImageManager manager] authorizationStatusAuthorized]) {
        [_timer invalidate];
        _timer = nil;
        [[SDImageManager manager] getCameraRollVideo:YES PickingImage:YES completion:^(SDAlbumModel *model) {
            _model= model;
            self.modelWithDataS =[NSMutableArray arrayWithArray:_model.models];
            [self checkSelectedModels];   //获取数据源之后，检查有没上次选中的图片
            [_collectionView reloadData];
        }];
        [self.view bringSubviewToFront:_collectionView];
    }
    
}

@end


@implementation SDCollectionView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ( [view isKindOfClass:[UIControl class]]) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}
@end

