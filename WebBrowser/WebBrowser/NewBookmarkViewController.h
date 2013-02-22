//
//  NewBookmarkViewController.h
//  WebBrowser
//
//  Created by Gustavo Genovese on 11/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookmarksViewControllerProtocol.h"

@interface NewBookmarkViewController : UIViewController
-(void) setListener: (id <BookmarksViewControllerProtocol>)listener;
@end
