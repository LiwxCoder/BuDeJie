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
#import <Photos/Photos.h>

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
    // scrollView添加手势,实现点击图片或其他位置,退出控制器
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
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
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topicItem.large_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
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
#pragma mark - 获得自定义相册,相机胶卷相册
// ----------------------------------------------------------------------------
// 获得自定义相册,相机胶卷相册测试, 仅作为测试
- (void)getAssetCollections
{
    // 获得所有自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        WXLog(@"%@", collection.localizedTitle);
    }
    
    // 获得相机胶卷相册
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].firstObject;
    WXLog(@"%@", cameraRoll.localizedTitle);
}

#pragma =======================================================================
#pragma mark - 监听返回,保存按钮点击

- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save
{
    // ------------------------------------------------------------------------
    // 使用Photos框架的PHPhotoLibrary查询授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    switch (status) {
        // --------------------------------------------------------------------
        // User has not yet made a choice with regards to this application
        // 用户还没有对当前App进行授权（还没有弹框让用户做过选择）
        case PHAuthorizationStatusNotDetermined: {
            // 如果用户还没有对当前应用进行授权,首次要操作系统相册,系统会自动弹出授权的选项让用户选择
            // 用户做出选择会调用block
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus justNowStatus) {
                if (justNowStatus == PHAuthorizationStatusDenied) {
                    WXLog(@"用户选择了Don't Allow");
                } else if (justNowStatus == PHAuthorizationStatusAuthorized) {
                    // 如果用户选择OK,则保存图片到相册
                    [self saveImage];
                }
            }];
            break;
        }
        
        // --------------------------------------------------------------------
        // User has explicitly denied this application access to photos data.
        // 用户不允许当前App访问相册（之前在弹框时，用户点击了“Don't Allow”\“不允许”）
        case PHAuthorizationStatusDenied: {
            // 提醒用户打开相册的访问开关：设置-隐私-照片-App名字
            [SVProgressHUD showInfoWithStatus:@"请手动授权相册访问权限!\n设置-隐私-照片-APP名字"];
            break;
        }
         
        // --------------------------------------------------------------------
        // User has authorized this application to access photos data.
        // 用户允许当前App访问相册（之前在弹框时，用户点击了“OK”\“好”）
        case PHAuthorizationStatusAuthorized: {
            // 保存图片到相册
            [self saveImage];
            break;
        }
            
        // --------------------------------------------------------------------
        // This application is not authorized to access photo data.
        // The user cannot change this application’s status, possibly due to active restrictions such as parental controls being in place.
        // 系统级别的限制，导致当前App无法访问相册（用户也无法改变这种状态）
        case PHAuthorizationStatusRestricted: {
            [SVProgressHUD showErrorWithStatus:@"因为系统原因，无法保存图片！"];
            break;
        }
    }
    
}

- (void)saveImage
{
    NSError *error = nil;
    
    // ------------------------------------------------------------------------
    // 1.保存图片到【Camera Roll（相机胶卷）】中
    __block NSString *assetId = nil;
    // performChangesAndWait方法中的block是同步执行的
    // 1.1 获取要保存的图片的占位标识,保存图片到相机胶卷
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 此处只是创建占位标识,并不能获取到PHAsset图片对象,必须等这个block执行完成后才能获取到PHAsset图片对象.
        // 执行完block会保存图片到相机胶卷(Camera Roll主相册).
        assetId  = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    // 1.2 通过占位标识获取PHAsset图片对象,目的是为了后面关联到自定义相册.
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil];

    
    // ------------------------------------------------------------------------
    // 2.创建【自定义相册】,名称为App的名称
    // 2.1 获得App的名称
    NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];
    // 2.2 检测有没有创建过相册
    PHAssetCollection *createCollection = nil;
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历查找是否已经存在App名称的相册,
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            // 查找到已经存在App名称的相册,退出遍历
            createCollection = collection;
            break;
        }
    }
    
    // 2.3 判断有没有创建过相册
    if (createCollection == nil) {
        // 还没创建过App相册,创建自定义App名称的相册
        __block NSString *collectionId = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            // 获取相册的占位标识
            collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
        } error:&error];
        
        // 2.4 通过相册占位标识获取相册对象,目的是为了后面关联到自定义相册.
        createCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
    }
    
    // ------------------------------------------------------------------------
    // 3.将刚才保存到【Camera Roll（相机胶卷）】中的图片，引用（添加）到【自定义相册】
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 通过创建的相册对象创建PHAssetCollectionChangeRequest对象
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createCollection];
        // 使用PHAssetCollectionChangeRequest对象为图片对象和自定义App名称的相册对象添加关联
        [request insertAssets:assets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    
    // ------------------------------------------------------------------------
    // 提示保存成功/失败
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}

// ----------------------------------------------------------------------------
// Photos框架使用说明

/*
 // 不允许changes中嵌套changes
 [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
 [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
 
 } error:nil];
 } error:nil];*/

/*
 在CF和NS数据类型之间转换，需要利用桥接__bridge
 //    NSString *key = (__bridge NSString *)kCFBundleNameKey;
 //    CFStringRef string = (__bridge CFStringRef)@"123";
 */

/*
 This method can only be called from inside of -[PHPhotoLibrary performChanges:completionHandler:] or -[PHPhotoLibrary performChangesAndWait:error:]
 
 [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
 [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
 } completionHandler:^(BOOL success, NSError * _Nullable error) {
 
 }];
 
 [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
 [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
 } error:nil];
 */

/*
 Photos.framework使用须知
 1.PHAsset : 一个PHAsset对象代表相册中的一张图片或者一段视频
 
 2.PHAssetCollection : 一个PHAssetCollection对象代表一个相册
 
 3.PHAssetChangeRequest : 利用这个对象能添加、删除、修改PHAsset对象
 
 4.PHAssetCollectionChangeRequest : 利用这个对象能添加、删除、修改PHAssetCollection对象
 
 5.对相片\相册的任何改动操作，都必须放在以下方法的block中
 1> -[PHPhotoLibrary performChanges:completionHandler:]
 2> -[PHPhotoLibrary performChangesAndWait:error:]
 */

/*
 1.保存图片到【Camera Roll（相机胶卷）】中
 1> UIImageWriteToSavedPhotosAlbum函数
 2> AssetsLibrary.framework - 从iOS9开始废弃
 3> Photos.framework - 从iOS8开始可以使用，可以完全取代AssetsLibrary.framework
 
 2.创建【自定义相册】
 1> AssetsLibrary.framework
 2> Photos.framework
 
 3.将刚才保存到【Camera Roll（相机胶卷）】中的图片，引用（添加）到【自定义相册】
 1> AssetsLibrary.framework
 2> Photos.framework
 */



// ----------------------------------------------------------------------------
// 简单使用函数保存图片到相册
//- (IBAction)save
//{
//    // ------------------------------------------------------------------------
//    // 保存图片到Camera Roll（相机胶卷）中,第三个参数必须传image:didFinishSavingWithError:contextInfo:格式的方法,方法名可以不一样,但是参数必须一样,否则会报错
//    /*
//     NSInvocation : 出现这个类名，一般都是“调用方法”时报的错误
//     
//     -[NSInvocation setArgument:atIndex:]: index (2) out of bounds [-1, 1]
//     错误原因：方法调用时参数越界，参数个数不够
//     */
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//}
//
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
//    } else {
//        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
//    }
//}


@end
