//
//  TPCFloorplanPickerViewController.m
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 4/4/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCFloorplanPickerViewController.h"
#import "TPCMainViewController.h"
#import "TPCRoom.h"
#import "TPCStateManager.h"

@interface TPCFloorplanPickerViewController ()

@property (strong, nonatomic) TPCStateManager* datastore;

@end

@implementation TPCFloorplanPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.datastore=[TPCStateManager currentState];
    
    if ([[segue identifier] isEqualToString:@"2x2"]) {
        [self.datastore setRoomOfWidth:2 height:0 length:2];
    }
    
    if ([[segue identifier] isEqualToString:@"2x4"]) {
        [self.datastore setRoomOfWidth:2 height:0 length:4];
        
    }
    if ([[segue identifier] isEqualToString:@"5x5"]) {
       [self.datastore setRoomOfWidth:5 height:0 length:5];
        
    }
    if ([[segue identifier] isEqualToString:@"5x10"]) {
        [self.datastore setRoomOfWidth:5 height:0 length:10];
        
    }
    if ([[segue identifier] isEqualToString:@"10x10"]) {
        [self.datastore setRoomOfWidth:10 height:0 length:10];
        
    }
}

@end
