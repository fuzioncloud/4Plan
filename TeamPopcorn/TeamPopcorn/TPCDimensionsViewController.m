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
@property (strong, nonatomic) TPCStateManager *dataStore;

@end

@implementation TPCDimensionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataStore = [TPCStateManager currentState];
    
    
    
    NSArray *textfields = @[self.widthField, self.lengthField, self.heightField];
    for (UITextField *textfield in textfields) {
        textfield.delegate=self;
        [textfield addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    
    
    
    

    
    // Do any additional setup after loading the view.
}
- (IBAction)saveButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate didUpdateFurnitureSize:self];
}

- (void)editingChanged:(UITextField *)textField {
    
//    NSArray * arrangedFurniture = [TPCStateManager currentState].room.savedFurniture;
    
//<<<<<<< HEAD
//    for (TPCFurniture *f in arrangedFurniture) {
//=======
    for (TPCFurniture *f in self.dataStore.room.savedFurniture) {
//>>>>>>> master
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
         NSLog(@"%lld\n\n\n\n\n\n\n\n%lld",f.width,f.length);
    }
    
}

//-(void)viewWillDisappear:(BOOL)animated {
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


    
   
   
    
    


@end
