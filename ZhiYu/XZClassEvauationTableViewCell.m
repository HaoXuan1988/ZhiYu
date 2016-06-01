//
//  XZClassEvauationTableViewCell.m
//  ZhiYu
//
//  Created by 吕浩轩 on 16/5/31.
//  Copyright © 2016年 上海先致信息股份有限公司. All rights reserved.
//

#import "XZClassEvauationTableViewCell.h"

@implementation XZClassEvauationTableViewCell
{
    CGFloat totalHeight;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
    }
    return self;
}


- (void)setModel:(ClassEvaluationListsModel *)model indexPath:(NSIndexPath *)indexPath {
    
    _model = model;
    totalHeight = 0;

}

- (CGSize)sizeThatFits:(CGSize)size {
    
    return CGSizeMake(size.width, totalHeight);
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
