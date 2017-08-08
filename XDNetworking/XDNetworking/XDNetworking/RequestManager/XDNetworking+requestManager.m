//
//  XDNetworking+requestManager.m
//  XDNetworking
//
//  Created by 李雀 on 2016/7/25.
//  Copyright © 2016年 李雀. All rights reserved.

//

#import "XDNetworking+requestManager.h"

@interface NSURLRequest (decide)

//判断是否是同一个请求（依据是请求url和参数是否相同）
- (BOOL)isTheSameRequest:(NSURLRequest *)request;

@end

@implementation NSURLRequest (decide)

- (BOOL)isTheSameRequest:(NSURLRequest *)request {
    if ([self.HTTPMethod isEqualToString:request.HTTPMethod]) {
        if ([self.URL.absoluteString isEqualToString:request.URL.absoluteString]) {
            if ([self.HTTPMethod isEqualToString:@"GET"]||[self.HTTPBody isEqualToData:request.HTTPBody]) {
                return YES;
            }
        }
    }
    return NO;
}

@end

@implementation XDNetworking (requestManager)

+ (BOOL)haveSameRequestInTasksPool:(XDURLSessionTask *)task {
    __block BOOL isSame = NO;
    [[self currentRunningTasks] enumerateObjectsUsingBlock:^(XDURLSessionTask *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([task.originalRequest isTheSameRequest:obj.originalRequest]) {
            isSame  = YES;
            *stop = YES;
        }
    }];
    return isSame;
}

+ (XDURLSessionTask *)cancleSameRequestInTasksPool:(XDURLSessionTask *)task {
    __block XDURLSessionTask *oldTask = nil;
    
    [[self currentRunningTasks] enumerateObjectsUsingBlock:^(XDURLSessionTask *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([task.originalRequest isTheSameRequest:obj.originalRequest]) {
            if (obj.state == NSURLSessionTaskStateRunning) {
                [obj cancel];
                oldTask = obj;
            }
            *stop = YES;
        }
    }];
    
    return oldTask;
}

@end
