//
//  ViewController.m
//  dbAndMaps
//
//  Created by Gustavo Genovese on 20/02/13.
//  Copyright (c) 2013 Gustavo Genovese. All rights reserved.
//

#import "ViewController.h"
#import "ExpertoLugares.h"
#import "NuevoLugarController.h"


@interface ViewController ()
@property (nonatomic, strong) NSArray* lugares;
@end

@implementation ViewController

@synthesize lugares = _lugares;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _lugares = [[ExpertoLugares sharedInstance] lugares];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_lugares count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Lugar* lugar =[_lugares objectAtIndex:[indexPath row]];
    cell.textLabel.text = lugar.nombre;

    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        UITableViewCell* celda = [tableView cellForRowAtIndexPath:indexPath];
        NSString* nombreLugar = celda.textLabel.text;
        [[ExpertoLugares sharedInstance] eliminarLugarConNombre:nombreLugar];
        [self refresh:nil];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NuevoLugarController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"NuevoLugarController"];
    
    Lugar* lugar =[_lugares objectAtIndex:[indexPath row]];
    
    [myController setLongitudInicial: [lugar.longitud doubleValue]
                            yLatitud: [lugar.latitud doubleValue ] ];
    [self.navigationController pushViewController: myController animated:YES];
}

- (IBAction)refresh:(id)sender {
    _lugares = [[ExpertoLugares sharedInstance] lugares];
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[NuevoLugarController class]]) {
        [(NuevoLugarController*)[segue destinationViewController] setListener:self];
    }
}

-(void)nuevoLugarAgregado {
    _lugares = [[ExpertoLugares sharedInstance] lugares];
    [self.tableView reloadData];
    [self crearNotificacion];
}

- (void)crearNotificacion {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *notificacion = [[UILocalNotification alloc] init];

    notificacion.alertBody = @"Nuevo lugar agregado";
    notificacion.soundName = UILocalNotificationDefaultSoundName;
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Objeto 1", @"Llave 1", @"Objeto 2", @"Llave 2", nil];
    notificacion.userInfo = infoDict;
    
    NSDate *ahora = [NSDate date];
    notificacion.fireDate = ahora;
    ahora = [ahora dateByAddingTimeInterval:5];
    [[UIApplication sharedApplication] scheduleLocalNotification:notificacion];
}

@end
