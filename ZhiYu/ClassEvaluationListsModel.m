//
//  ClassEvaluationListsModel.m
//  ZhiYu
//
//  Created by 吕浩轩 on 16/5/30.
//  Copyright © 2016年 上海先致信息股份有限公司. All rights reserved.
//

#import "ClassEvaluationListsModel.h"

@implementation ClassEvaluationListsModel

+ (NSDictionary *)objectClassInArray{
    return @{@"evalZan" : [Evalzan class], @"evalFiles" : [Evalfiles class], @"evalMsg" : [Evalmsg class]};
}
@end
@implementation Evalfiles

@end


@implementation Evalzan

@end


@implementation Evalmsg

@end
