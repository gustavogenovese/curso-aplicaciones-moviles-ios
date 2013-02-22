//
//  ViewController.m
//  WebBrowserUniversal
//
//  Created by Gustavo Genovese on 17/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation ViewController

- (void) openURL: (NSString*) url
{
    NSURL* nsurl = [NSURL URLWithString:url];
    NSURLRequest* request = [NSURLRequest requestWithURL:nsurl];
    [self.webview loadRequest:request];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self openURL:@"http://fb.com"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [self.webview goBack];
}

- (IBAction)goForward:(id)sender {
    [self.webview goForward];
}

@end
