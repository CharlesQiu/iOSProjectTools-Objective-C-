//
//  AFNHttpBaseService.h
//  QHSTemplateProject
//
//  Created by Charles on 5/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/// Request success.
typedef void (^requestSuccessBlock)(NSInteger statusCode, id responseObj);
/// Request fail
typedef void (^requestFailureBlock)(NSError *error);

@interface AFNHttpBaseService : NSObject

+ (void)getRequest:(NSString *)url
            params:(NSDictionary *)params
           success:(requestSuccessBlock)successBlock
           failure:(requestFailureBlock)failureBlock;

+ (void)postRequest:(NSString *)url
             params:(NSDictionary *)params
            success:(requestSuccessBlock)successBlock
            failure:(requestFailureBlock)failureBlock;

+ (void)putRequest:(NSString *)url
            params:(NSDictionary *)params
           success:(requestSuccessBlock)successBlock
           failure:(requestFailureBlock)failureBlock;

+ (void)deleteRequest:(NSString *)url
               params:(NSDictionary *)params
              success:(requestSuccessBlock)successBlock
              failure:(requestFailureBlock)failureBlock;

@end
