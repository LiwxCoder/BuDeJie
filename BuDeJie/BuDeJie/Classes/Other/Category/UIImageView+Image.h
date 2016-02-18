//
//  UIImageView+Image.h
//  BuDeJie
//
//  Created by liwx on 16/2/19.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Image)

/** 通过网络状态判断要下载大图或小图,显示的占位图片 */
- (void)wx_setLargetImage:(NSString *)largetImageUrl smallImage:(NSString *)smallImageUrl placeholder:(UIImage *)placeholder;

@end
