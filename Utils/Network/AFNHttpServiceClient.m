//
//  AFNHttpServiceClient.m
//  QHSTemplateProject
//
//  Created by Charles on 5/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "AFNHttpServiceClient.h"
#import "AFNHttpBaseResponse.h"
#import "AFNHttpBaseService.h"

@implementation AFNHttpServiceClient

+ (AFNHttpBaseResponse *)operateResponseObj:(id)responseObj error:(NSError *)error statusCode:(NSInteger)statusCode {
    AFNHttpBaseResponse *res = nil;
    if (error) {
        res         = [[AFNHttpBaseResponse alloc] init];
        res.success = NO;
    } else {
        res         = [[AFNHttpBaseResponse alloc] initWithDic:responseObj];
        res.success = YES;
    }
    res.statusCode = statusCode;
    return res;
}

+ (void)getWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak __typeof(self) weakSelf                                    = self;
    [AFNHttpBaseService getRequest:url params:param success:^(NSInteger statusCode, id responseObj) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([strongSelf operateResponseObj:responseObj error:nil statusCode:statusCode]);
    } failure:^(NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([strongSelf operateResponseObj:nil error:error statusCode:error.code]);
    }];
}

+ (void)postWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak __typeof(self) weakSelf                                    = self;
    [AFNHttpBaseService postRequest:url params:param success:^(NSInteger statusCode, id responseObj) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([strongSelf operateResponseObj:responseObj error:nil statusCode:statusCode]);
    } failure:^(NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([strongSelf operateResponseObj:nil error:error statusCode:error.code]);
    }];
}

+ (void)putWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak __typeof(self) weakSelf                                    = self;
    [AFNHttpBaseService putRequest:url params:param success:^(NSInteger statusCode, id responseObj) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([strongSelf operateResponseObj:responseObj error:nil statusCode:statusCode]);
    } failure:^(NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([strongSelf operateResponseObj:nil error:error statusCode:error.code]);
    }];
}

+ (void)deleteWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak __typeof(self) weakSelf                                    = self;
    [AFNHttpBaseService deleteRequest:url params:param success:^(NSInteger statusCode, id responseObj) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([strongSelf operateResponseObj:responseObj error:nil statusCode:statusCode]);
    } failure:^(NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        !responseDataBlock ? : responseDataBlock([strongSelf operateResponseObj:nil error:error statusCode:error.code]);
    }];
}

@end
