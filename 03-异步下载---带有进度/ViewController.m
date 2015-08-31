//
//  ViewController.m
//  03-异步下载---带有进度
//
//  Created by vera on 15/8/24.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "ViewController.h"
#import "URL.h"
#import "UIKitUtiltiy.h"
#import "MTDownload.h"
#import "MBProgressHUD.h"
/*
 http://d3.s.hjfile.cn/2012/201202_3/43904b09-24e1-4fdb-8b46-d3dba3323278.mp3
 */

@interface ViewController ()
@property (strong, nonatomic) MTDownload *fileDownload;
@property (strong, nonatomic) MBProgressHUD *progressHUD;

@end

/*
 1.个人 (￥688)
 2.公司 (￥688)
 3.企业 ($299)
 */

/*
 1.支持暂停(断点下载)
 2.点击按钮首先判断当前文件是否存在，如果存在直接读取显示，否则下载(图片缓存)
 3.分段写入。
 */

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//按下开始下载按钮后做的事
- (IBAction)startRequest:(id)sender
{
    //先判断该文件是否存在，如果存在缓存，那么就直接从缓存中读取
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSString stringWithFormat:@"Documents/large-image.jpg"];
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:path];
    
    NSLog(@"%@",filePath);
    BOOL isExist = [manager fileExistsAtPath:filePath];
    if (isExist) {
        NSLog(@"ccccc");
        _imageView.image = [UIImage imageWithContentsOfFile:filePath];
    }
    else{
        NSLog(@"vvvvv");
        //运用MTDownload来开始下载任务
        //1.声明一个MTDownload对象.执行开始的任务
        MTDownload *mtDownload = [self MTDownload];
        [mtDownload start];
        mtDownload.ProgressAndImage = ^(double progress,NSData *data){
            NSLog(@"%f",progress);
            //NSLog(@"%lu",(unsigned long)data.length);
            [_progessView setProgress:progress animated:YES];
            _imageView.image = [UIImage imageWithData:data];
        };
    }
   
    
}
//暂停的功能
- (IBAction)pause:(id)sender {
    [_fileDownload.urlConnection cancel];
    _fileDownload.urlConnection = nil;
}
//继续下载
- (IBAction)resume:(id)sender {
    MTDownload *mtDownload = _fileDownload;
    [mtDownload start];
    mtDownload.ProgressAndImage = ^(double progress,NSData *data){
        NSLog(@"%f",progress);
        //NSLog(@"%lu",(unsigned long)data.length);
        [_progessView setProgress:progress animated:YES];
        _imageView.image = [UIImage imageWithData:data];
    };
}
- (MTDownload *)MTDownload{
    _fileDownload = [[MTDownload alloc] init];
    //url的地址
    NSString *urlString = kIMAGEURL;
    _fileDownload.urlString = urlString;
    //把保存的路径传导MTDownload
    NSString *path = [NSString stringWithFormat:@"Documents/large-image.jpg"];
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:path];
    _fileDownload.filePath = filePath;
    
    return _fileDownload;
}
@end
