//
//  AFNHttpBaseService.m
//  QHSTemplateProject
//
//  Created by Charles on 5/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "AFNHttpBaseService.h"
#import "AFNShareClient.h"
#import "UtilsMacros.h"

@implementation AFNHttpBaseService

#pragma mark - Init AFHTTPSessionManager
+ (AFHTTPSessionManager *)getRequestManager {
    
    AFNShareClient *manager = [AFNShareClient sharedClient];
    manager.requestSerializer.timeoutInterval = 10;
    manager.requestSerializer                 = [AFJSONRequestSerializer serializer];
    return manager;
}

+ (BOOL)beforeHttpRequest:(AFHTTPSessionManager *)manager {
    __block BOOL     isNetworkValid  = YES;
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                isNetworkValid = YES;
                break;
                
            default:
                [operationQueue setSuspended:YES];
                isNetworkValid = NO;
                break;
        }
    }];
    [manager.reachabilityManager startMonitoring];
    return isNetworkValid;
}

#pragma mark - Print debug log
+ (NSString *)formatJsonData:(id)jsonData {
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonData options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (void)printUrlResponse:(NSHTTPURLResponse *)urlResponse response:(id)response {
    if ([response isKindOfClass:[NSError class]]) {
        NSError *error = (NSError *)response;
        if (error.userInfo) {
            DLog(@"\n%@\n%@\n", error.userInfo[@"NSErrorFailingURLStringKey"], error.userInfo[@"NSLocalizedDescription"])
        } else {
            DLog(@"\n%@\n%@\n%li\n%@\n", urlResponse.URL, error.localizedDescription, (long)error.code, [self formatJsonData:urlResponse.allHeaderFields]);
        }
    } else {
        DLog(@"\nDomain : %@\nHeaders : %@\nSuccess Response : %@\n", urlResponse.URL, [self formatJsonData:urlResponse.allHeaderFields], response ? [self formatJsonData : response] : @"No Response");
    }
}

#pragma mark - Request(get/post/put/delete)
+ (void)getRequest:(NSString *)url
            params:(NSDictionary *)params
           success:(requestSuccessBlock)successBlock
           failure:(requestFailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self getRequestManager];
    if (![self beforeHttpRequest:manager]) {
        !failureBlock ? : failureBlock(nil);
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    [manager GET:url
      parameters:params
        progress:^(NSProgress *_Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
            [strongSelf printUrlResponse:urlResponse response:responseObject];
            !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
        } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
            [strongSelf printUrlResponse:urlResponse response:error];
            !failureBlock ? : failureBlock(error);
        }];
}

+ (void)postRequest:(NSString *)url
             params:(NSDictionary *)params
            success:(requestSuccessBlock)successBlock
            failure:(requestFailureBlock)failureBlock; {
    AFHTTPSessionManager *manager = [self getRequestManager];
    if (![self beforeHttpRequest:manager]) {
        !failureBlock ? : failureBlock(nil);
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    [manager POST:url parameters:params progress:^(NSProgress *_Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
        [strongSelf printUrlResponse:urlResponse response:responseObject];
        !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
        [strongSelf printUrlResponse:urlResponse response:error];
        !failureBlock ? : failureBlock(error);
    }];
}

+ (void)putRequest:(NSString *)url
            params:(NSDictionary *)params
           success:(requestSuccessBlock)successBlock
           failure:(requestFailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self getRequestManager];
    if (![self beforeHttpRequest:manager]) {
        !failureBlock ? : failureBlock(nil);
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    [manager PUT:url parameters:params success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
        [strongSelf printUrlResponse:urlResponse response:responseObject];
        !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
        [strongSelf printUrlResponse:urlResponse response:error];
        !failureBlock ? : failureBlock(error);
    }];
}

+ (void)deleteRequest:(NSString *)url
               params:(NSDictionary *)params
              success:(requestSuccessBlock)successBlock
              failure:(requestFailureBlock)failureBlock {
    AFHTTPSessionManager *manager = [self getRequestManager];
    if (![self beforeHttpRequest:manager]) {
        !failureBlock ? : failureBlock(nil);
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    [manager DELETE:url
         parameters:params
            success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
                [strongSelf printUrlResponse:urlResponse response:responseObject];
                !successBlock ? : successBlock(urlResponse.statusCode, responseObject);
            }
            failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
                [strongSelf printUrlResponse:urlResponse response:error];
                !failureBlock ? : failureBlock(error);
            }];
}

@end
