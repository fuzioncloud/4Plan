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
#import "FurnitureButton.h"

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
    
    for (ENWFurniture *furniture in [FPCStateManager currentState].arrangedFurniture) {
        if ([furniture isEqual:self.furniture]) {
            
            if (t == _widthField) {
                furniture.width=t.text.doubleValue;
            }
            else if (t == _heightField) {
                furniture.height=t.text.doubleValue;
            }
            else if (t == _lengthField) {
                furniture.length=t.text.doubleValue;
            }
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


    
   
   
    
    


@end
