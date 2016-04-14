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



@interface TPCDimensionsViewController () <UITextFieldDelegate,TPCMainViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *widthField;
@property (weak, nonatomic) IBOutlet UITextField *lengthField;
@property (weak, nonatomic) IBOutlet UITextField *heightField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (strong,nonatomic) TPCMainViewController *mainvc;



@end

@implementation TPCDimensionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainvc.delegate=self;
    
    
    NSArray *textfields = @[self.widthField, self.lengthField, self.heightField];
    
    for (UITextField *textField in textfields) {
        textField.delegate = self;
        [textField addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    
    

    
    // Do any additional setup after loading the view.
}
- (IBAction)saveButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateFurnitureNotification" object:nil];
    
}

-(void)editingChanged:(UITextField *)textField {
    
    for (TPCFurniture *f in [TPCStateManager currentState].arrangedFurniture) {
        if ([f isEqual:self.furniture]) {
            if ([textField isEqual:self.widthField]) {
                f.width=textField.text.doubleValue;
            }
            if ([textField isEqual:self.lengthField]) {
                f.length=textField.text.doubleValue;
            }
            if ([textField isEqual:self.heightField]) {
                f.height=textField.text.doubleValue;
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
