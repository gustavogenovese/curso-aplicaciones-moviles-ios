//
//  BookmarksViewController.m
//  WebBrowser
//
//  Created by Gustavo Genovese on 06/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import "BookmarksViewController.h"
#import "BookmarksExpert.h"
#import "NewBookmarkViewController.h"

@interface BookmarksViewController (){

    id <ViewControllerProtocol> listener;

}

@property (weak, nonatomic) IBOutlet UIButton *botonAgregar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation BookmarksViewController
@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    
/*    CGRect tableFrame;
    tableFrame.origin.x = 0;
    tableFrame.origin.y = self.botonAgregar.frame.size.height;
    tableFrame.size.width = self.view.frame.size.width;
    tableFrame.size.height = self.view.frame.size.height - self.botonAgregar.frame.size.height;
    _tableView.frame = tableFrame;
*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[BookmarksExpert sharedInstance] bookmarksCount];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"bookmark";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellId];

    cell.textLabel.text =  [[BookmarksExpert sharedInstance] bookmarkTitleAtIndex:[indexPath row]] ;
     return cell;
}










-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [[BookmarksExpert sharedInstance] deleteBookmarkAtIndex:[indexPath row]];
        [_tableView reloadData];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* selectedBookmark = [[BookmarksExpert sharedInstance]bookmarkURLAtIndex:[indexPath row]];
    NSLog(@"%@", selectedBookmark);
    [self dismissViewControllerAnimated:YES completion:nil];
    [listener newUrlChosen: selectedBookmark];
}

-(void)setUrlListener:(id<ViewControllerProtocol> )newListener
{
    listener = newListener;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NewBookmarkViewController* controller = (NewBookmarkViewController*)[segue destinationViewController];
    [controller setListener:self];
}

-(void)newBookmarkWithTitle:(NSString *)title andURL:(NSString *)url {
    [[BookmarksExpert sharedInstance] addBookmark:title withURL:url];
    [_tableView reloadData];
}


@end
