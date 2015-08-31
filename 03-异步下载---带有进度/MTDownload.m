//
//  MTDownload.m
//  03-异步下载---带有进度
//
//  Created by mtt0150 on 15/8/31.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "MTDownload.h"
@interface MTDownload () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
//当前的文件的长度
@property (assign, nonatomic) long long currentLength;
//文件的数据
@property (strong, nonatomic) NSMutableData *imageData;
//写数据文件句柄
@property (strong, nonatomic) NSFileHandle *fileHandle;
@property (assign, nonatomic) long long totalFileSize;
@end
@implementation MTDownload
- (void)start{
    if (!_imageData.length) {
        _imageData = [[NSMutableData alloc] init];
    }
    NSURL *url = [NSURL URLWithString:_urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求头
    NSString *value = [NSString stringWithFormat:@"bytes=%lld-",self.currentLength];
    //给请求头设置range读写范围
    [request setValue:value forHTTPHeaderField:@"Range"];
    [request setTimeoutInterval:2.0f];
    //[request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    //请求异步的链接
    self.urlConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}
- (NSFileHandle *)fileHandle{
    if (!_fileHandle) {
        if (![[NSFileManager defaultManager] fileExistsAtPath:_filePath]) {
            // 创建一个跟服务器文件等大小的临时文件
            [[NSFileManager defaultManager] createFileAtPath:_filePath contents:nil attributes:nil];
        }
        /*  /Users/mtt0150/Library/Developer/CoreSimulator/Devices/14FEA6AD-19D7-46FB-92DE-5A19608268CA/data/Containers/Data/Application/A8B90D0B-716D-44CB-AB01-E98F41B3906B/Documents/large-image.jpg*/
        //NSLog(@"handle:%@",self.filePath);
        _fileHandle = [NSFileHandle fileHandleForWritingAtPath:self.filePath];
    }
    return _fileHandle;
}
#pragma mark NSURLConnection
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    if (connection == _urlConnection && !_imageData.length) {
        _totalFileSize = response.expectedContentLength;
        NSLog(@"%lld",_totalFileSize);
    }
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
        [self.fileHandle seekToEndOfFile];
        [self.fileHandle writeData:data];
        [_imageData appendData:data];
        //累加长度
        self.currentLength += data.length;
        //打印下载的进度
        double progress = (double)self.currentLength / _totalFileSize;
        //将progress回传给viewcontroller去显示
        _ProgressAndImage(progress,_imageData);
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //下载完之后，需要回到主线程去刷新界面
    //关闭文件
    self.currentLength = 0;
    [self.fileHandle closeFile];
    self.fileHandle = nil;
    //返回主线程，刷新界面
    

}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    

}
@end
