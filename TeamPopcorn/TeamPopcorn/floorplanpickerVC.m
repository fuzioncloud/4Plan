//
//  floorplanpickerVC.m
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 4/4/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "floorplanpickerVC.h"
#import "SMLViewController.h"

@interface floorplanpickerVC ()

@end

@implementation floorplanpickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"2x2"]) {
         SMLViewController *vc= [segue destinationViewController];
        vc.widthField=@"2";
        vc.lengthField=@"2";
        
    }
    if ([[segue identifier] isEqualToString:@"2x4"]) {
        SMLViewController *vc= [segue destinationViewController];
        vc.widthField=@"2";
        vc.lengthField=@"4";
        
    }
    if ([[segue identifier] isEqualToString:@"5x5"]) {
        SMLViewController *vc= [segue destinationViewController];
        vc.widthField=@"5";
        vc.lengthField=@"5";
        
    }
    if ([[segue identifier] isEqualToString:@"5x10"]) {
        SMLViewController *vc= [segue destinationViewController];
        vc.widthField=@"5";
        vc.lengthField=@"10";
        
    }
    if ([[segue identifier] isEqualToString:@"10x10"]) {
        SMLViewController *vc= [segue destinationViewController];
        vc.widthField=@"10";
        vc.lengthField=@"10";
        
    }
}

@end
