//
//  ViewController.h
//  WebBrowser
//
//  Created by Gustavo Genovese on 05/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerProtocol.h"

@interface ViewController : UIViewController <UIWebViewDelegate, UITextFieldDelegate, ViewControllerProtocol>

@end
