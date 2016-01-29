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
#import "WXTopicItem.h"

@interface WXAllViewController ()

/** 请求会话管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *mgr;

/** 数据源数组,存放服务器返回的cell列表数据 */
@property (nonatomic, strong) NSMutableArray *topics;

@end

@implementation WXAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WXFunc();
    
    self.view.backgroundColor = WXRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(WXNavMaxY + WXTitlesViewH, 0, WXTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 1.监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:WXTabBarButtonDidRepeatClickNotification object:nil];
    // 2.监听标题栏重复点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:WXTitleButtonDidRepeatClickNotification object:nil];
    
    // 3.请求帖子数据
    [self loadNewTopics];
}

#pragma =======================================================================
#pragma mark - 请求帖子数据
// ----------------------------------------------------------------------------
// 请求帖子数据
- (void)loadNewTopics
{
    // 1.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    
    // 2.发送请求
    [self.mgr GET:baseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 2.1 解析服务器返回的数据
        self.topics = [WXTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 2.2 刷新列表
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static UIColor *bgColor = nil;
    if (bgColor == nil) {
        bgColor = WXRandomColor;
    }
    
    static NSString * const ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = bgColor;
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    WXTopicItem *item = self.topics[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.text;
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:item.profile_image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    [cell setValue:imageView forKeyPath:@"imageView"];
    
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



@end
