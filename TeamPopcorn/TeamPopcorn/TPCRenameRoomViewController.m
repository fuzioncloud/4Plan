//
//  RenameRoomViewController.m
//  TeamPopcorn
//
//  Created by Flatiron School on 4/19/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCRenameRoomViewController.h"
#import "TPCMainViewController.h"

@interface TPCRenameRoomViewController ()

@property (weak, nonatomic) IBOutlet UITextField *name;

@end


@implementation TPCRenameRoomViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.name.text = self.room.name;
}

- (IBAction)nameDidEndEditing:(UITextField *)sender {
    if(sender.text.length > 0) {
        self.room.name = sender.text;
    }
    
    [self.delegate renameRoomViewControllerDidFinish:self];
}

@end
