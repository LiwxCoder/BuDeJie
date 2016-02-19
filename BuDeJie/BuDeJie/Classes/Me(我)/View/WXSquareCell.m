//
//  WXSquareCell.m
//  BuDeJie
//
//  Created by liwx on 16/1/23.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXSquareCell.h"
#import <UIImageView+WebCache.h>
#import "WXSquareItem.h"

@interface WXSquareCell ()

/** 图标ImageView */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/** 名称Label */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation WXSquareCell

- (void)awakeFromNib {
    // 设置UICollectionViewCell选中时的背景色
    UIView *backView =  [[UIView alloc] init];
    backView.backgroundColor = WXCommonBgColor;
    self.selectedBackgroundView = backView;
}

// ----------------------------------------------------------------------------
// 重写模型的set方法,设置图片和文字
- (void)setItem:(WXSquareItem *)item
{
    _item = item;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    self.nameLabel.text = item.name;
}

@end
