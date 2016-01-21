//
//  WXSubTagViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/21.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXSubTagViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "WXSubTagItem.h"
#import "WXSubTagCell.h"

// ----------------------------------------------------------------------------
// 基本Url
static NSString * const WXBaseUrl = @"http://api.budejie.com/api/api_open.php";

@interface WXSubTagViewController ()

/** 推荐标签数据源 */
@property (nonatomic, strong) NSArray *subTags;

/** 会话管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *mgr;

@end

@implementation WXSubTagViewController

static NSString * const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置标题
    self.navigationItem.title = @"推荐标签";
    
    // 2.获取推荐标签数据
    [self loadData];
    
    // 3.注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WXSubTagCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    // 4.设置分割线
    [self setupSeparatorLine];
}

// ----------------------------------------------------------------------------
// 设置分割线,需在cell内部将cell高度-1,这样让漏出的背景充当分割线
- (void)setupSeparatorLine
{
    // 分割线: 1.自定义分割线 2.利用系统属性 3.重写cellsetFrame
    // 4.取消系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置tableView背景色,之后将cell的高度-1,漏出的背景充当分割线
    self.tableView.backgroundColor = WXColor(206, 206, 206);
}

#pragma =======================================================================
#pragma mark - 加载推荐标签网络数据,取消网络请求任务
// ----------------------------------------------------------------------------
// 加载推荐标签网络数据
- (void)loadData
{
    // 1.创建AFN请求会话管理者
    self.mgr = [AFHTTPSessionManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    // 2.1 显示指示器
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    
    // 3.发送请求
    [self.mgr GET:WXBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 3.1 字典转模型,服务器返回数据是字典数组 ,mj_objectArrayWithKeyValuesArray直接将字典数组转模型数组
        self.subTags = [WXSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        // 3.2 刷新tableView
        [self.tableView reloadData];
        
        // 3.3 隐藏指示器
//        sleep(2);     // 模拟网络环境慢
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        NSLog(@"%@", error);
    }];
}

// ----------------------------------------------------------------------------
// 取消网络请求任务, 控制器的view即将消失的时候调用
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 取消所有网络任务
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 隐藏指示器
    [SVProgressHUD dismiss];
}


#pragma =======================================================================
#pragma mark - UITableViewDataSource
// ----------------------------------------------------------------------------
// 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.subTags.count;
}

// ----------------------------------------------------------------------------
// 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    WXSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 设置模型数据
    cell.item = self.subTags[indexPath.row];
    
    return cell;
}

// ----------------------------------------------------------------------------
// 设置cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
