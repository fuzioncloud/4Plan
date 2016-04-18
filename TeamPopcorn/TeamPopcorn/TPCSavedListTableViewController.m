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

@interface TPCSavedListTableViewController ()
@property (strong, nonatomic) TPCStateManager *dataStore;

@end

@implementation TPCSavedListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataStore = [TPCStateManager currentState];
    NSLog(@"count %li", self.dataStore.savedRooms.count);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataStore.savedRooms.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"savedCell" forIndexPath:indexPath];
    
    TPCRoom *currentRoom = self.dataStore.savedRooms[indexPath.row];
    
    cell.textLabel.text = currentRoom.name;
    cell.detailTextLabel.text = @"wooooo";
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    TPCMainViewController *destinationVC = segue.destinationViewController;
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    TPCRoom *selectedRoom = self.dataStore.savedRooms[indexPath.row];
    
    destinationVC.currentRoom = selectedRoom;
    
}



@end
