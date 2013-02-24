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
    
    Lugar* lugar = [[[ExpertoLugares sharedInstance] lugares] objectAtIndex:[indexPath row]];
    cell.textLabel.text = lugar.nombre;

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
}

@end
