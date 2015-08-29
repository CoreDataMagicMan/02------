//
//  UIKitUtiltiy.m
//  03-异步下载---带有进度
//
//  Created by vera on 15/8/28.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "UIKitUtiltiy.h"

@implementation UIKitUtiltiy

/**
 *  显示
 *
 *  @param superView <#superView description#>
 *  @param animated  <#animated description#>
 */
+ (void)showBMProgessHUD:(UIView *)superView animated:(BOOL)animated
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:animated];
    hud.labelText = @"正在加载...";
}

/**
 *  显示进度
 *
 *  @param superView <#superView description#>
 *  @param animated  <#animated description#>
 */
+ (MBProgressHUD *)showBMProgessHUD:(UIView *)superView animated:(BOOL)animated progressHUDMode:(MBProgressHUDMode)mode
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView
                                              animated:animated];
    hud.mode = mode;
   
    
    return hud;
}

/**
 *  隐藏
 *
 *  @param superView <#superView description#>
 *  @param animated  <#animated description#>
 */
+ (void)hideMProgessHUD:(UIView *)superView animated:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:superView animated:YES];
}

@end
