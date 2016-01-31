//
//  UIImage+Circle.h
//  BuDeJie
//
//  Created by liwx on 16/1/31.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Circle)

/** 生成圆形图片 */
- (instancetype)wx_circleImage;
/** 通过图片名生成圆形图片 */
+ (instancetype)wx_circleImageName:(NSString *)imageName;

@end
