//
//  WXAllViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/26.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXAllViewController.h"
#import "WXHTTPSessionManager.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "WXTopicItem.h"
#import "WXTopicCell.h"
#import "WXRefreshHeader.h"
#import "WXRefreshFooter.h"

@interface WXAllViewController ()

/** 请求会话管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *mgr;
/** 数据源数组,存放服务器返回的cell列表数据 */
@property (nonatomic, strong) NSMutableArray<WXTopicItem *> *topics;
/** 用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;

@end

@implementation WXAllViewController

static NSString * const WXTopicCellId = @"WXTopicCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WXFunc();
    
    self.view.backgroundColor = WXRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(WXNavMaxY + WXTitlesViewH, 0, WXTabBarH, 0);
    // 设置滚动条在滚动视图中的位置(滚动条的内边距)
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = WXColor(206, 206, 206);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    // 下拉显示的view,程序进入默认刷新
    self.tableView.mj_header = [WXRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];

    // ------------------------------------------------------------------------
    // 下拉显示的view
    self.tableView.mj_footer = [WXRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
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
    parameters[@"type"] = @(WXTopicTypeVoice);
    
    
    // 3.发送请求
    [self.mgr GET:baseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 记录mactime,用来加载下一页数据
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 2.1 解析服务器返回的数据
        self.topics = [WXTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 2.2 刷新列表
        [self.tableView reloadData];
        
        // 2.3 更新刷新状态
        [self.tableView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 2.3 更新刷新状态
        [self.tableView.mj_header endRefreshing];
        
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
    parameters[@"type"] = @(WXTopicTypeAll);
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
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 更新状态
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"%@", error);
    }];
}


#pragma =======================================================================
#pragma mark - 监听tabBarButton和titleButton重复点击
// ----------------------------------------------------------------------------
// 监听tabBarButton重复点击通知
- (void)tabBarButtonDidRepeatClick
{
    // ------------------------------------------------------------------------
    // 1.判断控制器的view有没有在window上,有没有和window重叠
    // 如果控制器的view不在window上,则直接返回
    if (self.view.window == nil) return;
    
    // 如果控制器的view没有和window重叠,则直接返回
    if (![self.view wx_intersectWithView:nil]) return;
    
    // ------------------------------------------------------------------------
    // 2.重复点击，执行下拉刷新
    [self.tableView.mj_header beginRefreshing];
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
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WXTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:WXTopicCellId];
    
    cell.topicItem = self.topics[indexPath.row];
    
    return cell;
}

// ----------------------------------------------------------------------------
// 通过模型数据计算cell高度,并设置对应cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WXTopicItem *item = self.topics[indexPath.row];
    NSLog(@"heightForRowAtIndexPath - %02ld", indexPath.row);
    return item.cellHeight;
}


#pragma =======================================================================
#pragma mark - 懒加载
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [WXHTTPSessionManager manager];
    }
    return _mgr;
}

@end
