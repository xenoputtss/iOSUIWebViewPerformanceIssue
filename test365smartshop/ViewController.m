

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

    [self CreateWebView:@"https://192.168.1.106/testList/"];
}

-(void)CreateWebView:(NSString *)url{
    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 60, 1024,768)];
    [webview setTag:99];
    //    NSString *url=@"http://www.google.com";
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];

    [webview loadRequest:nsrequest];

    [self.view addSubview:webview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Memory Warning"
                                                    message:@"More info..."
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Say Hello",nil];
    [alert show];
}

- (IBAction)testPress:(id)sender {
//    [_webView reload];
    NSString *currentURL;
    for(UIView *subView in self.view.subviews){
        if(subView.tag==99){
            currentURL= ((UIWebView *)subView).request.URL.absoluteString;
            [subView removeFromSuperview];
        }
    }

    [self CreateWebView:@"https://192.168.1.106/testList/"];
}

@end
