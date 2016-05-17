//
//  AFNHttpBaseResponse.m
//  QHSTemplateProject
//
//  Created by Charles on 5/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "AFNHttpBaseResponse.h"

@interface AFNHttpBaseResponse ()

@property (nonatomic, copy) NSDictionary *originalDict;

@end

@implementation AFNHttpBaseResponse

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.originalDict = dic;
    }
    return self;
}

@end
