//
//  ActionViewController.m
//  GHTouchDemo
//  详解请参见http://wgh.me/archives/273
//  Created by sally on 15/11/16.
//  Copyright © 2015年 koalac. All rights reserved.
//

#import "ActionViewController.h"

@interface ActionViewController ()

@property (weak, nonatomic) IBOutlet UILabel *noticeLbl;

@end

@implementation ActionViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.noticeLbl.text = [NSString stringWithFormat:@"Peek and Pop the %ld Cell",(long)self.index];
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
  
  UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"Aciton1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
    //点击Action1事件
    NSLog(@"touch action1");
  }];
  
  UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"Aciton2" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
    //点击Action2事件
    NSLog(@"touch action2");
  }];
  
  //可添加多个UIPreviewAction
  NSArray *actions = @[action1,action2];
  
  return actions;
}

@end
