//
//  WMSeeBigViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/23.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMSeeBigViewController.h"
#import <Photos/Photos.h>
#import <SVProgressHUD.h>

@interface WMSeeBigViewController ()

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

/** 图片控件 */
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation WMSeeBigViewController


static NSString *WMAssetCollectionTitle = @"WMBaisibudejie";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view insertSubview:scrollView atIndex:0];// 将某个视图插入到当前view的第0个视图,就不会挡住xib里面的button
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return; // 图片下载失败
        self.saveButton.enabled = YES;
    }];
    [scrollView addSubview:imageView];
    
    imageView.wm_width = scrollView.wm_width;
    imageView.wm_height = self.topic.height * imageView.wm_width / self.topic.width;
    imageView.wm_x = 0;
    
    if (imageView.wm_height >= scrollView.wm_height) { // 图片高度超过整个屏幕
        imageView.wm_y = 0;
        // 滚动范围
        scrollView.contentSize = CGSizeMake(0, imageView.wm_height);
    } else { // 居中显示
        imageView.wm_centerY = scrollView.wm_height * 0.5;
    }
    self.imageView = imageView;
    
    // 缩放比例
    CGFloat scale =  self.topic.width / imageView.wm_width;
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }
 
}


- (IBAction)saveButton:(id)sender {
    
    // 判断授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) {// 因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
        [SVProgressHUD showErrorWithStatus:@"因为系统原因, 无法访问相册"];
    }else if (status == PHAuthorizationStatusNotDetermined) {// 用户还没有做出选择
        // 弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status == PHAuthorizationStatusAuthorized){// 用户允许
                [self saveImage];// 保存图片
            }
        }];
        
    }else if (status == PHAuthorizationStatusDenied) {// 用户拒绝当前应用访问相册(用户当初点击了"不允许")
        
        [SVProgressHUD showInfoWithStatus:@"请到[设置-隐私-照片-baisibudejie]打开允许访问" maskType:SVProgressHUDMaskTypeGradient];
        WMLog(@"提醒--[设置-隐私-照片-xxx]打开访问开关");
        
    }else if (status == PHAuthorizationStatusAuthorized) {// 用户允许当前应用访问相册(用户当初点击了"好")
        [self saveImage];
    }
    
}

- (void)saveImage {
    
    // PHAsset : 一个资源, 比如一张图片\一段视频
    // PHAssetCollection : 一个相簿
    
    // PHAsset的标识, 利用这个标识可以找到对应的PHAsset对象(图片对象)
    __block NSString *assetLocalIdentifier = nil;
    
    // 如果想对"相册"进行修改(增删改), 那么修改代码必须放在[PHPhotoLibrary sharedPhotoLibrary]的performChanges方法的block中
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 1.保存图片A到"相机胶卷"中
        // 创建图片的请求
        assetLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            [self showError:@"保存图片失败!"];
            return;
        }
        
        // 2.获得相簿
        PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
        if (createdAssetCollection == nil) {
            [self showError:@"创建相簿失败!"];
            return;
        }
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            // 3.添加"相机胶卷"中的图片A到"相簿"D中
            
            // 获得图片
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
            
            // 添加图片到相簿中的请求
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
            
            // 添加图片到相簿
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success == NO) {
                [self showError:@"保存图片失败!"];;
            } else {
                [self showSuccess:@"保存图片成功!"];;
            }
        }];
    }];
    
}

- (PHAssetCollection *)createdAssetCollection {
    // 从已存在相簿中查找这个应用对应的相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:WMAssetCollectionTitle]) {
            return assetCollection;
        }
    }
    
    // 没有找到对应的相簿, 得创建新的相簿
    
    // 错误信息
    NSError *error = nil;
    
    // PHAssetCollection的标识, 利用这个标识可以找到对应的PHAssetCollection对象(相簿对象)
    __block NSString *assetCollectionLocalIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 创建相簿的请求
        assetCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:WMAssetCollectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    // 如果有错误信息
    if (error) return nil;
    
    // 获得刚才创建的相簿
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
}

- (void)showError:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:text];
    });
}

- (void)showSuccess:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:text];
    });
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
