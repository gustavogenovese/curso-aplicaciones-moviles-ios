//
//  NuevoLugarController.h
//  dbAndMaps
//
//  Created by Gustavo Genovese on 20/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NuevoLugarAgregadoProtocol.h"

@interface NuevoLugarController : UIViewController<MKMapViewDelegate, UITextFieldDelegate>
@property (nonatomic, weak) id<NuevoLugarAgregadoProtocol> listener;

-(void)setLongitudInicial: (double) longitud yLatitud: (double)latitud;
@end
