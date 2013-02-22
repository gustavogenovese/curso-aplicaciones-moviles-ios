//
//  ViewControllerProtocol.h
//  WebBrowser
//
//  Created by Gustavo Genovese on 11/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewControllerProtocol <NSObject>
@required
-(void)newUrlChosen: (NSString*) url;

@end
