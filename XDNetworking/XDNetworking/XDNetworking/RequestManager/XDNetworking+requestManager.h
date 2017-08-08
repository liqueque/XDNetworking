//
//  XDNetworking+requestManager.h
//  XDNetworking
//
//  Created by 李雀 on 2016/7/25.
//  Copyright © 2016年 李雀. All rights reserved.

//

#import "XDNetworking.h"

@interface XDNetworking (requestManager)

/**
 *  判断网络请求池中是否有相同的请求
 *
 *  @param task 网络请求任务
 *
 *  @return
 */
+ (BOOL)haveSameRequestInTasksPool:(XDURLSessionTask *)task;

/**
 *  如果有旧请求则取消旧请求
 *
 *  @param task 新请求
 *
 *  @return 旧请求
 */
+ (XDURLSessionTask *)cancleSameRequestInTasksPool:(XDURLSessionTask *)task;

@end
