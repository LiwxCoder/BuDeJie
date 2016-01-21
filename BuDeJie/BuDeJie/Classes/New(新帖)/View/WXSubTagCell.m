//
//  WXSubTagCell.m
//  BuDeJie
//
//  Created by liwx on 16/1/21.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXSubTagCell.h"
#import <UIImageView+WebCache.h>
#import "WXSubTagItem.h"
#import "UIImage+Antialias.h"

@interface WXSubTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation WXSubTagCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma =======================================================================
#pragma mark - cell的业务处理
// ----------------------------------------------------------------------------
// 快速创建cell
+ (instancetype)subTagCell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

// ----------------------------------------------------------------------------
// 重写模型set方法
- (void)setItem:(WXSubTagItem *)item
{
    _item = item;
    
    // ------------------------------------------------------------------------
    // 设置圆形图片
    NSLog(@"%@", item.image_list);
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // --------------------------------------------------------------------
        // 重新生产圆形图片
//        NSLog(@"%@", NSStringFromCGSize(image.size));
        
        // 1.开启位图上下文(自适应位图上下文比例)
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        
        // 2.贝塞尔曲线描述裁减路径
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        // 3.设置裁减区域
        [path addClip];
        // 4.绘图
        [image drawAtPoint:CGPointZero];
        // 5.从上下文获取裁剪好的图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        // 6.关闭上下文
        UIGraphicsEndImageContext();
        
        // 7.用抗锯齿分类设置圆形图片抗锯齿(抗锯齿实现原理: 生成1像素的图形边框)
        self.iconImageView.image = [newImage imageAntialias];
        
    }];
    
    // ------------------------------------------------------------------------
    // 设置标题和订阅数
    self.nameLabel.text = item.theme_name;
    
    // 处理超过一万的订阅数显示内容
    if (item.sub_number >= 10000) {
        NSString *str = [NSString stringWithFormat:@"%.1f万人订阅", item.sub_number / 10000.0];
        str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
        self.numLabel.text = str;
    }else {
        self.numLabel.text = [NSString stringWithFormat:@"%ld人订阅", item.sub_number];
    }
    
}

// ----------------------------------------------------------------------------
// 重写setFrame方法,目的是为了让分割线占据屏幕整个宽度
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}


@end
