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

// ----------------------------------------------------------------------------
// 添加子控制器
- (void)setupAllChildViewController
{
    // 1.添加5个子控制器
//    [self addChildViewController:[[WXAllViewController alloc] init]];
//    [self addChildViewController:[[WXVideoViewController alloc] init]];
//    [self addChildViewController:[[WXVoiceViewController alloc] init]];
//    [self addChildViewController:[[WXPictureViewController alloc] init]];
//    [self addChildViewController:[[WXWordViewController alloc] init]];
    
    // 方法二: 添加子控制器
    WXAllViewController *allVc = [[WXAllViewController alloc] init];
    allVc.type = WXTopicTypeAll;
    [self addChildViewController:allVc];
    
    WXVideoViewController *videoVc = [[WXVideoViewController alloc] init];
    videoVc.type = WXTopicTypeVideo;
    [self addChildViewController:videoVc];
    
    WXVoiceViewController *voiceVc = [[WXVoiceViewController alloc] init];
    voiceVc.type = WXTopicTypeVoice;
    [self addChildViewController:voiceVc];
    
    WXPictureViewController *pictureVc = [[WXPictureViewController alloc] init];
    pictureVc.type = WXTopicTypePicture;
    [self addChildViewController:pictureVc];
    
    WXWordViewController *wordVc = [[WXWordViewController alloc] init];
    wordVc.type = WXTopicTypeWord;
    [self addChildViewController:wordVc];
    
    
    
    // 2.获取子控制器数量
    NSInteger count = self.childViewControllers.count;
    // 设置默认显示第0个子控制器的view
    [self addChildVcViewIntoScrollView:0];
    // 3.设置scrollView的滚动范围
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.wx_width, 0);
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
    self.automaticallyAdjustsScrollViewInsets = NO;
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
    // 判断标题栏的按钮titleButton重复点击
    if (self.selectedButton == button) {
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:WXTitleButtonDidRepeatClickNotification object:nil];
    }
    
    // 处理标题按钮、下划线、scrollView
    [self dealTitleButtonClick:button];
}

// ----------------------------------------------------------------------------
// 处理标题按钮、下划线、scrollView
- (void)dealTitleButtonClick:(WXTitleButton *)button
{
    // 切换中状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    // 1.获取索引,按钮的tag值
    NSInteger index = button.tag;
    
    // 2.执行下划线动画,动画执行完成修改scrollView的偏移量,显示对应子控制器的view
    [UIView animateWithDuration:0.25 animations:^{
        
        // TODO: 设置下划线的宽度和中心点
        self.underLineView.wx_width = button.titleLabel.wx_width;
        self.underLineView.wx_centerX = button.wx_centerX;
        
        // 切换到对应的view
        self.scrollView.contentOffset = CGPointMake(self.scrollView.wx_width * index, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        // 更新偏移量
        CGPoint offset = self.scrollView.contentOffset;
        offset.x = index * self.scrollView.wx_width;
        [self.scrollView setContentOffset:offset];
        
        // 添加对应子控制器的view
        [self addChildVcViewIntoScrollView:index];
    }];
}

// ----------------------------------------------------------------------------
// 添加index位置对应的子控制器view到scrollView
- (void)addChildVcViewIntoScrollView:(NSInteger)index
{
    // 1.根据索引获取子控制器
    UIViewController *childVc = self.childViewControllers[index];
    
    // TODO: 2.判断子控制器的view是否已经加载过,如果已经加载过,退出
    // 方法一: childVc.isViewLoaded 方法二: childVc.view.superview 方法三: childVc.view.window
    if (childVc.isViewLoaded) {
        return;
    }
    
    // 3.设置要添加的子控制器view的frame,并添加到scrollView
    // 3.1 设置x值
    childVc.view.wx_x = index * self.scrollView.wx_width;
    // 3.2 需将y设置为0,因为childVc.view是UITableView,UITableView默认的y值是20
    childVc.view.wx_y = 0;
    // 3.3 默认UITableView的高度是屏幕的高度减去它本身的y值(20),所以重新设置高度为整个scrollView的高度
    childVc.view.wx_height = self.scrollView.wx_height;
    // 3.4 添加子控制器的view到scrollView
    [self.scrollView addSubview:childVc.view];
}

// ----------------------------------------------------------------------------
// 使用偏移量计算索引,实现添加子控制器view到scrollView,该方法只能通过偏移量来控制要显示那个view,灵活性不够 (不推荐,因为其依赖偏移量)
- (void)addChildVcViewIntoScrollView
{
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.wx_width;
    UIViewController *childVc = self.childViewControllers[index];
    
    if (childVc.isViewLoaded) {
        return;
    }
    
    childVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVc.view];
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
    [self dealTitleButtonClick:titleButton];
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
