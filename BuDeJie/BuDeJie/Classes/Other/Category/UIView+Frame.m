//
//  UIView+Frame.m
//  01-BuDeJie
//
//  Created by xmg on 16/1/18.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (CGFloat)wx_height
{
    return self.frame.size.height;
}
- (void)setWx_height:(CGFloat)wx_height
{
    CGRect frame = self.frame;
    frame.size.height = wx_height;
    self.frame = frame;
}
- (CGFloat)wx_width
{
     return self.frame.size.width;
}

- (void)setWx_width:(CGFloat)wx_width
{
    CGRect frame = self.frame;
    frame.size.width = wx_width;
    self.frame = frame;
}

- (void)setWx_x:(CGFloat)wx_x
{
    CGRect frame = self.frame;
    frame.origin.x = wx_x;
    self.frame = frame;

}
- (CGFloat)wx_x
{
    return self.frame.origin.x;
}

- (void)setWx_y:(CGFloat)wx_y
{
    CGRect frame = self.frame;
    frame.origin.y = wx_y;
    self.frame = frame;
}
- (CGFloat)wx_y
{
    return self.frame.origin.y;
}

- (void)setWx_centerX:(CGFloat)wx_centerX
{
    CGPoint center = self.center;
    center.x = wx_centerX;
    self.center = center;
}

- (CGFloat)wx_centerX
{
    return self.center.x;
}

- (void)setWx_centerY:(CGFloat)wx_centerY
{
    CGPoint center = self.center;
    center.y = wx_centerY;
    self.center = center;
}

- (CGFloat)wx_centerY
{
    return self.center.y;
}



@end
