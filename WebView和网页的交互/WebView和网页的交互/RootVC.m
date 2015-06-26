//
//  RootVC.m
//  WebView和网页的交互
//
//  Created by lanou3g on 15/6/22.
//  Copyright (c) 2015年 fengjie. All rights reserved.
//

#import "RootVC.h"

@interface RootVC ()<UIWebViewDelegate>
@property (nonatomic,retain)UIActivityIndicatorView *loading;


@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.webview
    UIWebView *webview =[[UIWebView alloc]init];
    webview.frame=self.view.bounds;
    webview.delegate=self;
    //隐藏scrollview
    webview.scrollView.hidden=YES;
    [self.view addSubview:webview];
    webview.scalesPageToFit=YES;
    
    //2.加载页面
    NSURLRequest *requst =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.dianping.com/tuan/deal/5501525"]];
    [webview loadRequest:requst];
    
    //创建菊花
    UIActivityIndicatorView *loadingview =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    CGRect rect =[UIScreen mainScreen].bounds;
    loadingview.center=CGPointMake(rect.size.width/2, rect.size.height/2);
    [loadingview startAnimating];
    [self.view addSubview:loadingview];
    self.loading=loadingview;
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //执行js代码 将大正点评网页里面多余的节点删除
//    var html =document.body.innerHTML
//    NSString *html =[webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML;"];
//    NSLog(@"%@",html);
    
    NSMutableString *js =[NSMutableString string];
    //0.删除顶部的导航条
    [js appendString:@"var header = document.getElementsByTagName('header')[0];"];
    [js appendString:@"header.parentNode.removeChild(header);"];
    
    //1.删除底下的链接
    [js appendString:@"var footer = document.getElementsByTagName('footer')[0];"];
    [js appendString:@"footer.parentNode.removeChild(footer);"];
    [webView stringByEvaluatingJavaScriptFromString:js];
    //显示scrollview
    webView.scrollView.hidden=NO;
    
    //删除菊花
    [self.loading removeFromSuperview];
}

@end
