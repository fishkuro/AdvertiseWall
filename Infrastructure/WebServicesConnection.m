//
//  WebServicesConnection.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-2.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "WebServicesConnection.h"
#import "NetConfirm.h"

@interface WebServicesConnection() {
    NSMutableData *_responseData;
}

@end

@implementation WebServicesConnection

@synthesize delegate = _delegate;
@synthesize multilevel;
@synthesize tempData = _tempData;

#pragma mark - private methods

- (BOOL)canConnect {
    if ([NetConfirm connectionType] == ConnectionTypeNone) {
        return NO;
    }
    return YES;
}

#pragma mark - dealloc

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - action methods

/**
 * 通过GET方式同步获取服务器数据
 */
- (NSString *)synchronizedGetFromURL:(NSURL *)url timeoutInterval:(NSUInteger)timeoutInterval {
    // 判断连接,若连接失败,则不进行处理
    if (![self canConnect]) {
        return nil;
    }
    // 同步 获取GET数据到服务端
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *resultString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    return resultString;
}

/**
 * 通过POST方式同步获取服务器数据
 */
- (NSString *)synchronizedPostJsonString:(NSString *)data toURL:(NSURL *)url timeoutInterval:(NSUInteger)timeoutInterval {
    // 判断连接,若连接失败,则不进行处理
    if (![self canConnect]) {
        return nil;
    }
    // 同步 获取POST数据到服务端
    NSData *postData = [data dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setTimeoutInterval:timeoutInterval];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [postData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    [request release];
    NSString *resultString = [[[NSString alloc] initWithBytes:[receivedData bytes]
                                                       length:[receivedData length]
                                                     encoding:NSUTF8StringEncoding] autorelease];
    return resultString;
}

/* 通过POST方式发送json数据到服务端
 * data   : 发送的json数据
 * url    : 发送的url地址
 * isSync : 是否同步发送数据(同步发送会进行等待服务器响应)
 */
- (void)postData:(NSString *)data toURL:(NSURL *)url {
    // 判断连接,若连接失败,则不进行处理
    if (![self canConnect]) {
        return;
    }
    // POST数据到服务器
    NSData *postData = [data dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [postData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error) {
                               if (error) {
                                   NSLog(@"error:\n%@",error);
                                   return ;
                               }
                               NSString *resultString = [[NSString alloc] initWithData:data
                                                                              encoding:NSUTF8StringEncoding];
                               if (_delegate) {
                                   [_delegate webServicesConnection:self afterConnectedReturnString:resultString];
                               }
                               [resultString release];
                           }];
    [queue release];
    [request release];
}

/* 通过GET方式提交数据到服务端
 * url : 带有get信息的url信息,直接发往服务器
 */
- (void)getFromURL:(NSURL *)url {
    // 判断连接,若连接失败,则不进行处理
    if (![self canConnect]) {
        return;
    }
    // Send GET 数据到服务端
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    _responseData = [[NSMutableData data] retain];
}

#pragma mark - Connection delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [_responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [_responseData release];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *responseString = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    [_responseData release];
    
    if (_delegate) {
        [_delegate webServicesConnection:self afterConnectedReturnString:responseString];
    }
    [responseString release];
}

@end