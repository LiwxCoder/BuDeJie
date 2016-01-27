//
//  UIView+Frame.h
//  01-BuDeJie
//
//  Created by xmg on 16/1/18.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat wx_x;
@property CGFloat wx_y;
@property CGFloat wx_width;
@property CGFloat wx_height;
@property CGFloat wx_centerX;
@property CGFloat wx_centerY;


/** 判断方法调用者和view是否重叠 */
- (BOOL)wx_intersectWithView:(UIView *)view;

@end
