//
//  TPCEntryViewController.m
//  TeamPopcorn
//
//  Created by susan lovaglio on 4/14/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCEntryViewController.h"
#import "TPCStateManager.h"
#import "TPCModels.h"

@interface TPCEntryViewController ()
@property (strong, nonatomic) TPCStateManager *dataStore;
@property (weak, nonatomic) IBOutlet UIButton *roomButton;


@end

@implementation TPCEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataStore = [TPCStateManager currentState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tappedNewRoom:(id)sender {

    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
