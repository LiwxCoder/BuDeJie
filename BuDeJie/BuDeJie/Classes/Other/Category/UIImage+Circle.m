//
//  UIImage+Circle.m
//  BuDeJie
//
//  Created by liwx on 16/1/31.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "UIImage+Circle.h"

@implementation UIImage (Circle)

// ----------------------------------------------------------------------------
// 生成圆形图片
- (instancetype)wx_circleImage
{
    // 1.开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    // 2.描述裁减路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // 3.设置裁减路径
    [path addClip];
    // 4.绘制图片
    [self drawAtPoint:CGPointZero];
    // 5.生成新图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 6.关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

// ----------------------------------------------------------------------------
// 通过图片名生成圆形图片
+ (instancetype)wx_circleImageName:(NSString *)imageName
{
    return [[UIImage imageNamed:imageName] wx_circleImage];
}

@end
