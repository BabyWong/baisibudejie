//
//  WMEssenceViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/15.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMEssenceViewController.h"
#import "WMTitleButton.h"
#import "WMAllViewController.h"
#import "WMVideoViewController.h"
#import "WMVoiceViewController.h" 
#import "WMPictureViewController.h"
#import "WMWordViewController.h"

@interface WMEssenceViewController ()

@property (nonatomic, strong) WMTitleButton *selectBT;
@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation WMEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" selectImage:@"MainTagSubIconClick" targe:self action:@selector(menuClick)];
    
    self.view.backgroundColor = WMCommonBgColor;
    
    [self setUpChildViewContrller];
    
    // 添加子view
    [self setUpScrolView];
    
    // 添加子标题
    [self setTitleView];
    
}

- (void)setUpChildViewContrller {
    
    [self addChildViewController:[[WMAllViewController alloc] init]];
    
    [self addChildViewController:[[WMVideoViewController alloc] init]];
    
    [self addChildViewController:[[WMVoiceViewController alloc] init]];
    
    [self addChildViewController:[[WMPictureViewController alloc] init]];

    [self addChildViewController:[[WMWordViewController alloc] init]];
}

- (void)setUpScrolView {
    
    // 不允许自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollV.pagingEnabled = YES;
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollV];
//    scrollV.backgroundColor = WMRandomColor;
    
    // 把childView添加到view
    NSUInteger count = self.childViewControllers.count;
    for (NSInteger i = 0; i < count ; i++) {
        UITableView *childVcView = (UITableView *)self.childViewControllers[i].view;
        childVcView.wm_x = i * self.view.wm_width;
        childVcView.wm_y = 0;
        childVcView.wm_height = scrollV.wm_height;
        
        // 内边距
        childVcView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
        // 指定滚动条在scrollerView中的位置
        childVcView.scrollIndicatorInsets = childVcView.contentInset;
        
        [scrollV addSubview:childVcView];
    }
    
    scrollV.contentSize = CGSizeMake(count * self.view.wm_width, 0);
    
    
}

- (void)setTitleView {
    
    // 标题栏
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 64, self.view.wm_width, 35);
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:titleView];
    
    // 添加标题
    
    NSArray *title = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat buttonW = titleView.wm_width / title.count;
    CGFloat buttonH = titleView.wm_height;
    

    for (NSInteger i = 0; i < title.count; i++) {
        
        WMTitleButton *titleBT = [[WMTitleButton alloc] init];
        [titleBT setTitle:title[i] forState:UIControlStateNormal];
        titleBT.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
        [titleBT addTarget:self action:@selector(clickTitleBT:) forControlEvents:UIControlEventTouchUpInside];
        titleBT.tag = i;
        [titleView addSubview:titleBT];
        
        
    }
    
    // 按钮的选中颜色
    WMTitleButton *firstTitleBT = titleView.subviews[0];
    // 底部的指示器
    self.indicatorView = [[UIView alloc] init];
    self.indicatorView.wm_height = 1;
    self.indicatorView.wm_y = firstTitleBT.wm_bottom - 1;
    self.indicatorView.backgroundColor = [firstTitleBT titleColorForState:UIControlStateSelected];
    
    [titleView addSubview:self.indicatorView];
    
    // 立刻根据文字内容计算label的宽度
    [firstTitleBT.titleLabel sizeToFit];
    _indicatorView.wm_width = firstTitleBT.titleLabel.wm_width;
    _indicatorView.wm_centerX = firstTitleBT.wm_centerX;
    
    // 默认选中第一个
    firstTitleBT.selected = YES;
    self.selectBT = firstTitleBT;
    
}

/**
 *  点击子标题按钮
 */
- (void)clickTitleBT:(WMTitleButton *)button {
    
    // 切换颜色
    self.selectBT.selected = NO;
    button.selected = YES;
    self.selectBT = button;
    
    // 指示器
    [UIView animateWithDuration:0.5 animations:^{
       
        self.indicatorView.wm_width = button.titleLabel.wm_width;
        self.indicatorView.wm_centerX = button.wm_centerX;
        
    }];
    
    // 跳转
    
}

- (void)menuClick {
    WMLog(@"menu");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
