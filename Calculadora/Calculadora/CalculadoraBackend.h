//
//  CalculadoraBackend.h
//  HolaMundo
//
//  Created by Gustavo Genovese on 05/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculadoraBackend : NSObject{
    int buffer;
    int operacion;
    int bufferOperacion;
}


- (void) recibirBuffer: (int) digito;
- (int) valorBuffer;

- (void) realizarOperacion: (int)oper;

- (int) calcular;

@end
