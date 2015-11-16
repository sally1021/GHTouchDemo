//
//  ActionOneViewController.m
//  GHTouchDemo
//  详解请参见http://wgh.me/archives/273
//  Created by sally on 15/11/16.
//  Copyright © 2015年 koalac. All rights reserved.
//

#import "ActionOneViewController.h"

@interface ActionOneViewController ()

@end

@implementation ActionOneViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (IBAction)back:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
