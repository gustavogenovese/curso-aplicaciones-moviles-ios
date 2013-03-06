//
//  VisorImagenController.m
//  Imagenes
//
//  Created by Gustavo Genovese on 02/03/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import "VisorImagenController.h"

@interface VisorImagenController () {
    NSTimer *timer;
    CGFloat distanciaInicial;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation VisorImagenController
@synthesize urlImagen = _urlImagen;
@synthesize imageView = _imageView;
@synthesize toolbar =_toolbar;

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
    NSData* dataImagen = [NSData dataWithContentsOfURL:self.urlImagen];
    self.imageView.image = [UIImage imageWithData:dataImagen];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)volver:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)limpiarToques {
    distanciaInicial = -1;
}

-(CGFloat)distanciaEntreDosPuntos:(CGPoint)desdePunto alPunto:(CGPoint)alPunto {
    float x = alPunto.x - desdePunto.x;
    float y = alPunto.y - desdePunto.y;
    
    return sqrt(x * x + y * y);
}



@end
