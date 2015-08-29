//
//  ViewController.h
//  03-异步下载---带有进度
//
//  Created by vera on 15/8/24.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/**
 *  指示器
 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

/**
 *  进度条
 */
@property (weak, nonatomic) IBOutlet UIProgressView *progessView;

/**
 *  进度百分比
 */
@property (weak, nonatomic) IBOutlet UILabel *progessLabel;

/**
 *  开始加载
 */
- (IBAction)startRequest:(id)sender;

/**
 *  开始加载按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;

@end

