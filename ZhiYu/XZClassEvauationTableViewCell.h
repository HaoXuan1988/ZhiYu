//
//  XZClassEvauationTableViewCell.h
//  ZhiYu
//
//  Created by 吕浩轩 on 16/5/31.
//  Copyright © 2016年 上海先致信息股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassEvaluationListsModel.h"

@interface XZClassEvauationTableViewCell : UITableViewCell

@property (nonatomic, strong) ClassEvaluationListsModel *model;


- (void)setModel:(ClassEvaluationListsModel *)model indexPath:(NSIndexPath *)indexPath;

@end
