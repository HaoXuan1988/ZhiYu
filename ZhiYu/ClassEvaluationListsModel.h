//
//  ClassEvaluationListsModel.h
//  ZhiYu
//
//  Created by 吕浩轩 on 16/5/30.
//  Copyright © 2016年 上海先致信息股份有限公司. All rights reserved.
//

#import "BaseModel.h"

@class Evalzan,Evalfiles,Evalmsg;
@interface ClassEvaluationListsModel : NSObject

@property (nonatomic, copy) NSString *evaId;

@property (nonatomic, copy) NSString *teachId;

@property (nonatomic, copy) NSString *evaluation;

@property (nonatomic, copy) NSString *evaluationDate;

@property (nonatomic, copy) NSString *teachName;

@property (nonatomic, copy) NSString *stuName;

@property (nonatomic, copy) NSString *photoPath;

@property (nonatomic, assign) BOOL isLike;

@property (nonatomic, strong) NSArray<Evalzan *> *evalZan;

@property (nonatomic, copy) NSString *stuId;

@property (nonatomic, strong) NSMutableArray<Evalfiles *> *evalFiles;

@property (nonatomic, strong) NSArray<Evalmsg *> *evalMsg;


@end
@interface Evalzan : NSObject

@property (nonatomic, copy) NSString *evaZanId;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *userName;

@end

@interface Evalfiles : NSObject

@property (nonatomic, copy) NSString *evaFileId;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *filePath;

@end

@interface Evalmsg : NSObject

@property (nonatomic, copy) NSString *evalType;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *evaMsgId;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *replayEvaMsgId;

@property (nonatomic, copy) NSString *replayUserId;

@property (nonatomic, copy) NSString *replayUserName;

@end
