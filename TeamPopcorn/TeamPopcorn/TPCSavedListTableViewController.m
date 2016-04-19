//
//  TPCSavedListTableViewController.m
//  TeamPopcorn
//
//  Created by susan lovaglio on 4/13/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCSavedListTableViewController.h"
#import "TPCStateManager.h"
#import "TPCModels.h"
#import "TPCMainViewController.h"

@interface TPCSavedListTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TPCStateManager *dataStore;

@end

@implementation TPCSavedListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataStore = [TPCStateManager currentState];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

}


-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataStore.savedRooms.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"savedCell" forIndexPath:indexPath];
    
    TPCRoom *currentRoom = self.dataStore.savedRooms[indexPath.row];
    
    cell.textLabel.text = currentRoom.name;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES if you want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        TPCRoom *thingToDelete = self.dataStore.savedRooms[indexPath.row];
        NSManagedObjectContext *context = self.dataStore.managedObjectContext;
        [context deleteObject:thingToDelete];
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"woopsies error");
        }
         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *segueID = segue.identifier;
    if ([segueID isEqualToString:@"Show Floorplan Picker"]) {
        // add code here in the future
    }
    else if ([segueID isEqualToString:@"Show Main"]) {
        TPCMainViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TPCRoom *selectedRoom = self.dataStore.savedRooms[indexPath.row];
        destinationVC.currentRoom = selectedRoom;
    }
}


@end
