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
    self.itemsTableView.sectionIndexBackgroundColor = [UIColor lightGrayColor];
    self.itemsTableView.sectionIndexTrackingBackgroundColor = [UIColor whiteColor];
    
    
    
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
//    NSString *imageName = [self tableView:tableView titleForHeaderInSection:indexPath.section];
//    itemCell.itemImage.image = [UIImage imageNamed:imageName];
    
    TPCCatalogDescriber *sectionKey = [TPCCatalogDescriber describerForIndex:indexPath.section];
    
    TPCFurniture *piece = self.itemsMenu[sectionKey][indexPath.row];
    itemCell.itemImage.image = piece.image;
    itemCell.itemName.text = piece.name;
    itemCell.itemDimensions.text =
//<<<<<<< HEAD
        [NSString stringWithFormat:@"W: %lldcm  H:%lldcm  L: %lldcm",
//=======
//        [NSString stringWithFormat:@"W: %lucm  H:%lucm  L: %lucm",
//>>>>>>> master
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TPCCatalogDescriber *sectionKey = [TPCCatalogDescriber describerForIndex:indexPath.section];
    TPCFurniture *selectedFurniture = self.itemsMenu[sectionKey][indexPath.row];
//<<<<<<< HEAD
    TPCFurniture *itemToUse;
    
    
    
    switch (sectionKey.catalogIndex) {
        case BedIndex: {
            TPCBed *bed = (TPCBed *)selectedFurniture;
//=======
//    TPCFurniture*itemToUse;
//    
//    switch (sectionKey.catalogIndex) {
//        case BedIndex: {
//            TPCBed*bed = (TPCBed*)selectedFurniture;
//>>>>>>> master
            itemToUse = [[TPCBed alloc] initWithBedSize:bed.bedSize];
        }
            break;
        case ChairIndex: {
//<<<<<<< HEAD
            TPCChair *chair = (TPCChair *)selectedFurniture;
////=======
//            TPCChair*chair = (TPCChair*)selectedFurniture;
//>>>>>>> master
            itemToUse = [[TPCChair alloc] initWithChairstlye:chair.chairStyle];
        }
            break;
        case MiscIndex: {
//<<<<<<< HEAD
            TPCMisc *stuff = (TPCMisc *)selectedFurniture;
            itemToUse = [[TPCMisc alloc] initWithMiscStlye:stuff.miscStyle];
//=======
//            TPCMisc*misc = (TPCMisc*)selectedFurniture;
//            itemToUse = [[TPCMisc alloc] initWithMiscStlye:misc.miscStyle];
//>>>>>>> master
        }
            break;
        case SofaIndex: {
//<<<<<<< HEAD
//            TPCSofa *sofa = (TPCSofa *)selectedFurniture;
//=======
            TPCSofa*sofa = (TPCSofa*)selectedFurniture;
//>>>>>>> master
            itemToUse = [[TPCSofa alloc] initWithSofaStlye:sofa.sofaStyle];
        }
            break;
        case TableIndex: {
//<<<<<<< HEAD
//            TPCTable *table = (TPCTable *)selectedFurniture;
//=======
            TPCTable*table = (TPCTable*)selectedFurniture;
//>>>>>>> master
            itemToUse = [[TPCTable alloc] initWithTableStlye:table.tableStyle];
        }
            break;
        default:
            break;
//<<<<<<< HEAD
    }
    
    itemToUse.widthScale = itemToUse.width*self.dataStore.room.scaleForFurnitureW;
    itemToUse.lengthScale = itemToUse.length*self.dataStore.room.scaleForFurnitureL;
    
    if ((itemToUse.widthScale > self.dataStore.room.scaledWidth)||(itemToUse.lengthScale > self.dataStore.room.scaledLength)) {
        NSLog(@"helloooo");
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"Your item is too large for the room" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okay = [UIAlertAction actionWithTitle:@"okay" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                         }];
            [alert addAction:okay];
            [self presentViewController:alert animated:YES completion:nil];
//=======
//>>>>>>> master
        
            }
    
//<<<<<<< HEAD
        else {
            
            [self.dataStore placeFuriniture:itemToUse];
            [self dismissViewControllerAnimated:YES completion:nil];
//=======
    itemToUse.widthScale=itemToUse.width*self.dataStore.room.scaleForFurnitureW;
    itemToUse.lengthScale=itemToUse.length*self.dataStore.room.scaleForFurnitureL;
    
  
    
    
    if ((itemToUse.widthScale>self.dataStore.room.scaledWidth)||(itemToUse.lengthScale>self.dataStore.room.scaledLength)) {
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"Your item is too large for the room." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okay = [UIAlertAction actionWithTitle:@"okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//>>>>>>> master
            
        }];
        
        [alert addAction:okay];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
//<<<<<<< HEAD
//=======
//    else {
//    [self.arrangedFurniture placeFuriniture:selectedFurniture];

//    [self dismissViewControllerAnimated:YES completion:nil];
//    }
//>>>>>>> master
    

    TPCMainViewController *papa = (TPCMainViewController *)self.navigationController.parentViewController;
    if (papa) {
        [papa viewWillAppear:NO];
        [papa showDismissMenu];
    }
        }
}


@end
