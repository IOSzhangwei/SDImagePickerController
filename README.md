 SDImagePickerController（关于相册看它就行）
====== 
一个支持多选、选原图的图片选择器，致力于将相册封装成最简单的模型数据。
与类似库对比：
=======
1.优化 获取image导致的内存过高问题

2.优化 选择image页滑动卡顿问题

3.记录选中状态，再次进入时，之前选中过的image，直接进入选中状态


###

更新记录：
========
2016.11.29  --SDImageManager：1.新增创建相册。 2.新增保存图片到相册。 3，当最大选择数为1时，进入单选模式。 4，增加导航栏选择相册类型


2016.11.22  --SDImageManager 编写，实现了相册多选功能，UI选择设计按照 lofter（网易旗下的图片社交app），开发者可根据自己需要定制UI。

效果：
===
![ABC](http://zw.hiqianjin.com/01%281%29.gif) 

![ABC](http://zw.hiqianjin.com/toolBar.gif) 

安装：
=====
1.下载demo，拖动SDPickerController文件到项目中(建议用此种方式，图片选择UI无法满足所有项目需求，加入项目里方便更改UI)

2.pod "SDPickerController"

#用法简介：
========
##添加头文件 #import "SDImagePicker.h"


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
