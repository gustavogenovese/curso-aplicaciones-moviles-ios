//
//  BookmarksExpert.h
//  WebBrowser
//
//  Created by Gustavo Genovese on 11/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookmarksExpert : NSObject

+ (BookmarksExpert*)sharedInstance;

- (int) bookmarksCount;
- (NSString*) bookmarkTitleAtIndex: (int)index;
- (NSString*) bookmarkURLAtIndex: (int)index;

















- (void) addBookmark: (NSString*) bookmark withURL: (NSString*) url;
- (void) deleteBookmarkAtIndex: (int) index;

@end
