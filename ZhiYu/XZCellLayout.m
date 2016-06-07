//
//  XZCellLayout.m
//  ZhiYu
//
//  Created by 吕浩轩 on 16/6/1.
//  Copyright © 2016年 上海先致信息股份有限公司. All rights reserved.
//

#import "XZCellLayout.h"
#import "LWTextParser.h"
#import "CommentModel.h"

@implementation XZCellLayout

- (instancetype)initWithStatusModel:(ClassEvaluationListsModel *)stautsModel index:(NSInteger)index {
    
    self = [super init];
    if (self) {
        self.stautsModel = stautsModel;
        
        //头像模型 avatarImageStorage
        LWImageStorage *avatarStorage = [[LWImageStorage alloc]init];
        avatarStorage.placeholder = [UIImage imageNamed:@"[face]"];
        avatarStorage.contents = stautsModel.photoPath;
        avatarStorage.cornerRadius = 20.0f;
        avatarStorage.cornerBackgroundColor = [UIColor whiteColor];
        avatarStorage.fadeShow = YES;
        avatarStorage.clipsToBounds = NO;
        avatarStorage.frame = CGRectMake(10, 20, 40, 40);
        
        //名字模型 nameTextStorage
        LWTextStorage* nameTextStorage = [[LWTextStorage alloc] init];
        NSString *name = [NSString stringWithFormat:@"%@ 老师", stautsModel.teachName];
        nameTextStorage.text = name;
        nameTextStorage.font = [UIFont fontWithName:@"Heiti SC" size:15.0f];
        nameTextStorage.frame = CGRectMake(60.0f, 20.0f, SCREEN_WIDTH - 80.0f, CGFLOAT_MAX);
        [nameTextStorage lw_addLinkWithData:name
                                      range:NSMakeRange(0,stautsModel.teachName.length)
                                  linkColor:RGB(113, 129, 161, 1)
                             highLightColor:RGB(0, 0, 0, 0.15)];
        
        //正文内容模型 contentTextStorage
        LWTextStorage* contentTextStorage = [[LWTextStorage alloc] init];
        contentTextStorage.text = stautsModel.evaluation;
        contentTextStorage.font = [UIFont fontWithName:@"Heiti SC" size:15.0f];
        contentTextStorage.textColor = RGB(40, 40, 40, 1);
        contentTextStorage.frame = CGRectMake(nameTextStorage.left, nameTextStorage.bottom + 10.0f, SCREEN_WIDTH - 80.0f, CGFLOAT_MAX);
        [LWTextParser parseEmojiWithTextStorage:contentTextStorage];
        
        [LWTextParser parseTopicWithLWTextStorage:contentTextStorage
                                        linkColor:RGB(113, 129, 161, 1)
                                   highlightColor:RGB(0, 0, 0, 0.15)];
        
        [LWTextParser parseHttpURLWithTextStorage:contentTextStorage
                                        linkColor:RGB(113, 129, 161, 1)
                                   highlightColor:RGB(0, 0, 0, 0.15)];
        
        [LWTextParser parseAccountWithTextStorage:contentTextStorage
                                        linkColor:RGB(113, 129, 161, 1)
                                   highlightColor:RGB(0, 0, 0, 0.15)];
        
        
        //发布的图片模型 imgsStorage
        CGFloat imageWidth = (SCREEN_WIDTH - 110.0f)/3.0f;
        NSInteger imageCount = [stautsModel.evalFiles count];
        NSMutableArray* imageStorageArray = [[NSMutableArray alloc] initWithCapacity:imageCount];
        NSMutableArray* imagePositionArray = [[NSMutableArray alloc] initWithCapacity:imageCount];

            NSInteger row = 0;
            NSInteger column = 0;
            if (imageCount == 1) {
                CGRect imageRect = CGRectMake(nameTextStorage.left,
                                              contentTextStorage.bottom + 5.0f + (row * (imageWidth + 5.0f)),
                                              imageWidth*1.7,
                                              imageWidth*1.7);
                NSString* imagePositionString = NSStringFromCGRect(imageRect);
                [imagePositionArray addObject:imagePositionString];
                LWImageStorage* imageStorage = [[LWImageStorage alloc] init];
                imageStorage.frame = imageRect;
                NSString* URLString = [[stautsModel.evalFiles objectAtIndex:0] filePath];
                imageStorage.contents = [NSURL URLWithString:URLString];
                [imageStorageArray addObject:imageStorage];
            } else {
                for (NSInteger i = 0; i < imageCount; i ++) {
                    CGRect imageRect = CGRectMake(nameTextStorage.left + (column * (imageWidth + 5.0f)),
                                                  contentTextStorage.bottom + 5.0f + (row * (imageWidth + 5.0f)),
                                                  imageWidth,
                                                  imageWidth);
                    NSString* imagePositionString = NSStringFromCGRect(imageRect);
                    [imagePositionArray addObject:imagePositionString];
                    LWImageStorage* imageStorage = [[LWImageStorage alloc] init];
                    imageStorage.frame = imageRect;
                    imageStorage.placeholder = [UIImage imageNamed:@"[face]"];
                    NSString* URLString = [[stautsModel.evalFiles objectAtIndex:i] filePath];
                    imageStorage.contents = [NSURL URLWithString:URLString];
                    [imageStorageArray addObject:imageStorage];
                    column = column + 1;
                    if (column > 2) {
                        column = 0;
                        row = row + 1;
                    }
                }
            }
            
        //获取最后一张图片的模型
        LWImageStorage* lastImageStorage = (LWImageStorage *)[imageStorageArray lastObject];
        
        //生成时间的模型 dateTextStorage
        LWTextStorage* dateTextStorage = [[LWTextStorage alloc] init];
        dateTextStorage.text = stautsModel.evaluationDate;
        dateTextStorage.font = [UIFont fontWithName:@"Heiti SC" size:13.0f];
        dateTextStorage.textColor = [UIColor grayColor];
        
        //菜单按钮
        CGRect menuPosition;
        if (lastImageStorage) {
            menuPosition = CGRectMake(SCREEN_WIDTH - 54.0f,10.0f + lastImageStorage.bottom - 14.5f,44,44);
            dateTextStorage.frame = CGRectMake(nameTextStorage.left, lastImageStorage.bottom + 10.0f, SCREEN_WIDTH - 80.0f, CGFLOAT_MAX);
            
        } else {
            menuPosition = CGRectMake(SCREEN_WIDTH - 54.0f,10.0f + contentTextStorage.bottom  - 14.5f ,44,44);
            dateTextStorage.frame = CGRectMake(nameTextStorage.left, contentTextStorage.bottom + 10.0f, SCREEN_WIDTH - 80.0f, CGFLOAT_MAX);
        }
        
        //生成评论背景Storage
        LWImageStorage* commentBgStorage = [[LWImageStorage alloc] init];
        NSArray* commentTextStorages = @[];
        CGRect commentBgPosition = CGRectZero;
        CGRect rect = CGRectMake(60.0f,dateTextStorage.bottom + 5.0f, SCREEN_WIDTH - 80, 20);
        CGFloat offsetY = 0.0f;
    
        //点赞
        LWImageStorage* likeImageSotrage = [[LWImageStorage alloc] init];
        LWTextStorage* likeTextStorage = [[LWTextStorage alloc] init];
        if (self.stautsModel.evalZan.count != 0) {
            likeImageSotrage.contents = [UIImage imageNamed:@"Like"];
            likeImageSotrage.frame = CGRectMake(rect.origin.x + 10.0f,rect.origin.y + 10.0f + offsetY,16.0f, 16.0f);
            NSMutableString* mutableString = [[NSMutableString alloc] init];
            NSMutableArray* composeArray = [[NSMutableArray alloc] init];
            int rangeOffset = 0;
            for (NSInteger i = 0;i < self.stautsModel.evalZan.count; i ++) {
                NSString* liked = [self.stautsModel.evalZan[i] userName];
                [mutableString appendString:liked];
                NSRange range = NSMakeRange(rangeOffset, liked.length);
                [composeArray addObject:[NSValue valueWithRange:range]];
                rangeOffset += liked.length;
                if (i != self.stautsModel.evalZan.count - 1) {
                    NSString* dotString = @",";
                    [mutableString appendString:dotString];
                    rangeOffset += 1;
                }
            }
            likeTextStorage.text = mutableString;
            likeTextStorage.font = [UIFont fontWithName:@"Heiti SC" size:14.0f];
            likeTextStorage.frame = CGRectMake(likeImageSotrage.right + 5.0f, rect.origin.y + 7.0f, SCREEN_WIDTH - 110.0f, CGFLOAT_MAX);
            for (NSValue* rangeValue in composeArray) {
                NSRange range = [rangeValue rangeValue];
                CommentModel* commentModel = [[CommentModel alloc] init];
                commentModel.to = [likeTextStorage.text substringWithRange:range];
                commentModel.index = index;
                [likeTextStorage lw_addLinkWithData:commentModel range:range linkColor:RGB(113, 129, 161, 1) highLightColor:RGB(0, 0, 0, 0.15)];
            }
            offsetY += likeTextStorage.height + 5.0f;
        }
        if (stautsModel.evalMsg.count != 0 && stautsModel.evalMsg != nil) {
            if (self.stautsModel.evalZan.count != 0) {
                self.lineRect = CGRectMake(nameTextStorage.left, likeTextStorage.bottom + 2.5f,  SCREEN_WIDTH - 80, 0.1f);
            }
            NSMutableArray* tmp = [[NSMutableArray alloc] initWithCapacity:stautsModel.evalMsg.count];
            for (Evalmsg* evalMsg in stautsModel.evalMsg) {
                NSString* to;
                if ([evalMsg.evalType isEqualToString:@"1"]) {
                    to = evalMsg.replayUserName;
                }else{
                    to = nil;
                }
                if (to.length != 0) {
                    NSString* commentString = [NSString stringWithFormat:@"%@回复%@:%@",evalMsg.userName,evalMsg.replayUserName,evalMsg.content];
                    LWTextStorage* commentTextStorage = [[LWTextStorage alloc] init];
                    commentTextStorage.text = commentString;
                    commentTextStorage.font = [UIFont fontWithName:@"Heiti SC" size:14.0f];
                    commentTextStorage.textColor = RGB(40, 40, 40, 1);
                    commentTextStorage.frame = CGRectMake(rect.origin.x + 10.0f, rect.origin.y + 10.0f + offsetY,SCREEN_WIDTH - 95.0f, CGFLOAT_MAX);
                    
                    CommentModel* commentModel_1 = [[CommentModel alloc] init];
                    commentModel_1.to = evalMsg.userName;
                    commentModel_1.index = index;
                    [commentTextStorage lw_addLinkWithData:commentModel_1
                                                     range:NSMakeRange(0,[(NSString *)evalMsg.userName length])
                                                 linkColor:RGB(113, 129, 161, 1)
                                            highLightColor:RGB(0, 0, 0, 0.15)];
                    
                    CommentModel* commentModel_2 = [[CommentModel alloc] init];
                    commentModel_2.to = [NSString stringWithFormat:@"%@",evalMsg.replayUserName];
                    commentModel_2.index = index;
                    
                    [commentTextStorage lw_addLinkWithData:commentModel_2
                                                     range:NSMakeRange([(NSString *)evalMsg.userName length] + 2,[(NSString *)evalMsg.replayUserName length])
                                                 linkColor:RGB(113, 129, 161, 1)
                                            highLightColor:RGB(0, 0, 0, 0.15)];
                    
                    [LWTextParser parseTopicWithLWTextStorage:commentTextStorage
                                                    linkColor:RGB(113, 129, 161, 1)
                                               highlightColor:RGB(0, 0, 0, 0.15)];
                    [LWTextParser parseEmojiWithTextStorage:commentTextStorage];
                    [tmp addObject:commentTextStorage];
                    offsetY += commentTextStorage.height;
                } else {
                    NSString* commentString = [NSString stringWithFormat:@"%@:%@",evalMsg.userName,evalMsg.content];
                    LWTextStorage* commentTextStorage = [[LWTextStorage alloc] init];
                    commentTextStorage.text = commentString;
                    commentTextStorage.font = [UIFont fontWithName:@"Heiti SC" size:14.0f];
                    commentTextStorage.textAlignment = NSTextAlignmentLeft;
                    commentTextStorage.linespacing = 2.0f;
                    commentTextStorage.textColor = RGB(40, 40, 40, 1);
                    commentTextStorage.frame = CGRectMake(rect.origin.x + 10.0f, rect.origin.y + 10.0f + offsetY,SCREEN_WIDTH - 95.0f, CGFLOAT_MAX);
                    
                    CommentModel* commentModel = [[CommentModel alloc] init];
                    commentModel.to = evalMsg.userName;
                    commentModel.index = index;
                    [commentTextStorage lw_addLinkWithData:commentModel
                                                     range:NSMakeRange(0,[(NSString *)evalMsg.userName length])
                                                 linkColor:RGB(113, 129, 161, 1)
                                            highLightColor:RGB(0, 0, 0, 0.15)];
                    
                    [LWTextParser parseTopicWithLWTextStorage:commentTextStorage
                                                    linkColor:RGB(113, 129, 161, 1)
                                               highlightColor:RGB(0, 0, 0, 0.15)];
                    [LWTextParser parseEmojiWithTextStorage:commentTextStorage];
                    [tmp addObject:commentTextStorage];
                    offsetY += commentTextStorage.height;
                }
            }
            //如果有评论，设置评论背景Storage
            commentTextStorages = tmp;
            commentBgPosition = CGRectMake(60.0f,dateTextStorage.bottom + 5.0f, SCREEN_WIDTH - 80, offsetY + 15.0f);
            commentBgStorage.frame = commentBgPosition;
            commentBgStorage.contents = [UIImage imageNamed:@"comment"];
            [commentBgStorage stretchableImageWithLeftCapWidth:40 topCapHeight:15];
        }
//        *************************将要在同一个LWAsyncDisplayView上显示的Storage要全部放入同一个LWLayout中**************************************
//        *************************我们将尽量通过合并绘制的方式将所有在同一个View显示的内容全都异步绘制在同一个AsyncDisplayView上*************************
//        *************************这样的做法能最大限度的节省系统的开销*************************
        [self addStorage:nameTextStorage];
        [self addStorage:contentTextStorage];
        [self addStorage:dateTextStorage];
        [self addStorages:commentTextStorages];
        [self addStorage:avatarStorage];
        [self addStorage:commentBgStorage];
        [self addStorage:likeImageSotrage];
        [self addStorages:imageStorageArray];
        if (likeTextStorage) {
            [self addStorage:likeTextStorage];
        }
        //一些其他属性
        self.menuPosition = menuPosition;
        self.commentBgPosition = commentBgPosition;
        self.imagePostionArray = imagePositionArray;
        self.stautsModel = stautsModel;
        //如果是使用在UITableViewCell上面，可以通过以下方法快速的得到Cell的高度
        self.cellHeight = [self suggestHeightWithBottomMargin:15.0f];
        
    }
    return self;
}

@end
