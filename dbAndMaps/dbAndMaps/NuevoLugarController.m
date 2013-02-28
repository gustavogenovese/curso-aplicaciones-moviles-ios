//
//  NuevoLugarController.m
//  dbAndMaps
//
//  Created by Gustavo Genovese on 20/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import "NuevoLugarController.h"
#import "ExpertoLugares.h"

@interface NuevoLugarController () {
    double longitudInicial;
    double latitudInicial;
}
@property (weak, nonatomic) IBOutlet UITextField *lugarTextfield;
@property (weak, nonatomic) IBOutlet MKMapView *mapaLugar;
@property (weak, nonatomic) IBOutlet UIDatePicker *fechaDatePicker;
@property (weak, nonatomic) IBOutlet UISwitch *guardarFecha;
@end

@implementation NuevoLugarController
@synthesize lugarTextfield = _lugarTextfield;
@synthesize mapaLugar = _mapaLugar;
@synthesize fechaDatePicker = _fechaDatePicker;
@synthesize guardarFecha = _guardarFecha;

@synthesize listener = _listener;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CLLocationCoordinate2D annotationCoord;
    annotationCoord.latitude = -32.9;
    annotationCoord.longitude = -68.8;
        
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = @"Mendoza";
    annotationPoint.subtitle = @"Mendoza";
    [self.mapaLugar addAnnotation:annotationPoint];
    
    [self.mapaLugar setDelegate:self];
    [self.lugarTextfield setDelegate:self];

}

-(void)viewDidAppear:(BOOL)animated {
    CLLocationCoordinate2D annotationCoord;
    if (longitudInicial == 0 && latitudInicial == 0) {
        annotationCoord.latitude = -32.9;
        annotationCoord.longitude = -68.8;
    } else {
        annotationCoord.longitude = longitudInicial;
        annotationCoord.latitude = latitudInicial;
    }
    self.mapaLugar.centerCoordinate = annotationCoord;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)guardarFechaChanged:(id)sender {
    self.fechaDatePicker.hidden = !self.guardarFecha.isOn;
}

- (IBAction)guardarLugar:(UIBarButtonItem *)sender {
    float longitud = self.mapaLugar.centerCoordinate.longitude;
    float latitud = self.mapaLugar.centerCoordinate.latitude;
    
    NSLog(@"Coordenadas %f, %f", longitud, latitud);
    
    NSLog(@"Guardar fecha %s",
          self.guardarFecha.isOn ? "SI" : "NO");

    NSDate* date = self.fechaDatePicker.date;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    
    NSLog(@"Dia: %d, Mes: %d: Año: %d", [components day], [components month], [components year]);
    
    NSLog(@"Lugar %@", self.lugarTextfield.text);
    
    if (self.guardarFecha.isOn){
            [[ExpertoLugares sharedInstance] guardarLugarConNombre:self.lugarTextfield.text Longitud:longitud Latitud:latitud Fecha:date];
    }else{
        [[ExpertoLugares sharedInstance] guardarLugarConNombre:self.lugarTextfield.text Longitud:longitud Latitud:latitud];
    }
    [self.listener nuevoLugarAgregado];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setLugarTextfield:nil];
    [self setMapaLugar:nil];
    [self setFechaDatePicker:nil];
    [self setGuardarFecha:nil];
    [super viewDidUnload];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"Coordenadas %f, %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    //mapView.centerCoordinate = userLocation.location.coordinate;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)setLongitudInicial:(double)longitud yLatitud:(double)latitud {
    longitudInicial = longitud;
    latitudInicial = latitud;
}
@end
