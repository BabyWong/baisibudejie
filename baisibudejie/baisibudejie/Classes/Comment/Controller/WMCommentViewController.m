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
static NSString * const WMTopicCellId = @"topic";

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
    [self.table_view registerClass:[UITableViewCell class] forCellReuseIdentifier:WMTopicCellId];
    [self.table_view registerClass:[UITableViewCell class] forCellReuseIdentifier:WMCommentCellId];
    
//    // 头部
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = [UIColor redColor];
//    headerView.wm_height = 200;
//    self.table_view.tableHeaderView = headerView;
    
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
    
    [self.manager GET:CommenURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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
//    // 有最热评论 + 最新评论数据
//    if (self.hotestComments.count) return 2;
//    
//    // 没有最热评论数据, 有最新评论数据
//    if (self.lastestComments.count) return 1;
//    
//    // 没有最热评论数据, 没有最新评论数据
//    return 0;
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    // 第0组 && 有最热评论数据
//    if (section == 0 && self.hotestComments.count) {
//        return self.hotestComments.count;
//    }
//    // 其他情况
//    return self.lastestComments.count;
    
    if (section == 0) return 1;
    if (section == 1) return 4;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    WMCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:WMCommentCellId];
//    
//    if (indexPath.section == 0 && self.hotestComments.count) {
//        cell.comment = self.hotestComments[indexPath.row];
//    } else {
//        cell.comment = self.lastestComments[indexPath.row];
//    }
//    
//    return cell;
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WMTopicCellId];
        cell.textLabel.text = @"最顶部的帖子数据";
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WMCommentCellId];
        cell.textLabel.text = [NSString stringWithFormat:@"评论数据 - %zd-%zd", indexPath.section, indexPath.row];
        return cell;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) return nil;
    if (section == 1) return @"最热评论";
    return @"最新评论";
    
}

#pragma mark - <UITableViewDelegate>
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    WMCommentSectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:WMSectionHeaderlId];
//    
//    // 第0组 && 有最热评论数据
//    if (section == 0 && self.hotestComments.count) {
//        header.textLabel.text = @"最热评论";
//    } else { // 其他情况
//        header.textLabel.text = @"最新评论";
//    }
//    
//    return header;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return 200;
    return 44;
}

/**
 *  当用户开始拖拽scrollView就会调用一次
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}



@end
