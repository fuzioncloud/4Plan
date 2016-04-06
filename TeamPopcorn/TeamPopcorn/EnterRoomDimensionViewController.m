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
#import "FPCStateManager.h"

@interface EnterRoomDimensionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *widthText;
@property (weak, nonatomic) IBOutlet UITextField *lengthText;
@property (weak, nonatomic) IBOutlet UIButton *submit;

@property (strong, nonatomic) FPCStateManager* datastore;
@property (strong,nonatomic) NSString *widthField;
@property (strong, nonatomic) NSString *lengthField;
@property (strong, nonatomic) FPCStateManager *datastore;


@end

@implementation EnterRoomDimensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHue:0.256 saturation:0.35 brightness:1.0 alpha:2.0];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:TRUE];
    
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
<<<<<<< HEAD
    
    self.datastore=[FPCStateManager currentState];
    [self.datastore setRoomOfWidth:self.widthText.text.integerValue height:0 length:self.lengthText.text.integerValue];

=======
    self.datastore=[FPCStateManager currentState];
    [self.datastore setRoomOfWidth:self.lengthText.text.integerValue height:0 length:self.widthText.text.integerValue];
>>>>>>> master
}

- (IBAction)submitButton:(id)sender {
       
   
}

@end
