//
//  UIView+SD.h
//  SDImagePickerController
//
//  Created by 张伟 on 2016/11/21.
//  Copyright © 2016年 张伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SDAnimationToBigger,
    SDAnimationToSmaller,
} SDAnimationType;
@interface UIView (SD)
- (CGPoint)origin;
- (void)setOrigin:(CGPoint) point;

- (CGSize)size;
- (void)setSize:(CGSize) size;

- (CGFloat)x;
- (void)setX:(CGFloat)x;

- (CGFloat)y;
- (void)setY:(CGFloat)y;


- (CGFloat)height;
- (void)setHeight:(CGFloat)height;


- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

- (CGFloat)tail;
- (void)setTail:(CGFloat)tail;

- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;

- (CGFloat)right;
- (void)setRight:(CGFloat)right;

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(SDAnimationType)type;

@property (nonatomic, assign) CGFloat ZcenterX;
@property (nonatomic, assign) CGFloat ZcenterY;

@property(nonatomic)CGFloat layerZ;
@end
