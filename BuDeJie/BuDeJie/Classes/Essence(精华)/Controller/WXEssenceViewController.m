//
//  WXEssenceViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/18.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXEssenceViewController.h"
#import "WXTitleButton.h"
#import "WXAllViewController.h"
#import "WXVideoViewController.h"
#import "WXVoiceViewController.h"
#import "WXPictureViewController.h"
#import "WXWordViewController.h"

@interface WXEssenceViewController ()<UIScrollViewDelegate>

/** 标题栏 */
@property (nonatomic, weak) UIView *titleView;
/** 当前选中的按钮 */
@property (nonatomic, weak) WXTitleButton *selectedButton;
/** 标题栏下划线 */
@property (nonatomic, weak) UIView *underLineView;
/** scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation WXEssenceViewController

#pragma =======================================================================
#pragma mark - 系统方法重写
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    // 1.设置导航条按钮
    [self setupNavigationItem];
    
    // 2.设置显示内容区域scrollView
    [self setupScrollView];
    
    // 3.设置标题栏titleView
    [self setupTitleView];
    
    // 4.添加子控制器
    [self setupAllChildViewController];
}

#pragma =======================================================================
#pragma mark - 初始化子控件

- (void)setupAllChildViewController
{
    // 1.添加5个子控制器
    [self addChildViewController:[[WXAllViewController alloc] init]];
    [self addChildViewController:[[WXVideoViewController alloc] init]];
    [self addChildViewController:[[WXVoiceViewController alloc] init]];
    [self addChildViewController:[[WXPictureViewController alloc] init]];
    [self addChildViewController:[[WXWordViewController alloc] init]];
    
    // 2.将子控制器的view添加到scrollView
    NSInteger count = self.childViewControllers.count;
    for (NSInteger i = 0; i < count; i++) {
        // 取出子控制器的view并设置frame
        UIViewController *vc = self.childViewControllers[i];
        vc.view.wx_x = i * self.scrollView.wx_width;
        // TODO: UITableView默认的y值是20
//        vc.view.wx_y = 0;
        vc.view.wx_height = self.scrollView.wx_height;
        // 添加到scrollView对应位置
        [self.scrollView addSubview:vc.view];
        
    }
    
    // 3.设置scrollView的滚动范围
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.wx_width, 0);
//    self.automaticallyAdjustsScrollViewInsets = NO;
}

// ----------------------------------------------------------------------------
// 添加scrollView
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 设置scrollView的属性
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
}

// ----------------------------------------------------------------------------
// 设置标题栏
- (void)setupTitleView
{
    // 1.创建titleView
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    titleView.frame = CGRectMake(0, WXNavMaxY, screenW, WXTitlesViewH);
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    // 2.添加titleView的按钮
    [self setupTitleViewButtons];
    
    // 3.添加下划线
    [self setupUnderline];
}

// ----------------------------------------------------------------------------
// 添加标题栏按钮
- (void)setupTitleViewButtons
{
    // 按钮文字
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"文字"];
    
    NSInteger count = titles.count;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.titleView.wx_width / count;
    CGFloat btnH = self.titleView.wx_height;
    for (NSInteger i = 0; i < count; i++) {
        
        // 1.创建按钮,并设置属性
        WXTitleButton *button = [WXTitleButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 2.计算x值
        btnX = i * btnW;
        // 3.设置按钮的frame
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        // 4.添加到titleView
        [self.titleView addSubview:button];
    }
    
}

// ----------------------------------------------------------------------------
// 添加标题栏的下划线
- (void)setupUnderline
{
    // 1.创建下划线view
    UIView *underLineView = [[UIView alloc] init];
    WXTitleButton *firstButton = self.titleView.subviews.firstObject;
    CGFloat underLineH = 2;
    underLineView.frame = CGRectMake(0, self.titleView.wx_height - underLineH, 100, underLineH);
    underLineView.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    [self.titleView addSubview:underLineView];
    self.underLineView = underLineView;
    
    // 计算下划线的宽度,直接通过按钮Label的宽度
    [firstButton.titleLabel sizeToFit];
    underLineView.wx_width = firstButton.titleLabel.wx_width;
    underLineView.wx_centerX = firstButton.wx_centerX;
    
    // 设置默认选择
    firstButton.selected = YES;
    self.selectedButton = firstButton;
    
}

#pragma =======================================================================
#pragma mark - titleButton按钮点击
// ----------------------------------------------------------------------------
// 监听按钮点击
- (void)titleButtonClick:(WXTitleButton *)button
{
    // 切换中状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        // TODO: 设置下划线的宽度和中心点
        self.underLineView.wx_width = button.titleLabel.wx_width;
        self.underLineView.wx_centerX = button.wx_centerX;
        
        // 切换到对应的view
        self.scrollView.contentOffset = CGPointMake(self.scrollView.wx_width * button.tag, self.scrollView.contentOffset.y);
    }];
}

#pragma =======================================================================
#pragma mark - UIScrollViewDelegate代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 1.获取索引
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.wx_width;
    
    // 2.根据索引获取按钮
    WXTitleButton *titleButton = self.titleView.subviews[index];
    
    // 3.调用按钮的点击事件
    [self titleButtonClick:titleButton];
}


#pragma =======================================================================
#pragma mark - 设置导航条按钮
// ----------------------------------------------------------------------------
// 设置导航条按钮
- (void)setupNavigationItem
{
    // 1.设置导航条左侧游戏按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(gameBarButtonClick)];
    
    // 2.设置导航条右侧随机按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(randomBarButtonClick)];
    
    // 3.设置标题titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

// ----------------------------------------------------------------------------
// 监听导航条左侧游戏按钮点击
- (void)gameBarButtonClick
{
    WXFunc();
}

// ----------------------------------------------------------------------------
// 监听导航条左侧游戏按钮点击
- (void)randomBarButtonClick
{
    WXFunc();
}


@end
