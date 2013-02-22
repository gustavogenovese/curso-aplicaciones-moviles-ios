//
//  BookmarksViewControllerProtocol.h
//  WebBrowser
//
//  Created by Gustavo Genovese on 11/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BookmarksViewControllerProtocol <NSObject>
@required
-(void) newBookmarkWithTitle: (NSString*) title andURL: (NSString*)url;

@end
