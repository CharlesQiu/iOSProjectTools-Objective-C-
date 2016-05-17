//
//  AFNHttpBaseResponse.h
//  QHSTemplateProject
//
//  Created by Charles on 5/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNHttpBaseResponse : NSObject

@property (nonatomic, assign) BOOL      success;
@property (nonatomic, assign) NSInteger statusCode;
/// 原始数据
@property (nonatomic, readonly, copy) NSDictionary *originalDict;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
