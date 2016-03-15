//
//  WMTabBarController.m
//  baisibudejie
//
//  Created by hwm on 16/3/15.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMTabBarController.h"

@interface WMTabBarController ()

@property (nonatomic, strong) UIButton *publishButton;

@end

@implementation WMTabBarController

- (UIButton *)publishButton {
    
    if (!_publishButton) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        _publishButton.frame = CGRectMake(0, 0, self.tabBar.frame.size.width / 5, self.tabBar.frame.size.height);
        _publishButton.center = CGPointMake(self.tabBar.frame.size.width / 2, self.tabBar.frame.size.height / 2);
        [_publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _publishButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tabBar addSubview:self.publishButton];
}

#pragma mark -- 点击更多
- (void)publishClick {
    
    UIViewController *contro = [[UIViewController alloc] init];
    contro.view.backgroundColor = [UIColor yellowColor];
    
    [self presentViewController:contro animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置item所有的文字属性
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    selectAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
    
    // 添加子控制器
    [self setUpChildController];
    
}

- (void)setUpChildController {
    
    [self setUpOneChildController:[[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]] image:[UIImage imageNamed:@"tabBar_essence_icon"]  selectImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"精华"];
    
    [self setUpOneChildController:[[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]] image:[UIImage imageNamed:@"tabBar_essence_icon"]  selectImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"精华"];
    
    [self setUpOneChildController:[[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]] image:nil  selectImage:nil title:nil];
    
    [self setUpOneChildController:[[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]] image:[UIImage imageNamed:@"tabBar_essence_icon"]  selectImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"精华"];
    
    [self setUpOneChildController:[[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]] image:[UIImage imageNamed:@"tabBar_essence_icon"]  selectImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"精华"];
    
}

- (void)setUpOneChildController:(UIViewController *)vc image:(UIImage *)image selectImage:(UIImage *)selectImage title:(NSString *)title {
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectImage;
    [self addChildViewController:vc];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
