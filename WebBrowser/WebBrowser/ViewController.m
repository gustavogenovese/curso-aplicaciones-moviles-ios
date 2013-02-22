//
//  ViewController.m
//  WebBrowser
//
//  Created by Gustavo Genovese on 05/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import "ViewController.h"
#import "BookmarksViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *addressBar;

@end

@implementation ViewController
@synthesize webView = _webView;
@synthesize addressBar = _addressBar;

- (void) openURL: (NSString*) url
{
    NSURL* nsurl = [NSURL URLWithString:url];
    NSURLRequest* request = [NSURLRequest requestWithURL:nsurl];
    [self.webView loadRequest:request];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self openURL:@"http://www.google.com" ];
    
    [_addressBar setDelegate:self];
    [_webView setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self.webView goBack];
}

- (IBAction)forwardButton:(id)sender {
    [self.webView goForward];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    [self openURL:textField.text];

    [textField resignFirstResponder];
    return NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.addressBar.text = webView.request.URL.absoluteString;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id destination = [segue destinationViewController];
    BookmarksViewController* controller = (BookmarksViewController*)destination;
    [controller setUrlListener:self];
}

-(void)newUrlChosen:(NSString *)url
{
    [self openURL:url];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL* url = request.URL;
    NSString* host = [url.host lowercaseString];
    
    NSLog(@"Host del sitio a abrir: '%@'", host);
    
    return [host hasSuffix:@"google.com"] ||
           [host hasSuffix:@"google.com.ar"] ||
           [host hasSuffix:@"twitter.com"] ||
           [host hasSuffix:@"facebook.com"];
}
@end
