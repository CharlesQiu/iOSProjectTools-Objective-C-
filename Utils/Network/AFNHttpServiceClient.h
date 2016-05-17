//
//  AFNHttpServiceClient.h
//  QHSTemplateProject
//
//  Created by Charles on 5/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFNHttpBaseResponse;
typedef void (^responseOperator)(AFNHttpBaseResponse *response);

@interface AFNHttpServiceClient : NSObject

+ (void)getWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock;

+ (void)postWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock;

+ (void)putWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock;

+ (void)deleteWithUrl:(NSString *)url param:(id)param responseBlock:(responseOperator)responseDataBlock;

@end
