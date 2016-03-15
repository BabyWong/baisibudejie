//
//  WMTabBarController.m
//  baisibudejie
//
//  Created by hwm on 16/3/15.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMTabBarController.h"
#import "WMTabBar.h"

@interface WMTabBarController ()



@end

@implementation WMTabBarController



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
    
    [self setValue:[[WMTabBar alloc] init] forKey:@"tabBar"];
    
}

- (void)setUpChildController {
    
    [self setUpOneChildController:[[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]] image:[UIImage imageNamed:@"tabBar_essence_icon"]  selectImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"精华"];
    
    [self setUpOneChildController:[[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]] image:[UIImage imageNamed:@"tabBar_essence_icon"]  selectImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"精华"];
    
    [self setUpOneChildController:[[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]] image:[UIImage imageNamed:@"tabBar_essence_icon"]  selectImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"精华"];
    
    [self setUpOneChildController:[[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]] image:[UIImage imageNamed:@"tabBar_essence_icon"]  selectImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"精华"];
    
}

- (void)setUpOneChildController:(UIViewController *)vc image:(UIImage *)image selectImage:(UIImage *)selectImage title:(NSString *)title {
    
    
    vc.view.backgroundColor = WMRandomColor;
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
