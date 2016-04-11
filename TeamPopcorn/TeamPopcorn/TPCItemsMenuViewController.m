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

@interface TPCItemsMenuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *itemsTableView;

@property (strong, nonatomic) NSDictionary<TPCCatalogDescriber *,NSArray<TPCFurniture *> *> *itemsMenu;

@property (strong, nonatomic) TPCStateManager *arrangedFurniture;

@property (strong, nonatomic) TPCStateManager *arrangedButtons;

@end

@implementation TPCItemsMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // For now I'm just faking the data
    self.itemsMenu = [TPCModelsGenerator generateModels];
    
    
    self.itemsTableView.dataSource = self;
    self.itemsTableView.delegate = self;
    
    self.itemsTableView.sectionIndexColor = [UIColor blackColor];
    self.itemsTableView.sectionIndexBackgroundColor = [UIColor lightGrayColor];
    self.itemsTableView.sectionIndexTrackingBackgroundColor = [UIColor whiteColor];
    
    self.arrangedFurniture = [TPCStateManager currentState];
    self.arrangedButtons = [TPCStateManager currentState];
    
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
        [NSString stringWithFormat:@"W: %lucm  H:%lucm  L: %lucm",
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
    
//    NSLog(@"%@", selectedFurniture.name);
    
    [self.arrangedFurniture placeFuriniture:selectedFurniture];

    
    [self dismissViewControllerAnimated:YES completion:nil];
//    NSLog(@"%@", self.arrangedFurniture.arrangedFurniture);

    TPCMainViewController *papa = (TPCMainViewController *)self.navigationController.parentViewController;
    if (papa) {
        [papa viewWillAppear:NO];
        [papa showDismissMenu];
    }

}


@end
