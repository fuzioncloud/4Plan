//
//  RenameRoomViewController.m
//  TeamPopcorn
//
//  Created by Flatiron School on 4/19/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCRenameRoomViewController.h"
#import "TPCMainViewController.h"


@implementation TPCRenameRoomViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.name.text = self.nameStr;
}

- (IBAction)nameDidEndEditing:(UITextField *)sender {
    
    UINavigationController *nav = (UINavigationController *)self.presentingViewController;
    TPCMainViewController *parentVC = nav.childViewControllers.lastObject;
    parentVC.currentRoom.name = sender.text;
    UILabel *titleLable = parentVC.navigationItem.titleView.subviews.firstObject;
    titleLable.text = sender.text;
}

@end
