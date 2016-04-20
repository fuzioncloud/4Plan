//
//  TPCItemsMenuViewController.m
//  TeamPopcorn
//
//  Created by Flatiron School on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCItemsMenuViewController.h"
#import "TPCItemCell.h"
#import "TPCModelsGenerator.h"
#import "TPCStateManager.h"
#import "TPCMainViewController.h"
#import "TPCRoom.h"

@interface TPCItemsMenuViewController ()<UITableViewDataSource, UITableViewDelegate, TPCMainViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *itemsTableView;

@property (strong, nonatomic) NSDictionary<TPCCatalogDescriber *,NSArray<TPCFurniture *> *> *itemsMenu;

@property (strong, nonatomic) TPCStateManager *dataStore;


@property (strong, nonatomic) TPCMainViewController *mainvc;


@end

@implementation TPCItemsMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.mainvc.delegate=self;
    // For now I'm just faking the data
    self.itemsMenu = [TPCModelsGenerator generateModels];
    
    self.dataStore = [TPCStateManager currentState];
    
    self.itemsTableView.dataSource = self;
    self.itemsTableView.delegate = self;
    

    
    self.itemsTableView.sectionIndexColor = [UIColor blackColor];
    
    self.itemsTableView.sectionIndexBackgroundColor = [UIColor colorWithRed:175.0/255.0f green:117.0/255.0f blue:117.0f/255.0f alpha:1.0f]; //reddish color
    self.itemsTableView.sectionIndexTrackingBackgroundColor = [UIColor colorWithRed:250.0f/255.0f green:242.0f/255.0f blue:198.0f/255.0f alpha:1.0]; // white color
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.itemsMenu.allKeys.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TPCCatalogDescriber *sectionKey = [TPCCatalogDescriber describerForIndex:section];
    return self.itemsMenu[sectionKey].count;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TPCItemCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"Item Cell"];

    
    TPCCatalogDescriber *sectionKey = [TPCCatalogDescriber describerForIndex:indexPath.section];
    
    TPCFurniture *piece = self.itemsMenu[sectionKey][indexPath.row];
    itemCell.itemImage.image = piece.image;
    itemCell.itemName.text = piece.name;
    itemCell.itemDimensions.text =

        [NSString stringWithFormat:@"W: %lldin  H:%lldin  L: %lldin",

                            piece.width, piece.height, piece.length];
    return itemCell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    TPCCatalogDescriber *sectionKey = [TPCCatalogDescriber describerForIndex:section];
    return sectionKey.catalogName;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray<NSString *> *indexTitle = [NSMutableArray<NSString *> new];
    for (TPCCatalogDescriber *key in self.itemsMenu.allKeys) {
        [indexTitle addObject:key.catalogName];
    }
    return indexTitle;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.backgroundView.backgroundColor = [UIColor colorWithRed:175.0/255.0f green:117.0f/255.0f blue:117.0f/255.0f alpha:1.0f];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TPCCatalogDescriber *sectionKey = [TPCCatalogDescriber describerForIndex:indexPath.section];
    TPCFurniture *selectedFurniture = self.itemsMenu[sectionKey][indexPath.row];
    TPCFurniture *itemToUse;
    
    
    
    switch (sectionKey.catalogIndex) {
        case BedIndex: {
            TPCBed *bed = (TPCBed *)selectedFurniture;

            itemToUse = [[TPCBed alloc] initWithBedSize:bed.bedSize];
        }
            break;
        case ChairIndex: {

            TPCChair *chair = (TPCChair *)selectedFurniture;

            itemToUse = [[TPCChair alloc] initWithChairstlye:chair.chairStyle];
        }
            break;
        case MiscIndex: {

            TPCMisc *stuff = (TPCMisc *)selectedFurniture;
            itemToUse = [[TPCMisc alloc] initWithMiscStlye:stuff.miscStyle];

        }
            break;
        case SofaIndex: {

            TPCSofa*sofa = (TPCSofa*)selectedFurniture;

            itemToUse = [[TPCSofa alloc] initWithSofaStlye:sofa.sofaStyle];
        }
            break;
        case TableIndex: {

            TPCTable*table = (TPCTable*)selectedFurniture;

            itemToUse = [[TPCTable alloc] initWithTableStlye:table.tableStyle];
        }
            break;
        default:
            break;

    }
    
    itemToUse.widthScale = itemToUse.width*self.dataStore.room.scaleForFurnitureW;
    itemToUse.lengthScale = itemToUse.length*self.dataStore.room.scaleForFurnitureL;
    
    if ((itemToUse.widthScale > self.dataStore.room.scaledWidth)||(itemToUse.lengthScale > self.dataStore.room.scaledLength)) {
        NSLog(@"helloooo");
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"Your item is too large for the room" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:okay];

        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        [self.dataStore placeFuriniture:itemToUse];
        [self dismissViewControllerAnimated:YES completion:nil];

        itemToUse.widthScale=itemToUse.width*self.dataStore.room.   scaleForFurnitureW;
        itemToUse.lengthScale=itemToUse.length*self.dataStore.room.scaleForFurnitureL;
    
  
    
    
        if ((itemToUse.widthScale>self.dataStore.room.scaledWidth)||(itemToUse.lengthScale>self.dataStore.room.scaledLength)) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"Your item is too large for the room." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okay = [UIAlertAction actionWithTitle:@"okay" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:okay];
        [self presentViewController:alert animated:YES completion:nil];
        }
    

        TPCMainViewController *papa = (TPCMainViewController *)self.navigationController.parentViewController;
        if (papa) {
            [papa viewWillAppear:NO];
            [papa showDismissMenu];
        }
    }
}


@end
