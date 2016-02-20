//
//  WXSeeBigPictureViewController.m
//  BuDeJie
//
//  Created by liwx on 16/2/20.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXSeeBigPictureViewController.h"
#import "WXTopicItem.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface WXSeeBigPictureViewController ()<UIScrollViewDelegate>

/** 保存按钮 */
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
/** imageView */
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation WXSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ------------------------------------------------------------------------
    // 1.创建scrollView
    // 因为控制器的view是从xib中加载的,所以此时控制器view的尺寸并不是最终显示的尺寸,所以不能让scrollView的frame = self.view.frame;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor orangeColor];
    // 方案一
    scrollView.frame = [UIScreen mainScreen].bounds;
    // 方案二
//    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    scrollView.frame = self.view.frame;
    [self.view insertSubview:scrollView atIndex:0];
    
    // ------------------------------------------------------------------------
    // 2.创建imageView,添加到scrollView并设置imageView显示的图片
    // 2.1 创建imageView,
    UIImageView *imageView = [[UIImageView alloc] init];
    
    // 2.2 设置图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topicItem.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 判断图片是否下载成功
        if (image == nil) return;
        // 保存按钮变成可用状态
        self.saveButton.enabled = YES;
    }];
    
    // 2.3 计算imageView的位置和尺寸
    imageView.wx_width = scrollView.wx_width;
    imageView.wx_height = imageView.wx_width * self.topicItem.height / self.topicItem.width;
    imageView.wx_x = 0;
    
    // 2.4 长图处理
    if (imageView.wx_height > scrollView.wx_height) {
        // 长图时imageView填充整个scrollView,所以y为0
        imageView.wx_y = 0;
        // 长图可以滚动,需设置scrollView的滚动范围contentSize
        scrollView.contentSize = CGSizeMake(0, imageView.wx_height);
    } else {
        imageView.wx_centerY = scrollView.wx_height * 0.5;
    }
    
    // 2.5添加到scrollView
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // ------------------------------------------------------------------------
    // 3.如果服务器返回的图片宽度比imageView的宽度大,则可以缩放图片(设置缩放比例)
    if (self.topicItem.width > imageView.wx_width) {
        // 设置代理,目的是为了缩放实现缩放功能
        scrollView.delegate = self;
        // 设置缩放比例
        scrollView.maximumZoomScale = self.topicItem.width / imageView.wx_width;
    }
    
}

#pragma =======================================================================
#pragma mark - UIScrollViewDelegate代理方法

// ------------------------------------------------------------------------
// 返回要缩放的view
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

// ----------------------------------------------------------------------------
// 方案三: 重写viewDidLayoutSubviews方法,在该方法中获取到控制器view的显示的真实尺寸,设置scrollView的frame为控制器view的frame
//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    
//    self.scrollView.frame = self.view.frame;
//}


#pragma =======================================================================
#pragma mark - 监听返回,保存按钮点击

- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save
{
    // ------------------------------------------------------------------------
    // 保存图片到Camera Roll（相机胶卷）中,第三个参数必须传image:didFinishSavingWithError:contextInfo:格式的方法,方法名可以不一样,但是参数必须一样,否则会报错
    /*
     NSInvocation : 出现这个类名，一般都是“调用方法”时报的错误
     
     -[NSInvocation setArgument:atIndex:]: index (2) out of bounds [-1, 1]
     错误原因：方法调用时参数越界，参数个数不够
     */
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}

@end
