//
//  ViewController.h
//  GHTouchDemo
//
//  Created by sally on 15/11/16.
//  Copyright © 2015年 koalac. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IOS_VERSION  [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define CELL_IDENTIFIER @"Cell"

@interface ViewController : UIViewController<UIViewControllerPreviewingDelegate>

@end

