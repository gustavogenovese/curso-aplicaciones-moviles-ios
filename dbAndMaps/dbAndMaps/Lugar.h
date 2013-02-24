//
//  Lugar.h
//  dbAndMaps
//
//  Created by Gustavo Genovese on 20/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Lugar : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSDate * fecha;
@property (nonatomic, retain) NSNumber * longitud;
@property (nonatomic, retain) NSNumber * latitud;

@end
