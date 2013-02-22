//
//  BookmarksViewController.h
//  WebBrowser
//
//  Created by Gustavo Genovese on 06/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerProtocol.h"
#import "BookmarksViewControllerProtocol.h"

@interface BookmarksViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, BookmarksViewControllerProtocol>
- (void)setUrlListener: (id <ViewControllerProtocol> ) listener;

@end
