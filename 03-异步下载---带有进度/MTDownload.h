//
//  MTDownload.h
//  03-异步下载---带有进度
//
//  Created by mtt0150 on 15/8/31.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MTDownload : NSObject
//属性
@property (copy, nonatomic) NSString *filePath;
@property (copy, nonatomic) NSString *urlString;
//文件写的开始的位置
@property (assign, nonatomic) long long begin;
//结束的位置
@property (assign, nonatomic) long long end;
//声明一个连接
@property (strong, nonatomic) NSURLConnection *urlConnection;
//方法
- (void)start;
//声明一个代码块，供主程序去调用显示进度和图像的数据
@property (copy, nonatomic) void (^ProgressAndImage)(double progress, NSData *data);
@end
