//
//  MTDownload.m
//  03-异步下载---带有进度
//
//  Created by mtt0150 on 15/8/29.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "MTDownload.h"

@implementation MTDownload
- (void)downloaderWithURLString:(NSString *)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    //发送请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:2.0];
    
}
@end
