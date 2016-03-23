//
//  WMCommentViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/23.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMCommentViewController.h"
#import "WMCommentCell.h"
#import "WMAFHTTPSessionManager.h"
#import "WMRefreshHeader.h"
#import "WMRefreshFooter.h"
#import "WMNewViewController.h"
#import "WMCommentSectionHeaderView.h"


@interface WMCommentViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UITableView *table_view;

/** 任务管理者 */
@property (nonatomic, strong) WMAFHTTPSessionManager *manager;

/** 最热评论数据 */
@property (nonatomic, strong) NSArray<WMComment *> *hotestComments;

/** 最新评论数据 */
@property (nonatomic, strong) NSMutableArray<WMComment *> *lastestComments;


@end

@implementation WMCommentViewController


static NSString * const WMSectionHeaderlId = @"header";
static NSString * const WMCommentCellId = @"comment";

#pragma mark - 懒加载
- (WMAFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [WMAFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBase];
    
    [self setupTable];
    
    [self setupRefresh];
    
}

- (void)setupTable {
    
    // 注册
    [self.table_view registerNib:[UINib nibWithNibName:NSStringFromClass([WMCommentCell class]) bundle:nil] forCellReuseIdentifier:WMCommentCellId];
    [self.table_view registerClass:[WMCommentSectionHeaderView class] forCellReuseIdentifier:WMSectionHeaderlId];
    
    // 头部
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor redColor];
    headerView.wm_height = 200;
    self.table_view.tableHeaderView = headerView;
    
    self.table_view.backgroundColor = WMCommonBgColor;
    self.table_view.separatorStyle = UITableViewCellSeparatorStyleNone;//去除下划线
    
    // 每一组头部控件的高度  =  文字高度+2
    self.table_view.sectionHeaderHeight = [UIFont systemFontOfSize:15].lineHeight + 2;
    
    // 设置cell的高度
    self.table_view.rowHeight = UITableViewAutomaticDimension;
    self.table_view.estimatedRowHeight = 44;
    
    
    
}

- (void)setupRefresh {
    
    self.table_view.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.table_view.mj_header beginRefreshing];
    
    self.table_view.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreNewComment)];
    
}

- (NSString *)aParam {
    // 判断当前的控制器是不是新帖
    if (self.parentViewController.class == [WMNewViewController class]) {
        return @"newlist";
    }
    return @"list";
}


- (void)loadNewComments {
    
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 加载数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1; // @"1";
    
    // 解强强
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:CommenURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 没有任何评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 让[刷新控件]结束刷新
            [weakSelf.table_view.mj_header endRefreshing];
        }
        //        [responseObject writeToFile:@"/Users/hwm/Desktop/topic.plist" atomically:YES];

        
        // 字典数组 -> 模型数组
        weakSelf.lastestComments = [WMComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        weakSelf.hotestComments = [WMComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        
        // 刷新表格
        [self.table_view reloadData];
        
        // 让[刷新控件]结束刷新
        [self.table_view.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        WMLog(@"请求失败");
        
        // 让[刷新控件]结束刷新
        [self.table_view.mj_header endRefreshing];
        
        
    }];
    
    
}

- (void)loadMoreNewComment {
    
}

- (void)setBase {
    
    self.navigationItem.title = @"评论";
    
    // 添加监听者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];// 键盘的fram改变

    
}

- (void)KeyboardWillChangeFrame:(NSNotification *)note {
    
    // 改变约束
    CGFloat keyBoardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    NSUInteger scrrenH = [UIScreen mainScreen].bounds.size.height;
    self.bottomConstraint.constant = scrrenH - keyBoardY;
    
    // 执行动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)dealloc {
    
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 有最热评论 + 最新评论数据
    if (self.hotestComments.count) return 2;
    
    // 没有最热评论数据, 有最新评论数据
    if (self.lastestComments.count) return 1;
    
    // 没有最热评论数据, 没有最新评论数据
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 第0组 && 有最热评论数据
    if (section == 0 && self.hotestComments.count) {
        return self.hotestComments.count;
    }
    
    // 其他情况
    return self.lastestComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WMCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:WMCommentCellId];
    
    if (indexPath.section == 0 && self.hotestComments.count) {
        cell.comment = self.hotestComments[indexPath.row];
    } else {
        cell.comment = self.lastestComments[indexPath.row];
    }
    
    return cell;
    
}

#pragma mark - <UITableViewDelegate>
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WMCommentSectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:WMSectionHeaderlId];
    
    // 第0组 && 有最热评论数据
    if (section == 0 && self.hotestComments.count) {
        header.textLabel.text = @"最热评论";
    } else { // 其他情况
        header.textLabel.text = @"最新评论";
    }
    
    return header;
}

/**
 *  当用户开始拖拽scrollView就会调用一次
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
