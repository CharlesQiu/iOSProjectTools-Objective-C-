//
//  AFNShareClient.m
//  QHSTemplateProject
//
//  Created by Charles on 5/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "AFNShareClient.h"

@implementation AFNShareClient

static AFNShareClient *_sharedClient = nil;

+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[super allocWithZone:NULL] init];
    });
    
    return _sharedClient;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [AFNShareClient sharedClient];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [AFNShareClient sharedClient];
}

@end
