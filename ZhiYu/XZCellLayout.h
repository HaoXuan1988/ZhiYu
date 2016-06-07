//
//  XZCellLayout.h
//  ZhiYu
//
//  Created by 吕浩轩 on 16/6/1.
//  Copyright © 2016年 上海先致信息股份有限公司. All rights reserved.
//

#import "LWLayout.h"
#import "ClassEvaluationListsModel.h"

@interface XZCellLayout : LWLayout

@property (nonatomic,assign) CGRect lineRect;
@property (nonatomic, strong) ClassEvaluationListsModel *stautsModel;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) CGRect menuPosition;
@property (nonatomic,assign) CGRect commentBgPosition;
@property (nonatomic,copy) NSArray* imagePostionArray;
@property (nonatomic,assign) CGRect websiteRect;

- (instancetype)initWithStatusModel:(ClassEvaluationListsModel *)stautsModel
                    index:(NSInteger)index;
@end
