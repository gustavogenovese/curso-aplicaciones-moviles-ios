//
//  BookmarksExpert.m
//  WebBrowser
//
//  Created by Gustavo Genovese on 11/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import "BookmarksExpert.h"

@interface BookmarksExpert(){
    NSMutableArray* bookmarks;
    NSMutableArray* bookmarksTitle;
}

@end

@implementation BookmarksExpert

+(BookmarksExpert *)sharedInstance {
    static BookmarksExpert* instance = nil;
    if (instance == nil) {
        instance = [[BookmarksExpert alloc]init];
    }
    return instance;
}


-(id)init {
    
    bookmarksTitle = [NSMutableArray arrayWithObjects:@"Facebook", @"Twitter", @"Gmail", nil];
    
    bookmarks = [NSMutableArray arrayWithObjects:@"http://www.facebook.com", @"http://twitter.com", @"http://gmail.com", nil];
    return [super init];
}

-(int)bookmarksCount {
    return [bookmarks count];
}

-(NSString *)bookmarkTitleAtIndex:(int)index {
    return [bookmarksTitle objectAtIndex:index];
}

-(NSString*) bookmarkURLAtIndex:(int)index {
    return [bookmarks objectAtIndex:index];
}

- (void)addBookmark:(NSString *)bookmark withURL:(NSString *)url{
    if ([bookmark length] > 0 &&[url length] > 0){
        [bookmarksTitle addObject:bookmark];
        [bookmarks addObject:url];
    }
}

-(void)deleteBookmarkAtIndex:(int)index {
    [bookmarks removeObjectAtIndex:index];
}

@end
