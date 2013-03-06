//
//  ViewController.m
//  Imagenes
//
//  Created by Gustavo Genovese on 27/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import "ViewController.h"
#import "VisorImagenController.h"

@interface ViewController ()
{
    NSString* urlApi;

    NSMutableDictionary* dicTitulos;
    NSMutableDictionary* dicMiniaturas;
    NSMutableDictionary* dicImagenes;
}
@property (weak, nonatomic) IBOutlet UITextField *textoBuscar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actividad;
@property (weak, nonatomic) IBOutlet UIButton *botonBuscar;

@end

@implementation ViewController
@synthesize textoBuscar = _textoBuscar;
@synthesize tableView = _tableView;
@synthesize actividad = _actividad;
@synthesize botonBuscar = _botonBuscar;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    urlApi = @"https://www.googleapis.com/customsearch/v1?";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [_actividad stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*) apiKey {
    return @"AIzaSyAObJyMWEi11q6QRAJilEdIljDrjuNgKw4";
}

-(NSString*) customSearchEngine {
    return @"011515669867851143791:2u9amsumlnc";
}

- (IBAction)buscar:(UIButton *)sender {
    [self.textoBuscar resignFirstResponder];
    
    [_actividad startAnimating];
    self.botonBuscar.hidden = YES;
    NSString* busquedaEscrita = self.textoBuscar.text;
    NSString* busqueda =  [busquedaEscrita stringByReplacingOccurrencesOfString:@" "
                                                                     withString:@"%20"];
    [self.textoBuscar setPlaceholder:
        [NSString stringWithFormat:@"Buscando \"%@\"...", busquedaEscrita ] ];
    
    self.textoBuscar.text = @"";
    
    dispatch_queue_t q = dispatch_queue_create("HiloBusqueda", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(q, ^{
        NSString* direccion = [NSString stringWithFormat:@"%@key=%@&cx=%@&q=%@",
                               urlApi,
                               [self apiKey],
                               [self customSearchEngine],
                               busqueda];
        NSURL* url = [NSURL URLWithString:direccion];
        
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        
        NSError* error = nil;
        NSURLResponse* response = nil;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
        
        NSDictionary* diccionario = [self jsonDataADictionario:data];
        
        NSArray* items = [diccionario objectForKey:@"items"];
        
        dicTitulos = [[NSMutableDictionary alloc]init];
        dicMiniaturas = [[NSMutableDictionary alloc]init];
        dicImagenes = [[NSMutableDictionary alloc]init];
        for (int i = 0; i<[items count]; i++) {
            NSString* titulo = [self obtenerTituloImagenEnIndice: i
                                                    deResultados:items ];
            
            UIImage* miniatura = [self obtenerMiniaturaEnIndice:i
                                                   deResultados:items];
            NSURL* imagen = [self obtenerURLImagenEnIndice: i
                                              deResultados: items];
            if (titulo){
                [dicTitulos setObject: titulo
                               forKey: [NSNumber numberWithInt: i]];
                
                if (miniatura) {
                    [dicMiniaturas setObject: miniatura
                                      forKey: [NSNumber numberWithInt:i]];
                }
                
                if (imagen) {
                    [dicImagenes setObject:imagen
                                    forKey:[NSNumber numberWithInt:i]];
                }
            }
        }
        
        [self performSelectorOnMainThread:@selector(recargarTableView:) 
                               withObject:busquedaEscrita
                            waitUntilDone:YES];
    });
}

-(void) recargarTableView: (NSString*)textoBuscado {
    [self.tableView reloadData];
    self.textoBuscar.placeholder = @"";
    self.textoBuscar.text = textoBuscado;
    self.botonBuscar.hidden = NO;
    [self.actividad stopAnimating];
}

-(NSString*) obtenerTituloImagenEnIndice: (int) indice deResultados: (NSArray*) resultados {
    NSDictionary* datosImagen = [resultados objectAtIndex: indice];
    NSString* titulo = [datosImagen objectForKey:@"title"];
    return titulo;
}

-(UIImage*) obtenerMiniaturaEnIndice: (int) indice deResultados: (NSArray*) resultados {
    NSDictionary* datosImagen = [resultados objectAtIndex: indice];
    NSDictionary* datosPagina = [datosImagen objectForKey:@"pagemap"];
    NSArray* datosMiniatura = [datosPagina objectForKey:@"cse_thumbnail"];
    NSDictionary* datosRealesMiniatura = [datosMiniatura objectAtIndex:0];
    NSString* direccionImagen = [datosRealesMiniatura objectForKey:@"src"];
    
    NSURL* imagenURL = [NSURL URLWithString:direccionImagen];
    NSData* bytesImagen = [[NSData alloc] initWithContentsOfURL:imagenURL];
    UIImage* imagen = [UIImage imageWithData:bytesImagen];
    return imagen;
}

-(NSURL*) obtenerURLImagenEnIndice: (int) indice deResultados: (NSArray*) resultados {
    NSDictionary* datosImagen = [resultados objectAtIndex: indice];
    NSDictionary* datosPagina = [datosImagen objectForKey:@"pagemap"];
    NSArray* datosImg = [datosPagina objectForKey:@"cse_image"];
    NSDictionary* datosRealesImg = [datosImg objectAtIndex:0];
    NSString* direccionImagen = [datosRealesImg objectForKey:@"src"];
    NSURL* imagenURL = [NSURL URLWithString:direccionImagen];
    return imagenURL;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [dicTitulos count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Imagen"];
    
    NSNumber* key = [NSNumber numberWithInt:[indexPath row]];
    UIImage* miniatura = [dicMiniaturas objectForKey:key ];
    [cell.imageView setImage: miniatura];

    NSString* titulo = [dicTitulos objectForKey:key]; ;
    cell.textLabel.text = titulo;
    return cell;
}

-(NSDictionary *)jsonDataADictionario:(NSData *)data {
    NSError *error = nil;
    id ret = [NSJSONSerialization JSONObjectWithData:data
                                             options:NSJSONReadingAllowFragments
                                               error:&error];
    if (error) {
        return nil;
    }
    return ret;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
    NSURL* url = [dicImagenes objectForKey:[NSNumber numberWithInt:[indexPath row]]];
    VisorImagenController* controller = [segue destinationViewController];
    [controller setUrlImagen:url];
}

@end
