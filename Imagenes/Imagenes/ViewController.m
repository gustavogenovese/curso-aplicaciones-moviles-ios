//
//  ViewController.m
//  Imagenes
//
//  Created by Gustavo Genovese on 27/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSString* urlApi;
    
    int cantidad;
    NSArray* imagenes;
}
@property (weak, nonatomic) IBOutlet UITextField *textoBuscar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
@synthesize textoBuscar = _textoBuscar;
@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    urlApi = @"https://www.googleapis.com/customsearch/v1?";
    cantidad = 0;
    imagenes = [NSArray arrayWithObjects: nil];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    
    NSString* busqueda =  [self.textoBuscar.text stringByReplacingOccurrencesOfString:@" "
                                                                             withString:@"%20"];
    
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
    
    imagenes = items;
    cantidad = [imagenes count];
    
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return cantidad;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Imagen"];
    
    NSDictionary* datosImagen = [imagenes objectAtIndex: [indexPath row]];
    NSDictionary* datosPagina = [datosImagen objectForKey:@"pagemap"];
    NSArray* datosMiniatura = [datosPagina objectForKey:@"cse_thumbnail"];
    NSDictionary* datosRealesMiniatura = [datosMiniatura objectAtIndex:0];
    NSString* direccionImagen = [datosRealesMiniatura objectForKey:@"src"];
    
    NSURL* imagenURL = [NSURL URLWithString:direccionImagen];
    NSData* bytesImagen = [[NSData alloc] initWithContentsOfURL:imagenURL];
    
    [cell.imageView setImage:[UIImage imageWithData:bytesImagen]];

    NSString* titulo = [datosImagen objectForKey:@"title"];
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


@end
