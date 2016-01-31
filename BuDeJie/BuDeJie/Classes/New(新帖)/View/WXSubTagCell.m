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
    // 设置圆形头像
    [self.iconImageView wx_setHeader:item.image_list];
    
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
    // 露出1pt充当背景分割线,
    frame.size.height -= 1;
    [super setFrame:frame];
}


@end
