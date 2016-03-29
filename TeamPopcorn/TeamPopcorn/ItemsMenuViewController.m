//
//  ViewController.m
//  TeamPopcorn
//
//  Created by Flatiron School on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "ItemsMenuViewController.h"
#import "FPCItemCell.h"


@interface ItemsMenuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *itemsTableView;

@property (strong, nonatomic) NSDictionary<NSString *,NSArray *> *itemsMenu;

@end

@implementation ItemsMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // For now I'm just faking the data
    self.itemsMenu = @{ @"Sofas" : @[@"#1 sofa"],
                        @"Chairs": @[@"#1 chair"]
                      };
    
    
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
    NSString *sectionKey = self.itemsMenu.allKeys[section];
    return self.itemsMenu[sectionKey].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FPCItemCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"Item Cell"];
    NSString *imageName = [self tableView:tableView titleForHeaderInSection:indexPath.section];
    itemCell.itemImage.image = [UIImage imageNamed:imageName];
    NSString *sectionKey = self.itemsMenu.allKeys[indexPath.section];
    itemCell.itemName.text = self.itemsMenu[sectionKey][indexPath.row];
    return itemCell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.itemsMenu.allKeys[section];
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.itemsMenu.allKeys;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}
@end
