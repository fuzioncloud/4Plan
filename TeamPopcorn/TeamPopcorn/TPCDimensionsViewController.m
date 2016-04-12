//
//  DimensionsViewController.m
//  TeamPopcorn
//
//  Created by susan lovaglio on 3/31/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCDimensionsViewController.h"
#import "TPCMainViewController.h"
#import "TPCStateManager.h"



@interface TPCDimensionsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *widthField;
@property (weak, nonatomic) IBOutlet UITextField *lengthField;
@property (weak, nonatomic) IBOutlet UITextField *heightField;


@end

@implementation TPCDimensionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.widthField.delegate=self;
    self.lengthField.delegate=self;
    self.heightField.delegate=self;
    
    
    
    

    
    // Do any additional setup after loading the view.
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    UITextField *t = (UITextField *) textField;
    
    for (TPCFurnitureButton *fb in [TPCStateManager currentState].arrangedButtons) {
        if ([fb isEqual:self.furnitureButton]) {
            
            if (t == self.widthField) {
                fb.furnitureItem.width=t.text.doubleValue;
            }
            else if (t == self.heightField) {
                fb.furnitureItem.height=t.text.doubleValue;
            }
            else if (t == self.lengthField) {
                fb.furnitureItem.length=t.text.doubleValue;
            }
        }
         NSLog(@"%lu\n\n\n\n\n\n\n\n%lu",fb.furnitureItem.width,fb.furnitureItem.length);
    }
    
  
//    if (self.widthField.text.length>0 && t == self.widthField) {
//        fb.furnitureItem.width=t.text.doubleValue;
//    }
//    else if (self.heightField.text.length>0 && t == self.heightField) {
//        fb.furnitureItem.height=t.text.doubleValue;
//    }
//    else if (self.lengthField.text.length>0 && t == self.lengthField) {
//        fb.furnitureItem.length=t.text.doubleValue;
//    }
//}

}

-(void)viewWillDisappear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


    
   
   
    
    


@end
