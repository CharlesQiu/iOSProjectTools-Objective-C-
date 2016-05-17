//
//  AFNShareClient.h
//  QHSTemplateProject
//
//  Created by Charles on 5/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFNShareClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
