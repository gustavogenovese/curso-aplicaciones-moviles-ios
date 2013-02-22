//
//  ViewController.m
//  Calculadora
//
//  Created by Gustavo Genovese on 11/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import "ViewController.h"
#import "CalculadoraBackend.h"

@interface ViewController ()
{
   CalculadoraBackend* backend; 
}
@property (weak, nonatomic) IBOutlet UILabel *display;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    backend = [[CalculadoraBackend alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(UIButton *)sender {
    [backend recibirBuffer:sender.tag];
    [self actualizarDisplay];
}

- (void) actualizarDisplay {
    int valorMostrar = [backend valorBuffer];
    NSString* cadena = [NSString stringWithFormat:@"%d", valorMostrar];
    
    [self.display setText:cadena];
}

- (IBAction)operationPressed:(UIButton *)sender {
    [backend realizarOperacion:sender.tag];
}

- (IBAction)equalsPressed:(UIButton *)sender {
    [backend calcular];
    [self actualizarDisplay];
}



@end
