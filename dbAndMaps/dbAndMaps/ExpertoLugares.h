//
//  ExpertoLugares.h
//  dbAndMaps
//
//  Created by Gustavo Genovese on 20/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Lugar.h"

@interface ExpertoLugares : NSObject
+ (ExpertoLugares*) sharedInstance;

-(void)guardarLugarConNombre: (NSString*) nombre Longitud: (float)longitud Latitud: (float)latitud;

-(void)guardarLugarConNombre: (NSString*) nombre Longitud: (float)longitud Latitud: (float)latitud Fecha:(NSDate*)fecha;

-(NSArray*) lugares;

@end
