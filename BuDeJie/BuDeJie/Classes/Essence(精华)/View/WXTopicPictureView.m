//
//  WXTopicPictureView.m
//  BuDeJie
//
//  Created by liwx on 16/2/18.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXTopicPictureView.h"
#import "WXTopicItem.h"
#import "WXSeeBigPictureViewController.h"
#import <UIImageView+WebCache.h>

@interface WXTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
//@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@end

@implementation WXTopicPictureView

// ----------------------------------------------------------------------------
// 重写awakeFromNib方法给imageView添加手势
- (void)awakeFromNib
{
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}

// ----------------------------------------------------------------------------
// modal形式跳转到查看大图控制器
- (void)seeBigPicture
{
    // 1.创建控制器,传递模型数据
    WXSeeBigPictureViewController *seeBigVc = [[WXSeeBigPictureViewController alloc] init];
    seeBigVc.topicItem = self.topicItem;
    
    // 2.使用窗口的根控制器执行modal查看大图控制器
    // 2.1 只有控制器才能执行modal,而当前是在view中,获取不到控制器,可以使用窗口的根控制器来执行modal操作
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [vc presentViewController:seeBigVc animated:YES completion:nil];
}

// ----------------------------------------------------------------------------
// 重写模型的set方法,设置子控件的内容,控制子控件的隐藏和显示
- (void)setTopicItem:(WXTopicItem *)topicItem
{
    _topicItem = topicItem;
    
    // 设置图片
    [self.imageView wx_setLargetImage:topicItem.large_image smallImage:topicItem.small_image placeholder:nil];
    
    // 控制gif图片隐藏/显示
    self.gifView.hidden = !topicItem.is_gif;
    
    // 显示长图按钮
    if (topicItem.isBigPicture) {
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    } else {
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}

@end
