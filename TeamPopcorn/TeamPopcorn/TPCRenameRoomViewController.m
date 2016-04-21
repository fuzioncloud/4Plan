//
//  RenameRoomViewController.m
//  TeamPopcorn
//
//  Created by Flatiron School on 4/19/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCRenameRoomViewController.h"
#import "TPCMainViewController.h"

@interface TPCRenameRoomViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *name;

@end


@implementation TPCRenameRoomViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.name.delegate = self;
    self.name.text = self.room.name;
    [self.name becomeFirstResponder];
}

- (IBAction)nameDidEndEditing:(UITextField *)sender {
    if(sender.text.length > 0) {
        self.room.name = sender.text;
    }
    
    [self.delegate renameRoomViewControllerDidFinish:self];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
//    [self nameDidEndEditing:textField];
    [self.popoverPresentationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

@end
