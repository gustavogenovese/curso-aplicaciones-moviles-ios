//
//  DetailViewController.h
//  Imagenes
//
//  Created by Gustavo Genovese on 27/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
