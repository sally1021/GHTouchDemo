//
//  AppDelegate.m
//  GHTouchDemo
//  详解请参见http://wgh.me/archives/273
//  Created by sally on 15/11/16.
//  Copyright © 2015年 koalac. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  //通过代码动态创建shortcutItems
  //[self createShortCutItems];
  
  //是否从shortCutItem进入的app
  if (launchOptions[@"UIApplicationLaunchOptionsShortcutItemKey"] == nil) {
    return YES;
  } else {
    return NO;
  }
  return YES;
}

#pragma mark 创建shortcutItems
- (void)createShortCutItems {
  NSMutableArray *shortcutItems = [NSMutableArray array];
  UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"1" localizedTitle:@"ShortCutItem1"];
  UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"2" localizedTitle:@"ShortCutItem2"];
  [shortcutItems addObject:item1];
  [shortcutItems addObject:item2];
  [[UIApplication sharedApplication] setShortcutItems:shortcutItems];
}

#pragma mark 点击shortcutItem响应事件
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
  //通过通知传递type，收到通知的页面做响应的处理
  [[NSNotificationCenter defaultCenter] postNotificationName:@"Notice3DTouch" object:self userInfo:@{ @"type" : shortcutItem.type }];
}

@end
