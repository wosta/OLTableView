//
//  ViewController.m
//  OLTableView
//
//  Created by 魏旺 on 16/3/31.
//  Copyright © 2016年 olive. All rights reserved.
//

#import "ViewController.h"

static NSString *ViewControllerReuseIdentifierID = @"ViewControllerReuseIdentifierID";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
/** data */
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

#pragma mark -- 
// 来源于 http://www.strongx.cn/?p=32

/**
 *  分割线顶头
 */
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ViewControllerReuseIdentifierID];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 当数据未能显示满一屏幕的时候，UITableView会显示多余的横线，这个时候你如果希望去掉这些横线，你可以加上这句话。
    self.tableView.tableFooterView = [UIView new];
    // UITableView的分割线默认是开头空15像素点的（好像是15来着～～），产品经理有时候希望能够定格显示，那么你可能会这么做 但是你会发现iOS7以后这个方法就没用了。
//    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ViewControllerReuseIdentifierID];
    cell.textLabel.text = [NSString stringWithFormat:@"cell-%zd", indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
