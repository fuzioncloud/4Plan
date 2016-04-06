//
//  FPCItemsMenuViewController.m
//  TeamPopcorn
//
//  Created by Flatiron School on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "FPCItemsMenuViewController.h"
#import "FPCItemCell.h"
#import "FPCModelsGenerator.h"
#import "FPCStateManager.h"

@interface FPCItemsMenuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *itemsTableView;

@property (strong, nonatomic) NSDictionary<FPCCatalogDescriber *,NSArray<ENWFurniture *> *> *itemsMenu;

@property (strong, nonatomic) FPCStateManager *arrangedFurniture;

@end

@implementation FPCItemsMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // For now I'm just faking the data
    self.itemsMenu = [FPCModelsGenerator generateModels];
    
    
    self.itemsTableView.dataSource = self;
    self.itemsTableView.delegate = self;
    
    self.itemsTableView.sectionIndexColor = [UIColor blackColor];
    self.itemsTableView.sectionIndexBackgroundColor = [UIColor lightGrayColor];
    self.itemsTableView.sectionIndexTrackingBackgroundColor = [UIColor whiteColor];
    
    self.arrangedFurniture = [FPCStateManager currentState];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.itemsMenu.allKeys.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FPCCatalogDescriber *sectionKey = [FPCCatalogDescriber describerForIndex:section];
    return self.itemsMenu[sectionKey].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FPCItemCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"Item Cell"];
//    NSString *imageName = [self tableView:tableView titleForHeaderInSection:indexPath.section];
//    itemCell.itemImage.image = [UIImage imageNamed:imageName];
    
    FPCCatalogDescriber *sectionKey = [FPCCatalogDescriber describerForIndex:indexPath.section];
    
    ENWFurniture *piece = self.itemsMenu[sectionKey][indexPath.row];
    itemCell.itemImage.image = piece.image;
    itemCell.itemName.text = piece.name;
    itemCell.itemDimensions.text =
        [NSString stringWithFormat:@"W: %lucm  H:%lucm  L: %lucm",
                            piece.width, piece.height, piece.length];
    return itemCell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    FPCCatalogDescriber *sectionKey = [FPCCatalogDescriber describerForIndex:section];
    return sectionKey.catalogName;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray<NSString *> *indexTitle = [NSMutableArray<NSString *> new];
    for (FPCCatalogDescriber *key in self.itemsMenu.allKeys) {
        [indexTitle addObject:key.catalogName];
    }
    return indexTitle;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FPCCatalogDescriber *sectionKey = [FPCCatalogDescriber describerForIndex:indexPath.section];
    
    ENWFurniture *selectedFurniture = self.itemsMenu[sectionKey][indexPath.row];
    
    NSLog(@"%@", selectedFurniture.name);
    
    [self.arrangedFurniture placeFuriniture:selectedFurniture];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@", self.arrangedFurniture.arrangedFurniture);
}


@end
