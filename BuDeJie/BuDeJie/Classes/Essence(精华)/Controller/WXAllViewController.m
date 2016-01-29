//
//  WXAllViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/26.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXAllViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "WXTopicItem.h"
#import "WXTopicCell.h"

/** 下拉显示的header高度 */
static CGFloat const HeaderHeight = 44;
/** 上拉显示的footer高度 */
static CGFloat const FooterHeight = 35;

@interface WXAllViewController ()

/** 请求会话管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *mgr;
/** 数据源数组,存放服务器返回的cell列表数据 */
@property (nonatomic, strong) NSMutableArray *topics;
/** 用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;


// ----------------------------------------------------------------------------
// header
/** 头部刷新状态 */
@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;
/** 下拉刷新显示的view */
@property (nonatomic, weak) UIView *header;
/** 下拉刷新显示的view中的文字Label */
@property (nonatomic, weak) UILabel *headerLabel;

// ----------------------------------------------------------------------------
// footer
/** 尾部刷新状态 */
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;
/** 上拉刷新显示的view */
@property (nonatomic, weak) UIView *footer;
/** 上拉刷新显示的view中的文字Label */
@property (nonatomic, weak) UILabel *footerLabel;

@end

@implementation WXAllViewController


static NSString * const WXTopicCellId = @"WXTopicCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WXFunc();
    
    self.view.backgroundColor = WXRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(WXNavMaxY + WXTitlesViewH, 0, WXTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.rowHeight = 300;
    
    // 1.监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:WXTabBarButtonDidRepeatClickNotification object:nil];
    // 2.监听标题栏重复点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:WXTitleButtonDidRepeatClickNotification object:nil];
    
    // 3.刷新帖子列表
    [self setupRefresh];
    
    // 4.注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WXTopicCell class]) bundle:nil] forCellReuseIdentifier:WXTopicCellId];
}

#pragma =======================================================================
#pragma mark - 刷新帖子列表,请求帖子数据
// ----------------------------------------------------------------------------
// 刷新帖子列表
- (void)setupRefresh
{
    self.tableView.tableHeaderView = [[UISwitch alloc] init];
    // ------------------------------------------------------------------------
    // 下拉显示的view
    // 1.创建下拉时显示的header
    UIView *header = [[UIView alloc] init];
    header.frame = CGRectMake(0, -HeaderHeight, self.tableView.wx_width, HeaderHeight);
    header.backgroundColor = [UIColor redColor];
    self.header = header;
    [self.tableView addSubview:header];
    
    // 2.创建显示下拉可以刷新Label,并添加到tableView
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.text = @"下拉可以刷新";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.frame = header.bounds;
    headerLabel.backgroundColor = [UIColor yellowColor];
    self.headerLabel = headerLabel;
    [header addSubview:headerLabel];
    
    // ------------------------------------------------------------------------
    // 下拉显示的view
    // 1.创建下拉时显示的header
    UIView *footer = [[UIView alloc] init];
    footer.hidden = YES;
    footer.frame = CGRectMake(0, 0, self.tableView.wx_width, FooterHeight);
    header.backgroundColor = [UIColor redColor];
    self.footer = footer;
    self.tableView.tableFooterView = footer;
    
    // 2.创建显示下拉可以刷新Label,并添加到tableView
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.text = @"上拉可以刷新";
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.frame = footer.bounds;
    footerLabel.backgroundColor = [UIColor yellowColor];
    self.footerLabel = footerLabel;
    [footer addSubview:footerLabel];
    
}


// ----------------------------------------------------------------------------
// 请求帖子数据
- (void)loadNewTopics
{
    // 1.创建请求会话管理者 (采用懒加载)
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @1;
    
    // 3.发送请求
    [self.mgr GET:baseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 记录mactime,用来加载下一页数据
        self.maxtime = responseObject[@"info"][@"mactime"];
        
        // 2.1 解析服务器返回的数据
        self.topics = [WXTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 2.2 刷新列表
        [self.tableView reloadData];
        
        // 2.3 更新刷新状态
        self.headerRefreshing = NO;
        self.headerLabel.text = @"下拉可以刷新";
        self.headerLabel.backgroundColor = [UIColor yellowColor];
        
        // 2.4 动画回弹header到标题栏位置
        [UIView animateWithDuration:0.25 animations:^{
            UIEdgeInsets inset = self.tableView.contentInset;
            inset.top -= self.header.wx_height;
            self.tableView.contentInset = inset;
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 2.3 更新刷新状态
        self.headerRefreshing = NO;
        self.headerLabel.text = @"下拉可以刷新";
        self.headerLabel.backgroundColor = [UIColor yellowColor];
        
        // 2.4 动画回弹header到标题栏位置
        [UIView animateWithDuration:0.25 animations:^{
            UIEdgeInsets inset = self.tableView.contentInset;
            inset.top -= self.header.wx_height;
            self.tableView.contentInset = inset;
        }];
        
        // 取消任务的错误编码：-999
        // 找不到服务器的错误编码：-1003
        // 所有的URL错误编码都可以在NSURLError.h中找到
        if (error.code == NSURLErrorCancelled) {
            // 如果是取消操作,不弹窗报错
            return;
        }
        
        // 弹窗提示错误
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
    }];
}

// ----------------------------------------------------------------------------
// 请求更多的帖子数据
- (void)loadMoreTopics
{
    // 1.取消当前所有任务,避免通知进行两个请求时,造成缺失部分数据
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @1;
    parameters[@"maxtime"] = self.maxtime;
    
    // 3.发送请求
    [self.mgr GET:baseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 1.存储maxtime,用于获取下一页数据
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 2.追加数据
        NSArray *moreTopics = [WXTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        // 3.刷新数据
        [self.tableView reloadData];
        
        // 4.更新状态
        self.footerRefreshing = NO;
        self.footerLabel.text = @"上拉可以加载更多";
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 更新状态
        self.footerRefreshing = NO;
        self.footerLabel.text = @"上拉可以加载更多";
        NSLog(@"%@", error);
    }];
}


#pragma =======================================================================
#pragma mark - 监听tabBarButton和titleButton重复点击
// ----------------------------------------------------------------------------
// 监听tabBarButton重复点击通知
- (void)tabBarButtonDidRepeatClick
{
    // 如果控制器的view不在window上,则直接返回
    if (self.view.window == nil) {
        return;
    }
    
    // 如果控制器的view没有和window重叠,则直接返回
    if (![self.view wx_intersectWithView:nil]) {
        return;
    }
    
    NSLog(@"%@: 重复点击，执行下拉刷新", [self class]);
}

// ----------------------------------------------------------------------------
// 监听tabBarButton重复点击通知
- (void)titleButtonDidRepeatClick
{
    [self tabBarButtonDidRepeatClick];
}


- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma =======================================================================
#pragma mark - UITableViewDataSource数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 如果tableView有数据,则显示footer,否则隐藏
    self.footer.hidden = (self.topics.count == 0);
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WXTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:WXTopicCellId];
    
    cell.topicItem = self.topics[indexPath.row];
    
    return cell;
}



#pragma =======================================================================
#pragma mark - 懒加载
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}

#pragma =======================================================================
#pragma mark - UIScrollViewDelegate

// ----------------------------------------------------------------------------
// 停止拖拽是调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 1.判断如果正在请求刷新,直接返回
    if (self.isHeaderRefreshing) {
        return;
    }
    
    // 2.获取完全显示时的偏移量
    CGFloat offsetY = -(self.tableView.contentInset.top + self.header.wx_height);
    
    // 3.判断如果header已经完全显示(偏移量y值 <= offsetY),则请求数据
    if (self.tableView.contentOffset.y <= offsetY) {
        
        // 1.更新为刷新状态
        self.headerRefreshing = YES;
        self.headerLabel.text = @"正在刷新数据";
        self.headerLabel.backgroundColor = [UIColor greenColor];
        
        // 2.设置内边距慢慢变化到标题栏下,否则手松开时,会有弹跳
        [UIView animateWithDuration:0.25 animations:^{
            UIEdgeInsets inset = self.tableView.contentInset;
            inset.top += self.header.wx_height;
            self.tableView.contentInset = inset;
        }];
        
        // 3.发送请求
        [self loadNewTopics];
    }
}

// ----------------------------------------------------------------------------
// 拖拽时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.处理header
    [self dealHeader];
    
    // 2.处理footer
    [self dealFooter];
}

// ----------------------------------------------------------------------------
// 处理dealHeader
- (void)dealHeader
{
    if (self.header == nil) {
        return;
    }
    
    // 如果当前正在刷新,无需重复调用,直接返回
    if (self.isHeaderRefreshing) {
        return;
    }
    
    // 当偏移量的y值 <= offsetY ,header完全显示
    CGFloat offsetY = -(self.tableView.contentInset.top + self.header.wx_height);
    
    if (self.tableView.contentOffset.y <= offsetY) {
        self.headerLabel.text = @"松开立即刷新";
        self.headerLabel.backgroundColor = [UIColor yellowColor];
    }else {
        self.headerLabel.text = @"下拉可以刷新刷新";
        self.headerLabel.backgroundColor = [UIColor redColor];
    }
}

- (void)dealFooter
{
    // 1.如果当前tableView没有数据,直接返回
    if (self.topics.count == 0) {
        return;
    }
    
    // 2.如果当前正在刷新,直接返回
    if (self.footerRefreshing) {
        return;
    }
    
    // 3.当偏移量 >= offsetY时，footer就已经完全出现
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.wx_height;
    if (self.tableView.contentOffset.y >= offsetY) {
        // 更新状态
        self.footerRefreshing = YES;
        self.footerLabel.text = @"正在加载更多数据";
        
        // 延迟模拟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 发送请求
            [self loadMoreTopics];
        });
    }
}




@end
