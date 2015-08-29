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
/*
 http://d3.s.hjfile.cn/2012/201202_3/43904b09-24e1-4fdb-8b46-d3dba3323278.mp3
 */

@interface ViewController ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{
    //保存下载的数据
    //NSData *_requestData;
    
    //保存下载的数据
    NSMutableData *_requestData;
    
    //文件总大小
    long long _allSizeBytes;
    
    //显示进度
    MBProgressHUD *_hud;
}
@property (strong, nonatomic) MTDownload *downloader;
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
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化
    _requestData = [NSMutableData data];

    
}

#pragma mark - NSURLConnectionDelegate
/**
 *  服务器已经有响应
 *
 *  @param connection <#connection description#>
 *  @param response   <#response description#>
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"已经收到服务器响应");
    
    //清空数据
    _requestData.length = 0;
    
    //获取文件大小
    _allSizeBytes = [response expectedContentLength];
}

/**
 *  服务器开始发送数据(可能会调用多次)
 *
 *  @param connection <#connection description#>
 *  @param data       <#data description#>
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   // NSLog(@"已经获取数据了");
    
    //获取当前数据的大小
    //data.length
    
    //1.追加数据
    [_requestData appendData:data];
    
    //2.计算当前下载文件大小  下载的大小 除以 文件总大小
    CGFloat progess =  (CGFloat)_requestData.length / _allSizeBytes;
    
    //3.修改进度条和百分比
    self.progessView.progress = progess;
    self.progessLabel.text = [NSString stringWithFormat:@"%0.2f%%",progess * 100];
    
    
    _hud.progress = progess;

}

/**
 *  请求数据完成
 *
 *  @param connection <#connection description#>
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    NSString *str = [[NSString alloc] initWithData:_requestData encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"请求完成了 --- %@",str);
    
    //1.替换默认图片
    self.imageView.image = [UIImage imageWithData:_requestData];
    
    //2.提示
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载成功" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alertView show];
    
    //3.停止加载
    [self.activityIndicatorView stopAnimating];
    
    //4.取消当前请求
    [connection cancel];
    
    //5.按钮可点击
    self.downloadButton.enabled = YES;
    
    //6.隐藏
    [UIKitUtiltiy hideMProgessHUD:self.view animated:YES];
}

/**
 *  请求数据失败。一般下面3种情况会调用：1.url有问题(unsupported URL) 2.网络有问题 3.网络超时
 *
 *  @param connection <#connection description#>
 *  @param error      <#error description#>
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"请求失败%@",error);
    
    //1.停止加载
    [self.activityIndicatorView stopAnimating];
    
    //2.取消当前请求
    [connection cancel];
    
    //3.按钮可点击
    self.downloadButton.enabled = YES;
    
    //4.隐藏
    [UIKitUtiltiy hideMProgessHUD:self.view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//按下开始下载按钮后做的事
- (IBAction)startRequest:(id)sender
{
    //用downloader去调用下载的方法
    _downloader = [[MTDownload alloc] init];
    [_downloader downloaderWithURLString:kIMAGEURL];
    
#if 0
    自动发送异步请求
    [NSURLConnection connectionWithRequest:request delegate:self];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
#endif
    
#if 0
    //startImmediately:是否立即发送异步请求
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    //手动启动异步请求
    [connection start];
#endif
}
@end
