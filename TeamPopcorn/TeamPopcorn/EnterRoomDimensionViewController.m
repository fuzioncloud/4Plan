//
//  EnterRoomDimensionViewController.m
//  TeamPopcorn
//
//  Created by michelle vargas on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "EnterRoomDimensionViewController.h"
#import "roomLayoutViewController.h"
#import "SMLViewController.h"

@interface EnterRoomDimensionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *widthText;
@property (weak, nonatomic) IBOutlet UITextField *lengthText;
@property (weak, nonatomic) IBOutlet UIButton *submit;

@property (strong,nonatomic) NSString *widthField;
@property (strong, nonatomic) NSString *lengthField;



@end

@implementation EnterRoomDimensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHue:0.256 saturation:0.35 brightness:1.0 alpha:2.0];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation


- (IBAction)widthTextField:(id)sender {
    
    
    

  
}


- (IBAction)lengthTextField:(id)sender {
    
    
    
    
}
                       
                       
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
   SMLViewController  *vc = (SMLViewController *)segue.destinationViewController;
    vc.lengthField = self.lengthText.text;
    vc.widthField = self.widthText.text;
}

- (IBAction)submitButton:(id)sender {
       
   
}

@end
