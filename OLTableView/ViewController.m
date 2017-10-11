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
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ViewControllerReuseIdentifierID];
    cell.textLabel.text = [NSString stringWithFormat:@"cell-%zd", [self.dataArray[indexPath.row] intValue]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** 不同的行, 可以设置不同的编辑样式, 编辑样式是一个枚举类型 */
    if (indexPath.row == 0) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    /**   点击 删除 按钮的操作 */
    if (editingStyle == UITableViewCellEditingStyleDelete) { /**< 判断编辑状态是删除时. */

        /** 1. 更新数据源(数组): 根据indexPaht.row作为数组下标, 从数组中删除数据. */
        [self.dataArray removeObjectAtIndex:indexPath.row];

        /** 2. TableView中 删除一个cell. */
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }

    /** 点击 +号 图标的操作. */
    if (editingStyle == UITableViewCellEditingStyleInsert) { /**< 判断编辑状态是插入时. */
        /** 1. 更新数据源:向数组中添加数据. */
        [self.dataArray insertObject:@"abcd" atIndex:indexPath.row];

        /** 2. TableView中插入一个cell. */
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        for (int i=0; i<5; i++) {
            [_dataArray addObject:[NSNumber numberWithInt:i+100]];
        }
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
