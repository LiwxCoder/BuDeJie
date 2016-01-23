//
//  WXMeViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/18.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXMeViewController.h"
#import "WXSettingController.h"
#import "WXSquareItem.h"
#import "WXSquareCell.h"
#import "WXWebViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SafariServices/SafariServices.h>

// ----------------------------------------------------------------------------
// 常量和宏
static NSString * const ID = @"cell";
static NSInteger const colCount = 4;
static CGFloat const margin = 1;
#define cellWH ((screenW - margin * (colCount - 1)) / colCount)


@interface WXMeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, SFSafariViewControllerDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;

/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray<WXSquareItem *> *squareList;
@end

@implementation WXMeViewController


#pragma =======================================================================
#pragma mark - 系统方法重写
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor orangeColor];
    // 1.设置导航条按钮
    [self setupNavigationItem];
    // 2.设置标题
    [self setupTitle];
    
    // 3.添加tableFooterView
    [self setupTableFooterView];
    
    // 4.设置tableView的分组间距(调整分组的头部尾部间距), 最顶部高度为35,通过设置内边距将最顶部间距设置为10
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    // 5.请求cell数据
    [self loadData];
}


#pragma =======================================================================
#pragma mark - 初始化设置

// ----------------------------------------------------------------------------
// 设置标题
- (void)setupTitle
{
    self.navigationItem.title = @"我的";
}

// ----------------------------------------------------------------------------
// 设置导航条按钮
- (void)setupNavigationItem
{
    // 设置导航条右侧设置按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingBarButtonClick)];
    
    // 设置导航条右侧月亮按钮
    UIBarButtonItem *nightItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(nightBarButtonClick:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, nightItem];
}

// ----------------------------------------------------------------------------
// 设置底部tableFooterView
- (void)setupTableFooterView
{
    // ------------------------------------------------------------------------
    // 1.创建流水布局,设置cell的尺寸和行列最小间距
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(cellWH, cellWH);
    flowLayout.minimumLineSpacing = margin;
    flowLayout.minimumInteritemSpacing = margin;
    
    // ------------------------------------------------------------------------
    // 2.创建collectionView,设置collectionView的属性
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 00) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = WXColor(206, 206, 206);
    collectionView.scrollEnabled = NO;
    self.collectionView = collectionView;
    
    // 3.设置collectionView的数据源和代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.tableView.tableFooterView = collectionView;
    
    // ------------------------------------------------------------------------
    // 4.注册cell
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WXSquareCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma =======================================================================
#pragma mark - 请求网络数据,处理数据
// ----------------------------------------------------------------------------
// 请求cell网络数据
- (void)loadData
{
    // 1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    // 3.发送请求
    [mgr GET:baseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 3.1 字典数组转模型数组
        self.squareList = [WXSquareItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        // 3.2 处理请求的数据
        [self resolveData];
        
        // 3.3 刷新表格
        [self.collectionView reloadData];
        
        // 3.4 计算collectView的高度
        NSInteger count = self.squareList.count;
        // 3.4.1 计算行数
        NSInteger row = (count - 1) / colCount + 1;
        CGFloat collectionViewH = row * cellWH;
        self.collectionView.wx_height = collectionViewH;
        
        
        // TODO: 3.5 重新设置tableFooterView的显示内容,如果重新设置,会导致拖动到最底部cell会自动回弹
        self.tableView.tableFooterView = self.collectionView;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

// ----------------------------------------------------------------------------
// 处理请求的数据
- (void)resolveData
{
    // 如果数据不是4的倍数,添加到4的倍数.主要是用于补齐格子,不然未填充的格子会变成灰色的效果.
    NSInteger count = self.squareList.count;
    NSInteger extre = count % colCount;
    if (extre) {
        for (NSInteger i = 0; i < colCount - extre ; i++) {
            WXSquareItem *item = [[WXSquareItem alloc] init];
            [self.squareList addObject:item];
        }
    }
}

#pragma =======================================================================
#pragma mark - UICollectionViewDataSource数据源, UICollectionViewDelegate代理方法
// ----------------------------------------------------------------------------
// 返回cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareList.count;
}

// ----------------------------------------------------------------------------
// 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WXSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.item = self.squareList[indexPath.row];
    
    return cell;
}

// ----------------------------------------------------------------------------
// TODO: 展示网页的几种方式

// 展示网页:1.webView 2.openUrl 3.WKWebView
// webView:没有自带功能,好处,就在当前应用下展示网页,webView不能监听进度条
// safari:自带了很多功能,弊端:必须要跳转到其他应用
// 在当前应用下展示网页,但是有safari功能,自定义view,进度条,前进,后退,刷新功能,网址
// iOS9 SFSafariViewController:具备safari功能,并且可以在当前应用下展示网页
// 只能在iOS9使用
// 1.首先导入一个框架#import <SafariServices/SafariServices.h>

// WebKit:跟WebView,能监听进度条,iOS8
// ----------------------------------------------------------------------------
// 监听cell的点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.处理点击闪烁
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cell.selected = NO;
    });
    
    // 2.获取模型数据
    WXSquareItem *item = self.squareList[indexPath.row];
    
    // 3.跳转到控制器
    if ([item.url hasPrefix:@"http:"]) {
        
        // 3.1 WKWebView展示网页
        WXWebViewController *webVc = [[WXWebViewController alloc] init];
        webVc.url = [NSURL URLWithString:item.url];
        [self.navigationController pushViewController:webVc animated:YES];
        
        // --------------------------------------------------------------------
        // TODO: SFSafariViewController实现浏览展示网页
        // 3.1 创建Safari网页控制器 iOS9才能用
//        SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:item.url]];
//        safariVc.delegate = self;
//        
//        // 3.2 跳转网页控制器
//        [self presentViewController:safariVc animated:YES completion:nil];
//        safariVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:safariVc animated:YES];
    }
}

#pragma =======================================================================
#pragma mark - SFSafariViewControllerDelegat代理协议

// ----------------------------------------------------------------------------
// TODO: SFSafariViewController 监听Safari点击完成按钮
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller
{
    WXFunc();
}

// ----------------------------------------------------------------------------
// TODO: SFSafariViewController 监听Safari初始化载入完成
- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully
{
    NSLog(@"%s %d", __func__, didLoadSuccessfully);
}

#pragma =======================================================================
#pragma mark - 监听导航条按钮点击事件
// ----------------------------------------------------------------------------
// 监听导航条右侧设置按钮点击
- (void)settingBarButtonClick
{
    // 1.创建设置控制器
    WXSettingController *settingVc = [[WXSettingController alloc] init];
    // 2.设置settingVc控制器跳转时隐藏tabBar,一定要在跳转前设置
    settingVc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:settingVc animated:YES];
}

// ----------------------------------------------------------------------------
// 监听导航条右侧月亮按钮点击
- (void)nightBarButtonClick:(UIButton *)button
{
    button.selected = !button.isSelected;
    WXFunc();
}

#pragma =======================================================================
#pragma mark - 懒加载
- (NSMutableArray<WXSquareItem *> *)squareList
{
    if (_squareList == nil) {
        _squareList = [NSMutableArray array];
    }
    return _squareList;
}

@end
