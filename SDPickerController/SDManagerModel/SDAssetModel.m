//
//  SDAssetModel.m
//  SDImagePickerController
//
//  Created by 张伟 on 2016/11/21.
//  Copyright © 2016年 张伟. All rights reserved.
//

#import "SDAssetModel.h"

@implementation SDAssetModel

+ (instancetype)modelWithAsset:(id)asset type:(SDAssetModelType)type{
    SDAssetModel *model = [[SDAssetModel alloc] init];
    model.asset = asset;
    model.isSelected = NO;
    model.type = type;
    return model;
}
+ (instancetype)modelWithAsset:(id)asset type:(SDAssetModelType)type timeLength:(NSString *)timeLength {
    SDAssetModel *model = [self modelWithAsset:asset type:type];
    model.timeLength = timeLength;
    return model;
}

@end


@implementation SDAlbumModel

-(void)setResult:(id)result{
    _result =result;
    BOOL pickingImage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SD_PickingImage"] isEqualToString:@"1"];
    BOOL pickingVideo = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SD_PickingVideo"] isEqualToString:@"1"];
    [[SDImageManager manager] getAssetsFromFetchResult:result allowPickingVideo:pickingVideo allowPickingImage:pickingImage completion:^(NSArray<SDAssetModel *> *models) {
    
        _models = models;
        if (_selectedModels) {
            [self checkSelectedModels];
        }
        
    }];
}




- (void)checkSelectedModels {
    self.selectedCount = 0;
    NSMutableArray *selectedAssets = [NSMutableArray array];
    for (SDAssetModel *model in _selectedModels) {
        [selectedAssets addObject:model.asset];
    }
    for (SDAssetModel *model in _models) {
        if ([[SDImageManager manager] isAssetsArray:selectedAssets containAsset:model.asset]) {
            self.selectedCount ++;
        }
    }
}

@end
