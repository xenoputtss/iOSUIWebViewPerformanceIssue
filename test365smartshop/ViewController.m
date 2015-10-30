

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Press Me" forState:UIControlStateNormal];
    [button sizeToFit];
    // Set a new (x,y) point for the button's center
    button.center = CGPointMake(320/2, 30);
    [button addTarget:self action:@selector(testPress:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    urlToLoad = @"";
    [self removeWebViewControl];
    [self performSelector:@selector(createWebView:) withObject:@"" afterDelay:.1];
    [self performSelector:@selector(webViewNavigate:) withObject:@"https://qa05.365smartshop.com/testList/" afterDelay:.2 ];
}

-(void)webViewNavigate:(NSString*) url{
        NSURL *nsurl=[NSURL URLWithString:url];
        NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
        [webView loadRequest: nsrequest];
}

-(void)webViewExternalLogin:(NSString*) url{
        NSString* newUrl = [url stringByAppendingString:@"/home/externallogin"];
        NSURL *nsLoginurl=[NSURL URLWithString:newUrl];
        NSString *body = [NSString stringWithFormat: @"email=%@&password=%@", @"rforster",@"a"];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:nsLoginurl];
        [request setHTTPMethod: @"POST"];
        [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
        [webView loadRequest: request];
}

-(void)createWebView:(NSString*) junk{
    webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 60, 300,600)];
    [webView setTag:99];
    [self.view addSubview:webView];
    [webView setDelegate:self];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //Due to a bug with iOS 9* and UIWebView we need to reload the control every so often
    //I chose 100 as a number sto start off at.
    loadCount +=1;
    if(loadCount > 100 && [urlToLoad length] == 0){
        //we have had about 100 page loads, lets reset the control
        loadCount = 0;

        [self removeWebViewControl];
        [self performSelector:@selector(createWebView:) withObject:@"" afterDelay:.1];
        [self performSelector:@selector(webViewNavigate:) withObject:@"https://qa05.365smartshop.com/testList/" afterDelay:.2 ];
//        [self webViewNavigate:@"https://qa05.365smartshop.com/testList/"];
//        [self webViewExternalLogin:@"https://qa05.365smartshop.com/testList/"];
    }else if([urlToLoad length] >0){
        //If there is a urlToLoad, load it and clear the handle
        //This is put into place because when we create the UIWebView control we
        //first call a login method, when that returns we want to direct our user
        //back to where they were
        NSString * nsurl=urlToLoad;
        urlToLoad = @"";
        [self webViewNavigate:nsurl];
    }
}

-(void)removeWebViewControl{
    NSString *currentURL;
    for(UIView *subView in self.view.subviews){
        if(subView.tag==99){
            currentURL= ((UIWebView *)subView).request.URL.absoluteString;
            [subView removeFromSuperview];
        }
    }
    urlToLoad = currentURL;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)testPress:(id)sender {

    [self removeWebViewControl];
    [self createWebView: @""];
    [self webViewNavigate:@"https://qa05.365smartshop.com/testList/"];

}

@end
