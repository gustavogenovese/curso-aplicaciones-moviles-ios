//
//  CalculadoraBackend.m
//  HolaMundo
//
//  Created by Gustavo Genovese on 05/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import "CalculadoraBackend.h"

@implementation CalculadoraBackend

- (void) recibirBuffer:(int)digito {
    buffer = buffer * 10 + digito;
}

- (int)valorBuffer {
    return buffer;
}

- (void)realizarOperacion:(int)oper
{
    operacion = oper;
    bufferOperacion = buffer;
    buffer = 0;
}


- (int)calcular {
    switch (operacion) {
        case 0: //suma
            buffer = bufferOperacion + buffer;
            break;
            
        case 1: //resta
            buffer = bufferOperacion - buffer;
            break;
            
        case 2: // multiplicacion
            buffer = bufferOperacion * buffer;
            break;
            
        case 3: //division
            buffer = bufferOperacion / buffer;
            break;
            
        default:
            break;
    }
    return buffer;
}
@end
