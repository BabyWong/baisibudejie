//
//  WMCommentViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/23.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMCommentViewController.h"

@interface WMCommentViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UITableView *table_view;



@end

@implementation WMCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBase];
    
    
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    return 10;
}

static NSString * const WMTopicCellId = @"topic";
static NSString * const WMCommentCellId = @"comment";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    return cell;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
