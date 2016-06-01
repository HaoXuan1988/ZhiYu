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
//#import "MJExtension.h"

static NSString *classEvauationTableViewCellIdentifier = @"XZClassEvauationTableViewCell";

@interface RootViewController ()<WKUIDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)WKWebView *webView;
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,assign)int page;
@property (nonatomic,strong) UITableView *tabelView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
    NSDictionary *file2 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://img4.imgtn.bdimg.com/it/u=3264623887,731292429&fm=21&gp=0.jpg"};
    NSDictionary *file3 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://img.gougoutu.com/upload/201404/16/201404162039409761.jpg"};
    NSDictionary *file4 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://img5.imgtn.bdimg.com/it/u=3425851328,2681317699&fm=21&gp=0.jpg"};
    NSDictionary *file5 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://pic9.nipic.com/20100904/4845745_195609329636_2.jpg"};
    NSDictionary *file6 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://hiphotos.baidu.com/praisejesus/pic/item/e8df7df89fac869eb68f316d.jpg"};
    NSDictionary *file7 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://img.61gequ.com/allimg/2011-4/201142614314278502.jpg"};
    NSDictionary *file8 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://pic37.nipic.com/20140209/8821914_163234218136_2.jpg"};
    NSDictionary *file9 = @{@"evaFileId":@"11111111", @"createDate":@"111111", @"type":@"1", @"filePath":@"http://pic1.nipic.com/2008-11-13/2008111384358912_2.jpg"};
    NSArray *files = @[file1, file2, file3, file4, file5, file6, file7, file8, file9];
    [manager postWithUrl:@"http://satisfy.cn:8163/teachingCloudDev/api/app/getEvaluationList" params:dic success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        [hub hide:NO];
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
                
                for (NSDictionary *dic in list) {
                    ClassEvaluationListsModel *model = [ClassEvaluationListsModel mj_objectWithKeyValues:dic];
                    model.evalFiles = [NSMutableArray array];
                    for (NSDictionary *dic in files) {
                        Evalfiles *aa = [[Evalfiles alloc]init];
                        aa.type = dic[@"type"];
                        aa.createDate = @"111111";
                        aa.filePath = dic[@"filePath"];
                        aa.evaFileId = @"11111111";
                        [model.evalFiles addObject:aa];
                    }
                   NSLog(@"%@", model.evalFiles);
                    [_data addObject:model];
                }
            }
        }else if (![code isEmpty]) {
            
            [MBProgressHUD bwm_showTitle:responseObject[@"desc"] toView:self.view hideAfter:2];
        }
        
    } fail:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [hub hide:NO];
        [MBProgressHUD bwm_showTitle:@"请检查网络" toView:self.view hideAfter:2];
    }];
    
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
    
    return [tableView fd_heightForCellWithIdentifier:classEvauationTableViewCellIdentifier cacheByIndexPath:indexPath configuration:^(XZClassEvauationTableViewCell *cell) {
        [cell setModel:[_data objectAtIndex:indexPath.row] indexPath:indexPath];
    }];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XZClassEvauationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:classEvauationTableViewCellIdentifier];
    
    cell.fd_enforceFrameLayout = YES;
    [cell setModel:[_data objectAtIndex:indexPath.row] indexPath:indexPath];
    
    return cell;
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
