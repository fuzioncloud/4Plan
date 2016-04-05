//
//  ViewController.m
//  FurnitureInteraction
//
//  Created by susan lovaglio on 3/29/16.
//  Copyright © 2016 susan lovaglio. All rights reserved.
//

#import "SMLViewController.h"
#import "FPCStateManager.h"
#import "ENWFurniture.h"
#import "DimensionsViewController.h"
#import "FurnitureButton.h"

@interface SMLViewController () <UIPopoverPresentationControllerDelegate, UICollisionBehaviorDelegate>

@property (strong, nonatomic) FPCStateManager *dataStore;
@property (weak, nonatomic) IBOutlet UIView *scene;
@property (strong, nonatomic) FurnitureButton *deleteButton;
@property (strong, nonatomic) ENWFurniture *itemToDelete;
@property (strong, nonatomic) FurnitureButton *furnitureButtonToDelete;

@end

@implementation SMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scene.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scene.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
    [self.scene.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20].active = YES;
    [self.scene.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [self.scene.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    
    for (FurnitureButton *furniture in self.scene.subviews) {
        [self furnitureTouching:furniture];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.dataStore = [FPCStateManager currentState];
    ENWFurniture *newlyAddedPiece = self.dataStore.arrangedFurniture.lastObject;
    
    if (newlyAddedPiece) {
        
        CGFloat centerX = self.scene.center.x;
        CGFloat centerY = self.scene.center.y;
        
        CGRect frame = CGRectMake(centerX, centerY, newlyAddedPiece.width, newlyAddedPiece.length);
        
        FurnitureButton *placedPiece = [[FurnitureButton alloc]initWithFrame:frame];
        
        [placedPiece setBackgroundImage:newlyAddedPiece.image forState:normal];
        placedPiece.imageView.image = newlyAddedPiece.image;
        placedPiece.imageView.contentMode = UIViewContentModeScaleToFill;
        placedPiece.backgroundColor = [UIColor darkGrayColor];
        placedPiece.tintColor = [UIColor blackColor];
        placedPiece.furnitureItem = newlyAddedPiece;
        
        UIPanGestureRecognizer *panGestureRecognizerSofa = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveFurniture:)];
        [placedPiece addGestureRecognizer:panGestureRecognizerSofa];
        
        UIRotationGestureRecognizer *rotationGestureRecognizerSofa = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateFurniture:)];
        [placedPiece addGestureRecognizer:rotationGestureRecognizerSofa];
        
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteFurniture:)];
        longPressGestureRecognizer.minimumPressDuration = .3;
        [placedPiece addGestureRecognizer:longPressGestureRecognizer];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDimensionsPopOver:)];
        [placedPiece addGestureRecognizer: tapGestureRecognizer];
        
        [self.scene addSubview:placedPiece];
        
        placedPiece.translatesAutoresizingMaskIntoConstraints = NO;
        [placedPiece.widthAnchor constraintEqualToConstant:placedPiece.frame.size.width].active = YES;
        [placedPiece.heightAnchor constraintEqualToConstant:placedPiece.frame.size.height].active = YES;
        
        [placedPiece.centerXAnchor constraintEqualToAnchor:self.scene.centerXAnchor].active = YES;
        [placedPiece.centerYAnchor constraintEqualToAnchor:self.scene.centerYAnchor].active = YES;
    }
    
    for (FurnitureButton *furniture in self.scene.subviews) {
        
        [self furnitureTouching:furniture];
    }
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController*)controller {
    return UIModalPresentationNone;
}

-(void)showDimensionsPopOver: (UITapGestureRecognizer*)tapGesture{
    
    DimensionsViewController *dimvc = [self.storyboard instantiateViewControllerWithIdentifier:@"dimensionVC"];
    dimvc.preferredContentSize = CGSizeMake(160, 140);
    
    dimvc.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popov = dimvc.popoverPresentationController;
    popov.delegate = self;
    popov.sourceView = tapGesture.view;
    popov.permittedArrowDirections = UIPopoverArrowDirectionDown;
    
    [self presentViewController:dimvc animated:YES completion:nil];
}

-(void)moveFurniture:(UIPanGestureRecognizer*)panGestureRecognizer{
    
    [self.deleteButton removeFromSuperview];
    
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.scene];
    panGestureRecognizer.view.center = touchLocation;
    [self furnitureTouching:(FurnitureButton*)panGestureRecognizer.view];
    
}

-(void)rotateFurniture:(UIRotationGestureRecognizer*)rotateGestureRecognizer{
    
    if (rotateGestureRecognizer.state != UIGestureRecognizerStateBegan){
        return;
    }
    
    rotateGestureRecognizer.view.transform = CGAffineTransformRotate(rotateGestureRecognizer.view.transform, rotateGestureRecognizer.rotation);
    
    rotateGestureRecognizer.rotation = 0;
    
    [self furnitureTouching:(FurnitureButton*)rotateGestureRecognizer.view];
}

-(void)deleteFurniture:(UILongPressGestureRecognizer*)longPressGestureRecognizer{
    
    if(longPressGestureRecognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    UIImage *image = [UIImage imageNamed:@"delete"];
    FurnitureButton *selectedButton = (FurnitureButton *)longPressGestureRecognizer.view;
    self.furnitureButtonToDelete = selectedButton;
    self.itemToDelete = selectedButton.furnitureItem;
    self.deleteButton = [[FurnitureButton alloc]init];
    [self.deleteButton setImage:image forState:UIControlStateNormal];
    
    [self.scene addSubview:self.deleteButton];
    
    self.deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.deleteButton.widthAnchor constraintEqualToAnchor:longPressGestureRecognizer.view.widthAnchor multiplier:.7].active = YES;
    [self.deleteButton.heightAnchor constraintEqualToAnchor:longPressGestureRecognizer.view.heightAnchor multiplier:.4].active = YES;
    [self.deleteButton.centerYAnchor constraintEqualToAnchor:longPressGestureRecognizer.view.topAnchor].active = YES;
    [self.deleteButton.centerXAnchor constraintEqualToAnchor:longPressGestureRecognizer.view.leadingAnchor].active = YES;
    
    UITapGestureRecognizer *tappedTheX = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedTheXButton:)];
    [self.deleteButton addGestureRecognizer:tappedTheX];
}

-(void)tappedTheXButton:(UITapGestureRecognizer*)theX {
    
    [self.deleteButton removeFromSuperview];
    
    [self.dataStore.arrangedFurniture removeObject:self.itemToDelete];
    
    [self.furnitureButtonToDelete removeFromSuperview];
}

-(void)furnitureTouching:(FurnitureButton*)furniture {
//    NSLog(@"array of pieces:  %@", self.dataStore.arrangedFurniture);
//    NSLog(@"ive been kicked off");
    
    for (FurnitureButton *button in self.scene.subviews) {
//        NSLog(@"inside the loop");
        if ([button isEqual:furniture]) {
//            NSLog(@"continue on: %d", [button isEqual:furniture]);
            continue;
        }
        
        BOOL touching = (CGRectIntersectsRect(furniture.frame, button.frame));
        
        if (touching) {
            button.tintColor = [UIColor redColor];
            furniture.tintColor = [UIColor redColor];
//            NSLog(@"furniture touching");
//            NSLog(@"%@", button.tintColor);
//            NSLog(@"%@", furniture.tintColor);
            
        } else {
//            NSLog(@"inside the else statement");
            BOOL furnitureIsAlreadyTouchingAnotherView = NO;
            
            for (FurnitureButton *buttonAgain in self.scene.subviews) {
                if ([buttonAgain isEqual:furniture]) { continue; }
                
                BOOL touchingAtLeastOneThing = (CGRectIntersectsRect(furniture.frame, buttonAgain.frame));
                
                if (touchingAtLeastOneThing) {
                    furnitureIsAlreadyTouchingAnotherView = YES;
                }
            }
//            NSLog(@"make it black");
            furniture.tintColor = furnitureIsAlreadyTouchingAnotherView ? [UIColor redColor] : [UIColor blackColor];
            button.tintColor = [UIColor blackColor];
        }
    }
}

@end

