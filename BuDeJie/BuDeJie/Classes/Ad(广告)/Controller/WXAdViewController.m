//
//  WXAdViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/20.
//  Copyright © 2016年 liwx. All rights reserved.
//

/**
 广告接口Url:
http://mobads.baidu.com/cpro/ui/mads.php?code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam
 
 服务器返回的json数据:
 
{
    "iap_buy": 0,
    "ad": [
           {
               "fwt": 2,
               "id": 3670013,
               "src": "mob",
               "tit": "",
               "desc": "",
               "w_picurl": "http://ubmcmm.baidustatic.com/media/v1/0f000PogpUPfn93TOn0Qif.jpg",
               "iv": 0,
               "dur": 16777215,
               "phone": "",
               "sound": 0,
               "surl": "qmqj2.xy.com",
               "exp2": {},
               "anti_tag": 1,
               "curl": "http://mobads.baidu.com/ad.html?url=http%3A%2F%2Fqmqj2%2Exy%2Ecom%2Fidf%2FrFs5hf%3F__mobads_curl_check%3D1614224743%26exp_id%3Dto%2Cdj-1%2Cyc%2Cts%2Cfs%2Cld%2Cqx-2%2Cfc%2Cpz%2Ccpa-210%2C%26new_exp_ids%3D70101%2C70111%2C70700%2C70701%2C70704%2C70714%2C70720%2C71000%2C71001%2C71005%2C71200%2C72016%2C72024%26__mobads_clickid%3DuHcYrj0LuHNxn1mLnj0kndqjnjFDnHFAnzY1nRm3QHfvf1cVfRcknzY1njF7njDYfRPDwbR%26__mobads_charge%3Dn1mLnj0kn1_zrHc1nHReP1mznW6znj_vrHn4n1_znj0snj_kr1ceuHcYrj0LuHNxmLKzrvRzPj6sPvRdrYnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwHVGULnVri3zrv7sTAk-Qy-fpAq8uHT_nBmhnHDhFWDvnBmhFBmYPW0sPzmhnimhTMPsUA71pamhnimhnH0sFBmkFBmsFBms%26__mobads_ta%3DmLwzrWDznj0_mywJIgPYrW0%26__mobads_qk%3D569edc662d97da73%26qtm%3D1453251686%26__mobads_dc_stat%3DTLPs5HFtIgw4TARqnZkhUWdtuh4z5HKtIAYqnZkYIHYznj03rjbzxZwb5HKtIgF_5gkWpjdtuZPspyfqPMksUA7WuNqGujYsxAw-Ih-WuNqGujYzxAFzmy4b5y7sTAk-xZKzpyP-gv-b5HFtuh-zTLwxIZF9uARqn1ItTvNWUv4bgLwzmyw-5HnLnjutUhNYgLw4TANxpyfqngk9IAqVgv-b5HKtUAF1gv-b5HKtUAF1gLw4TARqnZkGI7qGujYsxA7bgLnqPHm4uywWPWmzujbLuADLnLkETdqGujYkQHb8nMkVuywGmNqYXgK-5HKtTvNWgvwEUy7GUWdbuyu9IykYxAFdTv-8ugP1gv-b5HKtuA-1IZFGmLwxpyfqnZkWIy-b5gskTLwxIAqspynqnZszUhwxIAqspynqnZs1ThwxIAqspynqnZk9uAP_mgP15HfvxAI-Uhw-TWYsxA7MuHYsxAd9TMFGmyI-5HKtuh-zTLwxpgfqnZk1uyPEUhwxpgfqnZk9TZK_pgPYgv-b5HKtmgKsmv7YuNqGujYsxZwzpyIMugFxpgwxIA7MT1dtTvwogLmqnMkdTvNzgLw4TARqnZkzug7xTAVM5yPEUi4Jpy4MUA-8uz4BTLPJxAI-UdqsThqv5HwtuvNEgvPGIZbqrjwtmyPYpgu-gv7sTjYsxA7WIA-vuNqWmgw-uvqzXHYsxZI9UAkxTAqGUMfqnZk9UhwzUv-bgv-b5f%26__mobads_acct%3Dsdk%26exchtp%3D0%26chmod%3D0%26schmod%3D0%26price%3D20000%26sprice%3D20000%26match_code%3D0",
               "ori_curl": "http://qmqj2.xy.com/idf/rFs5hf",
               "w": 640,
               "h": 960,
               "winurl": "http://wn.pos.baidu.com/adx.php?c=cz01NjllZGM2NjJkOTdkYTczAHQ9MTQ1MzI1MTY4NgBzZT0yAGJ1PTYAcHJpY2U9VnA3Y1pnQUlzbFo3akVwZ1c1SUE4c0ZXWk5xZ2RzZ2M4X3NydUEAY2htZD0wAHdpPTYAYmRpZD0AY3Byb2lkPQB3bmlkPTU2OWVkYzY2MmQ5N2RhNzMAdj0xAGk9MjdhMmIyNDc&ext=ZmNfdWlkPUMwMkQxMkYzLTMxRjgtNDZDMi1BQjEzLTMwMkUwMTRBQ0RGRSZmY19paWQ9MjkyMzE1JmZjX2V4PTY0NzE0JmZjX2xvPW5q",
               "clklogurl": "",
               "bid": "",
               "ad_charge": 1,
               "adtd": 0,
               "type": "image",
               "actt": 0,
               "act": 1,
               "wb": "",
               "sms": "",
               "theme": "",
               "wi": 1,
               "sk": "",
               "cf": {},
               "sb": 0,
               "pk": "",
               "qk": "0037fffd569edc662d97da73",
               "sz": 0,
               "pict": 1,
               "styt": 0
           }
           ],
    "n": 1,
    "req_id": "",
    "error_code": 0,
    "interval": 0,
    "mode": 0,
    "province": 4,
    "city": 84,
    "x": 0,
    "y": 0, 
    "impt": "", 
    "clkt": "", 
    "exp2": {}, 
    "theme": "new-1-4", 
    "m": 0, 
    "u": ""
}
 */

#import "WXAdViewController.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import "WXTabBarController.h"
#import "WXAdItem.h"

static NSString * const code2 = @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam";

@interface WXAdViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) WXAdItem *adItem;
@end

@implementation WXAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置启动图片,屏幕适配
    [self setupLaunchImageView];
    
    // 2.请求广告数据
    [self loadAdData];
    
    // 3.创建定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [self timeChange];
}

#pragma =======================================================================
#pragma mark - 启动图片屏幕适配,请求广告数据,定时器

// ----------------------------------------------------------------------------
// 设置启动图片,屏幕适配,根据屏幕的高度
- (void)setupLaunchImageView
{
    UIImage *image = nil;
    // ------------------------------------------------------------------------
    // 适配启动背景图片
    if (iPhone4) {
        image = [UIImage imageNamed:@"LaunchImage"];
    } else if (iPhone5) {
        image = [UIImage imageNamed:@"LaunchImage-568h"];
    } else if (iPhone6) {
        image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iPhone6p) {
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }
    
    // 设置启动背景图片
    self.launchImageView.image = image;
}

// ----------------------------------------------------------------------------
// 请求广告数据
- (void)loadAdData
{
    // ------------------------------------------------------------------------
    // 1.创建请求回话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // ------------------------------------------------------------------------
    // 2.设置响应体的数据格式,添加@"text/html"
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    manager.responseSerializer = serializer;
    
    // ------------------------------------------------------------------------
    // 3.拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    
    // ------------------------------------------------------------------------
    // 4.请求广告数据
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 判断取回来的数据是否正确
        
        // 4.1 获取广告数据 ,返回的广告数据是数组,有[],所以要用lastObject取出数据
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        
        // 判断是否请求到数据,如果没有数据,则退出
        if (adDict == nil) {
            return;
        }
        // 4.2 字典转模型 mj_objectWithKeyValues:方法作用是将字典转换成对应的模型
        WXAdItem *adItem = [WXAdItem mj_objectWithKeyValues:adDict];
        self.adItem = adItem;
        
        // 4.3 设置广告界面的数据,返回数据中有广告图片的尺寸
        CGFloat w = screenW;
        // NaN:除以0, 不等于0才可以除
        if (adItem.w) {
            
            // 计算宽高比例
            CGFloat h = screenW / adItem.w * adItem.h;
            UIImageView *adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
            [adImageView sd_setImageWithURL:[NSURL URLWithString:adItem.w_picurl]];
            [self.adView addSubview:adImageView];
            adImageView.userInteractionEnabled = YES;
            
            // 4.4 添加点击手势,点击图片跳转到广告页
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
            [adImageView addGestureRecognizer:tap];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
  
}

// ----------------------------------------------------------------------------
// 定时更新按钮的标题,定时时间到则跳转
- (void)timeChange
{
    static NSInteger timeIndex = 0;
    // 更新跳过按钮标题
    [self.jumpButton setTitle:[NSString stringWithFormat:@"跳过 (%ld)", timeIndex] forState:UIControlStateNormal];
    
    if (timeIndex-- < 0) {
        [self.timer invalidate];
        [self jump];
    }
    
}


#pragma =======================================================================
#pragma mark - 跳过按钮点击, 点击广告图片跳转
// ----------------------------------------------------------------------------
// 监听点击跳过按钮
- (IBAction)jump {
    
    // 关闭定时器
    [self.timer invalidate];
    
    WXTabBarController *tabBarVc = [[WXTabBarController alloc] init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
}

// ----------------------------------------------------------------------------
// 监听广告图片点击
- (void)tap
{
    // 检查url是否能打开
    NSURL *url = [NSURL URLWithString:self.adItem.ori_curl];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.adItem.ori_curl]];
    }
}


@end
