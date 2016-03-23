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
#import "WMPictureViewController.h"
#import "WMVideoViewController.h"
#import "WMWordViewController.h"
#import "WMVoiceViewController.h"



@interface WMEssenceViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) WMTitleButton *selectBT;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, weak)  UIScrollView *scrollV;
@property (nonatomic, weak) UIView *titleView;

@end

@implementation WMEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    self.view.backgroundColor = WMCommonBgColor;
    
    [self setUpAddChildViewContrller];
    
    // 添加子view
    [self setUpScrolView];
    
    // 添加子标题
    [self setTitleView];
    
    //
    [self addChildView];
    
}

- (void)setUpNav {
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" selectImage:@"MainTagSubIconClick" targe:self action:@selector(menuClick)];
}

- (void)setUpAddChildViewContrller {
    
    WMAllViewController *all = [[WMAllViewController alloc] init];
//    all.type = WMTopicTypeAll;
    [self addChildViewController:all];
    
    WMVideoViewController *video = [[WMVideoViewController alloc] init];
//    video.type = WMTopicTypeVideo;
    [self addChildViewController:video];
    
    WMVoiceViewController *voice = [[WMVoiceViewController alloc] init];
//    voice.type = WMTopicTypeVoice;
    [self addChildViewController:voice];
    
    WMPictureViewController *picture = [[WMPictureViewController alloc] init];
//    picture.type = WMTopicTypePicture;
    [self addChildViewController:picture];

    WMWordViewController *word = [[WMWordViewController alloc] init];
//    word.type = WMTopicTypeWord;
    [self addChildViewController:word];
}

- (void)setUpScrolView {
    
    // 不允许自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollV.pagingEnabled = YES;
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollV];
    
    scrollV.delegate = self;

    
    // 把childView添加到view
    NSUInteger count = self.childViewControllers.count;
    // 设置scrollView的可滑动区域
    scrollV.contentSize = CGSizeMake(count * scrollV.wm_width, 0);
    
    self.scrollV = scrollV;
    
    
}


- (void)setTitleView {
    
    // 标题栏
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 64, self.view.wm_width, 35);
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
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
    [UIView animateWithDuration:0.2 animations:^{
       
        self.indicatorView.wm_width = button.titleLabel.wm_width;
        self.indicatorView.wm_centerX = button.wm_centerX;
        
    }];
    
    // 让scrollview滚到对应的位置
    CGPoint offset = self.scrollV.contentOffset;
    offset.x = button.tag * self.scrollV.wm_width;
    [self.scrollV setContentOffset:offset animated:YES];
    
}

#pragma mark - 添加子控制器的view
- (void)addChildView {
    
    // 子控制器的索引
    NSUInteger index = self.scrollV.contentOffset.x / self.scrollV.wm_width;
    UIViewController *childVc = self.childViewControllers[index];
    
    if ([childVc isViewLoaded]) return;
    
    childVc.view.frame = self.scrollV.bounds;
    
    
    
    // 添加view
    [self.scrollV addSubview:childVc.view];
    
    
}

- (void)menuClick {
    WMLog(@"menu");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UIScrollViewDelegate>
/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 使用setContentOffset:animated:或者scrollRectVisible:animated:方法让scrollView产生滚动动画
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self addChildView];
}

/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 人为拖拽scrollView产生的滚动动画
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSUInteger index = scrollView.contentOffset.x / scrollView.wm_width;
    WMTitleButton *titleBT = self.titleView.subviews[index];
    
    // 选择标题
    [self clickTitleBT:titleBT];
    
    // 加载view
    [self addChildView];
}

@end
