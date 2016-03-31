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
@interface SMLViewController () <UIPopoverPresentationControllerDelegate>


@property (weak, nonatomic)  UIImageView *sofa;
@property (weak, nonatomic)  UIImageView *table;
@property (strong, nonatomic) NSArray *usersFurniture;
@property (strong, nonatomic) FPCStateManager *dataStore;
@property (weak, nonatomic) IBOutlet UIView *scene;

@end

@implementation SMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scene.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scene.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
    [self.scene.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20].active = YES;
    [self.scene.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [self.scene.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    
    
    
    
//    self.usersFurniture = @[self.sofa, self.table];
    
//    NSLog(@"I've passed back this piece: %@", self.selectedPiece);
    for (UIButton *pieceOfFurniture in self.scene.subviews) {
        [self furnitureTouching:pieceOfFurniture];
            }
    

}

-(void)viewWillAppear:(BOOL)animated{
    self.dataStore = [FPCStateManager currentState];
    ENWFurniture *newlyAddedPiece = self.dataStore.arrangedFurniture.lastObject;
    
    if (newlyAddedPiece) {
    
        CGFloat centerX = self.scene.center.x;
        CGFloat centerY = self.scene.center.y;
        
        CGRect frame = CGRectMake(centerX, centerY, newlyAddedPiece.width, newlyAddedPiece.length);
        UIButton *placedPiece = [[UIButton alloc]initWithFrame:frame];

        
        [placedPiece setBackgroundImage:newlyAddedPiece.image forState:normal];
        placedPiece.imageView.image = newlyAddedPiece.image;
        placedPiece.imageView.contentMode = UIViewContentModeScaleToFill;
        placedPiece.backgroundColor = [UIColor darkGrayColor];
        placedPiece.tintColor = [UIColor blackColor];
        
        
        UIPanGestureRecognizer *panGestureRecognizerSofa = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveFurniture:)];
        [placedPiece addGestureRecognizer:panGestureRecognizerSofa];
        
        UIRotationGestureRecognizer *rotationGestureRecognizerSofa = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateFurniture:)];
        [placedPiece addGestureRecognizer:rotationGestureRecognizerSofa];
        [self.scene addSubview:placedPiece];
        
        placedPiece.translatesAutoresizingMaskIntoConstraints = NO;
        [placedPiece.widthAnchor constraintEqualToConstant:placedPiece.frame.size.width].active = YES;
        [placedPiece.heightAnchor constraintEqualToConstant:placedPiece.frame.size.height].active = YES;
        
        [placedPiece.centerXAnchor constraintEqualToAnchor:self.scene.centerXAnchor].active = YES;
        [placedPiece.centerYAnchor constraintEqualToAnchor:self.scene.centerYAnchor].active = YES;
        
        DimensionsViewController *dimvc = [self.storyboard instantiateViewControllerWithIdentifier:@"dimensionVC"];
        dimvc.preferredContentSize = CGSizeMake(160, 140);

        dimvc.modalPresentationStyle = UIModalPresentationPopover;
        
        UIPopoverPresentationController *popov = dimvc.popoverPresentationController;
        popov.delegate = self;
        popov.sourceView = placedPiece;
        popov.permittedArrowDirections = UIPopoverArrowDirectionDown;
        
        [self presentViewController:dimvc animated:YES completion:nil];
    }
}





-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController*)controller {
    return UIModalPresentationNone;
}




-(void)moveFurniture:(UIPanGestureRecognizer*)panGestureRecognizer{
    
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.scene];
    panGestureRecognizer.view.center = touchLocation;
    [self furnitureTouching:(UIButton*)panGestureRecognizer.view];
}

-(void)rotateFurniture:(UIRotationGestureRecognizer*)rotateGestureRecognizer{
    
    rotateGestureRecognizer.view.transform = CGAffineTransformRotate(rotateGestureRecognizer.view.transform, rotateGestureRecognizer.rotation);
    
    rotateGestureRecognizer.rotation = 0;
    
    [self furnitureTouching:(UIButton*)rotateGestureRecognizer.view];
}

-(void)furnitureTouching:(UIButton*)furniture{
    
    for (UIView *view in self.scene.subviews) {
        
        UIButton *pieceOfFurniture = (UIButton*)view;
        
        if(pieceOfFurniture && ![furniture isEqual:pieceOfFurniture])
        {
            BOOL touching = CGRectIntersectsRect(furniture.frame, pieceOfFurniture.frame);
    //        BOOL notCurrentFurniture = ![furniture isEqual:pieceOfFurniture];
            
    //            if(self.dataStore.arrangedFurniture.count - 1 == 0){
    //                notCurrentFurniture = NO;
    //            }
                
            if (touching){
                NSLog(@"it's touching something!");
                pieceOfFurniture.tintColor = [UIColor redColor];
                furniture.tintColor = [UIColor redColor];
            }
            else {
                NSLog(@"not touchinganything!");
                pieceOfFurniture.tintColor = [UIColor blackColor];
                furniture.tintColor = [UIColor blackColor];
            }
        }
    }
}

@end

