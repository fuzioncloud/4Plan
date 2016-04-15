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
@property (strong, nonatomic) TPCMainViewController *mainvc;

@end

@implementation TPCDimensionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.widthField.delegate=self;
    self.lengthField.delegate=self;
    self.heightField.delegate=self;
    self.mainvc.delegate=self;
    
    NSArray *textfields = @[self.widthField, self.lengthField, self.heightField];
    for (UITextField *textfield in textfields) {
        textfield.delegate=self;
        [textfield addTarget:self action:@selector(editingChanged) forControlEvents:UIControlEventEditingChanged];
    }
    
    
    
    

    
    // Do any additional setup after loading the view.
}
- (IBAction)saveButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate didUpdateFurnitureSize:self];
}

- (void)editingChanged:(UITextField *)textField {
    
    
    for (TPCFurniture *f in [TPCStateManager currentState].arrangedFurniture) {
        if ([f isEqual:self.furniture]) {
            
            if (textField == self.widthField) {
                f.width=textField.text.doubleValue;
            }
            else if (textField == self.heightField) {
                f.height=textField.text.doubleValue;
            }
            else if (textField == self.lengthField) {
                f.length=textField.text.doubleValue;
            }
        }
        
    }
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


    
   
   
    
    


@end
