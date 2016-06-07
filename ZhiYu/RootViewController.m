//
//  RootViewController.m
//  app
//
//  Created by 吕浩轩 on 16/5/9.
//  Copyright © 2016年 上海先致信息股份有限公司. All rights reserved.
//

#import "RootViewController.h"
#import "ClassEvaluationListsModel.h"
#import "XZClassEvauationTableViewCell.h"
#import "XZCellLayout.h"
#import "CommentView.h"

static NSString *classEvauationTableViewCellIdentifier = @"XZClassEvauationTableViewCell";

@interface RootViewController ()<WKUIDelegate,UITableViewDelegate,UITableViewDataSource,TableViewCellDelegate>
@property (nonatomic,strong)WKWebView *webView;
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,assign)int page;
@property (nonatomic,strong) UITableView *tabelView;

@property (nonatomic,strong) CommentView* commentView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"朋友圈";
    self.data = [NSMutableArray array];
    
    [self.view addSubview:self.tabelView];
    _page = 1;
    [self loadData];
}

- (void)loadData {
    MBProgressHUD *hub = [MBProgressHUD bwm_showDeterminateHUDTo:self.view];
    
    HXResponseManager *manager = [HXResponseManager manager];
    NSDictionary *dic = @{
        @"pageSize" : @"10",
        @"schoolId" : @"1",
        @"brandCode" : @"88bbcn_dev",
        @"stuId" : @"1448088198822",
        @"pageNum" : [NSNumber numberWithInt:_page]
    };
    
    
    NSDictionary *file1 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://v1.qzone.cc/pic/201510/31/11/17/563432b7977c7764.jpeg%21600x600.jpg"};
    NSDictionary *file2 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://bizhi.4493.com/uploads/allimg/141010/4-141010150301.jpg"};
    NSDictionary *file3 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://img.gougoutu.com/upload/201404/16/201404162039409761.jpg"};
    NSDictionary *file4 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://img.taopic.com/uploads/allimg/130529/240454-13052ZS41658.jpg"};
    NSDictionary *file5 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://pic9.nipic.com/20100904/4845745_195609329636_2.jpg"};
    NSDictionary *file6 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://hiphotos.baidu.com/praisejesus/pic/item/e8df7df89fac869eb68f316d.jpg"};
    NSDictionary *file7 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://img.61gequ.com/allimg/2011-4/201142614314278502.jpg"};
    NSDictionary *file8 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://pic37.nipic.com/20140209/8821914_163234218136_2.jpg"};
    NSDictionary *file9 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://pic1.nipic.com/2008-11-13/2008111384358912_2.jpg"};

    
    NSArray *files = @[file1, file2, file3, file4, file5, file6, file7, file8, file9];
    
    [manager postWithUrl:@"http://satisfy.cn:8163/teachingCloudDev/api/app/getEvaluationList" params:dic success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSString *code = responseObject[@"code"];
        if (![code isEmpty] && [code isEqualToString:@"0"]) {
            
            NSArray *list = responseObject[@"list"];
            if (![list isEmpty]) {
                
                if (_page == 1) {
                    [_data removeAllObjects];
                }
                if (task) {
                    _page++;
                }
                
                for (int i = 0; i < list.count; i++) {
                    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:list[i]];
                    ClassEvaluationListsModel *model = [ClassEvaluationListsModel mj_objectWithKeyValues:dic];
                    model.photoPath = @"http://d.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=b2219135b51bb0518f71bb2e064af68c/738b4710b912c8fcd8986bdafa039245d68821b9.jpg";
                    model.evalFiles = [NSMutableArray array];
                    for (NSDictionary *dic in files) {
                        Evalfiles *aa = [[Evalfiles alloc]init];
                        aa.type = dic[@"type"];
                        aa.createDate = dic[@"createDate"];
                        aa.filePath = dic[@"filePath"];
                        aa.evaFileId = dic[@"evaFileId"];
                        [model.evalFiles addObject:aa];
                    }
                    
                    XZCellLayout* layout = [self layoutWithStatusModel:model index:i];
                    [_data addObject:layout];
                }
                
                
                [_tabelView reloadData];
                [hub hide:NO];
            }
        }else if (![code isEmpty]) {
            
            [MBProgressHUD bwm_showTitle:responseObject[@"desc"] toView:self.view hideAfter:2];
        }
        
    } fail:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [hub hide:NO];
        [MBProgressHUD bwm_showTitle:@"请检查网络" toView:self.view hideAfter:2];
    }];
    
}

- (XZCellLayout *)layoutWithStatusModel:(ClassEvaluationListsModel *)statusModel index:(NSInteger)index {
    //生成Layout
    XZCellLayout* layout = [[XZCellLayout alloc] initWithStatusModel:statusModel index:index];
    return layout;
}

- (UITableView *)tabelView {
    if (!_tabelView) {
        _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tabelView.delegate = self;
        _tabelView.dataSource = self;
        
        [_tabelView registerClass:[XZClassEvauationTableViewCell class] forCellReuseIdentifier:classEvauationTableViewCellIdentifier];
    }
    return _tabelView;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.data.count >= indexPath.row) {
        XZCellLayout* layout = self.data[indexPath.row];
        return layout.cellHeight;
    }
    return 0;
//    return [tableView fd_heightForCellWithIdentifier:classEvauationTableViewCellIdentifier cacheByIndexPath:indexPath configuration:^(XZClassEvauationTableViewCell *cell) {
//        [cell setModel:[_data objectAtIndex:indexPath.row] indexPath:indexPath];
//    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XZClassEvauationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:classEvauationTableViewCellIdentifier];
    
    cell.fd_enforceFrameLayout = YES;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    if (self.data.count >= indexPath.row) {
        XZCellLayout* cellLayout = self.data[indexPath.row];
        cell.cellLayout = cellLayout;
    }
    
    return cell;
}

/***  点赞 ***/


/***  点击评论 ***/
- (void)tableViewCell:(XZClassEvauationTableViewCell *)cell didClickedCommentWithCellLayout:(XZCellLayout *)layout
          atIndexPath:(NSIndexPath *)indexPath {
    
}


/***  发表评论 ***/
- (void)postCommentWithCommentModel:(ClassEvaluationListsModel *)model {
    
}


/***  点击图片 ***/
- (void)tableViewCell:(XZClassEvauationTableViewCell *)cell didClickedImageWithCellLayout:(XZCellLayout *)layout atIndex:(NSInteger)index {
    
}

/***  点击链接 ***/
- (void)tableViewCell:(XZClassEvauationTableViewCell *)cell didClickedLinkWithData:(id)data {
    
}


//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    
//}

#pragma navigationDelegate
//- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
//    
//}
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    
//}
//
//- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//    
//}
//
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    
//}
//
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//    
//}
//
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    
//}
//
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
//    
//}
//
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//    
//}
//
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
//    
//}
//
//- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
//    return nil;
//}

#pragma UIDelegate
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
//    
//}
//
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
//    
//}
//
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
//    
//}
//
//- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
//    
//}
//
//- (void)webViewDidClose:(WKWebView *)webView {
//    
//}

//- (WKWebView *)webView {
//    
//}
//
//- (void)setWebView:(WKWebView *)webView {
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
