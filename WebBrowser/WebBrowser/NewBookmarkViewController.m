//
//  NewBookmarkViewController.m
//  WebBrowser
//
//  Created by Gustavo Genovese on 11/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import "NewBookmarkViewController.h"

@interface NewBookmarkViewController (){
    id <BookmarksViewControllerProtocol> listener;
}
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *urlText;

@end

@implementation NewBookmarkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setListener:(id<BookmarksViewControllerProtocol>)newListener
{
    listener = newListener;
}

- (IBAction)aceptarPressed:(UIButton *)sender {
    [listener newBookmarkWithTitle:self.titleText.text andURL:self.urlText.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelarPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
