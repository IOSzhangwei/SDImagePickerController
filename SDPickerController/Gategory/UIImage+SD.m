//
//  UIImage+SD.m
//  SDImagePickerController
//
//  Created by 张伟 on 16/11/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIImage+SD.h"

@implementation UIImage (SD)

+(UIImage *)SD_imageNamed:(NSString *)name{
    UIImage *image = [UIImage imageNamed:[@"Mytools.bundle" stringByAppendingPathComponent:name]];
    
    
    return image;
    
    
}

@end
