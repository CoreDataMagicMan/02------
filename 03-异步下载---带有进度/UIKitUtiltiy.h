//
//  UIKitUtiltiy.h
//  03-异步下载---带有进度
//
//  Created by vera on 15/8/28.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>

@interface UIKitUtiltiy : NSObject

/**
 *  显示
 *
 *  @param superView <#superView description#>
 *  @param animated  <#animated description#>
 */
+ (void)showBMProgessHUD:(UIView *)superView animated:(BOOL)animated;

/**
 *  显示进度
 *
 *  @param superView <#superView description#>
 *  @param animated  <#animated description#>
 */
+ (MBProgressHUD *)showBMProgessHUD:(UIView *)superView animated:(BOOL)animated progressHUDMode:(MBProgressHUDMode)mode;

/**
 *  隐藏
 *
 *  @param superView <#superView description#>
 *  @param animated  <#animated description#>
 */
+ (void)hideMProgessHUD:(UIView *)superView animated:(BOOL)animated;
@end
