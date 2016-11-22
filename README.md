 SDImagePickerController（关于相册看它就行）
====== 
一个支持多选、选原图的图片选择器，致力于将相册封装成最简单的模型数据。

###

更新记录：
========
2016.11.22  --SDImageManager 编写，实现了相册多选功能，UI选择设计按照 lofter（网易旗下的图片社交app），开发者可根据自己需要定制UI。
用法简介：
========

SDImagePickerController *pickerController=[[SDImagePickerController alloc]initWithMaxImagesCount:9 columnNumber:3 delegate:self];

    UINavigationController *pickerNav =[[UINavigationController alloc]initWithRootViewController:pickerController];
    
    if (_isSelectedPhotoArray.count!=0) {
        pickerController.selectedAssets = _isSelectedPhotoArray;
    }
    
    //最小选择数
    pickerController.minImagesCount = 1;
    
    pickerController.photoPreviewMaxWidth = 600;
    
    //是否显示相机
    pickerController.cameraBtn = YES;
    
    //排序方式
    pickerController.sortAscendingByModificationDate =NO;
    
    //相册选择
    pickerController.pickingImage = YES;
    
    //更多设置参数详见demo
    
    [self.navigationController presentViewController:pickerNav animated:YES completion:nil];
