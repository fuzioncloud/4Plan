//
//  DimensionsViewController.m
//  TeamPopcorn
//
//  Created by susan lovaglio on 3/31/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "DimensionsViewController.h"
#import "SMLViewController.h"
#import "FPCStateManager.h"



@interface DimensionsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *widthField;
@property (weak, nonatomic) IBOutlet UITextField *lengthField;
@property (weak, nonatomic) IBOutlet UITextField *heightField;


@end

@implementation DimensionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.widthField.delegate=self;
    self.lengthField.delegate=self;
    self.heightField.delegate=self;
    
    
    
    

    
    // Do any additional setup after loading the view.
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    UITextField *t = (UITextField *) textField;
    
    for (FurnitureButton *fb in [FPCStateManager currentState].arrangedButtons) {
        if ([fb isEqual:self.furnitureButton]) {
            
            if (self.widthField.text.length>0 && t == self.widthField) {
                fb.furnitureItem.width=t.text.doubleValue;
            }
            else if (self.heightField.text.length>0 && t == self.heightField) {
                fb.furnitureItem.height=t.text.doubleValue;
            }
            else if (self.lengthField.text.length>0 && t == self.lengthField) {
                fb.furnitureItem.length=t.text.doubleValue;
            }
        }
         NSLog(@"%lu\n\n\n\n\n\n\n\n%lu",fb.furnitureItem.width,fb.furnitureItem.length);
    }
    
  
    
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


    
   
   
    
    


@end
