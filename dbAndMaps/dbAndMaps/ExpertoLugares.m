//
//  ExpertoLugares.m
//  dbAndMaps
//
//  Created by Gustavo Genovese on 20/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import "ExpertoLugares.h"
#import "AppDelegate.h"

@interface ExpertoLugares()
@property(nonatomic, strong) NSManagedObjectContext* context;
@end

@implementation ExpertoLugares

@synthesize context = _context;

+ (ExpertoLugares *)sharedInstance {
    static ExpertoLugares* instancia = nil;
    
    if (instancia == nil){
        instancia = [[ExpertoLugares alloc]init];
    }
    return instancia;
}

-(id)init {
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* ctx = [appDelegate managedObjectContext];
    self.context = ctx;
    
    return [super init];
}

-(void)guardarLugarConNombre:(NSString *)nombre Longitud:(float)longitud Latitud:(float)latitud {
    Lugar* lugar = [NSEntityDescription insertNewObjectForEntityForName:@"Lugar"
                                                 inManagedObjectContext:self.context];
    lugar.nombre = nombre;
    lugar.longitud = [NSNumber numberWithFloat:longitud];
    lugar.latitud = [NSNumber numberWithFloat:latitud];
    NSError *error = nil;
    if (![_context save:&error]){
        //manejar el error
    }
}

-(void)guardarLugarConNombre:(NSString *)nombre
                    Longitud:(float)longitud
                     Latitud:(float)latitud
                       Fecha:(NSDate *)fecha {
    Lugar* lugar = [NSEntityDescription insertNewObjectForEntityForName:@"Lugar"
                                                 inManagedObjectContext:self.context];
    lugar.nombre = nombre;
    lugar.longitud = [NSNumber numberWithFloat:longitud];
    lugar.latitud = [NSNumber numberWithFloat:latitud];
    lugar.fecha = fecha;
    NSError *error = nil;
    if (![_context save:&error]){
        NSLog(@"Error al guardar un lugar: %@", [error description]);
    }
}

-(NSArray *)lugares {
    NSEntityDescription* entidad = [NSEntityDescription entityForName:@"Lugar"
                                               inManagedObjectContext:_context];
    
    NSFetchRequest* req = [[NSFetchRequest alloc]init];
    [req setEntity:entidad];
    
    NSSortDescriptor *orden = [[NSSortDescriptor alloc] initWithKey:@"nombre" ascending:YES];
    NSArray *ordenes = [[NSArray alloc] initWithObjects:orden, nil];
    [req setSortDescriptors:ordenes];
    
    NSError* error = nil;
    NSArray* todosLosLugares = [_context executeFetchRequest:req error:&error];
    return todosLosLugares;
}

-(void)eliminarLugarConNombre:(NSString *)nombre {
    NSEntityDescription* entidad = [NSEntityDescription entityForName:@"Lugar"
                                               inManagedObjectContext:_context];

    NSFetchRequest* req = [[NSFetchRequest alloc]init];
    [req setEntity:entidad];
    
    NSPredicate* predicado = [NSPredicate
                              predicateWithFormat:@"self.nombre == %@", nombre];
    [req setPredicate:predicado];
    
    NSError* error = nil;
    NSArray* todosLosLugares = [_context executeFetchRequest:req error:&error];
    for (Lugar* lugar in todosLosLugares) {
        [_context deleteObject:lugar];
    }
}

@end
