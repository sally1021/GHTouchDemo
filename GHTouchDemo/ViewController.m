//
//  ViewController.m
//  GHTouchDemo
//  详解请参见http://wgh.me/archives/273
//  Created by sally on 15/11/16.
//  Copyright © 2015年 koalac. All rights reserved.
//

#import "ViewController.h"
#import "ActionOneViewController.h"
#import "ActionTwoViewController.h"
#import "ActionViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;

//Peek&Pop相关
@property (nonatomic, assign) CGRect sourceRect;       //手势点位置，对应需要突出显示的rect
@property (nonatomic, strong) NSIndexPath *indexPath;  //手势点位置，对应cell的indexPath

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoDetailVc:) name:@"Notice3DTouch" object:nil];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
  
  // 注册Peek和Pop方法
  if (IOS_VERSION >= 9) {
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable){
      [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
  }
  
  //初始化数据
  self.tableData = [[NSMutableArray alloc]init];
  for (int i = 0; i < 30; i++) {
    [self.tableData addObject:[NSString stringWithFormat:@"数据%d",i]];
  }
}

#pragma mark - UIViewControllerPreviewingDelegate
#pragma mark peek手势
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
  //判断是否越界
  if (![self getShouldShowRectAndIndexPathWithLocation:location]) return nil;
  //设置选中size
  previewingContext.sourceRect = self.sourceRect;
  //返回显示页面
  ActionViewController *vc = [[ActionViewController alloc] initWithNibName:@"ActionViewController" bundle:nil];
  vc.index = [self.indexPath row];
  return vc;
}

#pragma mark pop手势
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
  [self tableView:self.tableView didSelectRowAtIndexPath:self.indexPath];
}

#pragma mark - TableView data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
  
  cell.textLabel.text = [self.tableData objectAtIndex:[indexPath row]];
  
  return cell;
}

#pragma mark TableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 私有方法
#pragma mark 从快捷菜单进入对应页面
- (void)gotoDetailVc:(NSNotification *)notification {
  NSString *type = notification.userInfo[@"type"];
  if ([type isEqualToString:@"1"]) {
    ActionOneViewController *vc = [[ActionOneViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
  } else if ([type isEqualToString:@"2"]) {
    ActionTwoViewController *vc = [[ActionTwoViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
  }
}

#pragma mark 判断是否越界，并计算cell的下标
- (BOOL)getShouldShowRectAndIndexPathWithLocation:(CGPoint)location {
  //获取第一cell的坐标
  NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
  CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:indexPath];
  CGRect rect = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
  //计算出选中哪个cell
  CGFloat height = 44;
  NSInteger row = (location.y - rect.origin.y)/height;
  self.sourceRect = CGRectMake(0, row * height + rect.origin.y, SCREEN_WIDTH, height);
  self.indexPath = [NSIndexPath indexPathForItem:row inSection:0];
  // 如果row越界了，返回NO 不处理peek手势
  return row >= self.tableData.count ? NO : YES;
}

@end
