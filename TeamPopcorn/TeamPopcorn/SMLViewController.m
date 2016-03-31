//
//  ViewController.m
//  FurnitureInteraction
//
//  Created by susan lovaglio on 3/29/16.
//  Copyright © 2016 susan lovaglio. All rights reserved.
//

#import "SMLViewController.h"

@interface SMLViewController ()

@property (weak, nonatomic)  UIImageView *sofa;
@property (weak, nonatomic)  UIImageView *table;
@property (strong, nonatomic) NSArray *usersFurniture;

@end

@implementation SMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.usersFurniture = @[self.sofa, self.table];
    
//    NSLog(@"I've passed back this piece: %@", self.selectedPiece);

    
    UIPanGestureRecognizer *panGestureRecognizerSofa = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveFurniture:)];
    [self.sofa addGestureRecognizer:panGestureRecognizerSofa];
    
    UIRotationGestureRecognizer *rotationGestureRecognizerSofa = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateFurniture:)];
    [self.sofa addGestureRecognizer:rotationGestureRecognizerSofa];
    
    UIPanGestureRecognizer *panGestureRecognizerTable = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveFurniture:)];
    [self.table addGestureRecognizer:panGestureRecognizerTable];
    
    UIRotationGestureRecognizer *rotationGestureRecognizerTable = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateFurniture:)];
    [self.table addGestureRecognizer:rotationGestureRecognizerTable];
    
    for (UIImageView *pieceOfFurniture in self.usersFurniture) {
        [self furnitureTouching:pieceOfFurniture];
    }
}

-(void)moveFurniture:(UIPanGestureRecognizer*)panGestureRecognizer{
    
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.view];
    panGestureRecognizer.view.center = touchLocation;
    [self furnitureTouching:(UIImageView*)panGestureRecognizer.view];
}

-(void)rotateFurniture:(UIRotationGestureRecognizer*)rotateGestureRecognizer{
    
    rotateGestureRecognizer.view.transform = CGAffineTransformRotate(rotateGestureRecognizer.view.transform, rotateGestureRecognizer.rotation);
    
    rotateGestureRecognizer.rotation = 0;
    
    [self furnitureTouching:(UIImageView*)rotateGestureRecognizer.view];
}

-(void)furnitureTouching:(UIImageView*)furniture{
    
    for (UIImageView *pieceOfFurniture in self.usersFurniture) {
        
        BOOL touching = CGRectIntersectsRect(furniture.frame, pieceOfFurniture.frame);
        BOOL notCurrentFurniture = ![furniture isEqual:pieceOfFurniture];
        
        if (touching && notCurrentFurniture){
            NSLog(@"it's touching something!");
            pieceOfFurniture.tintColor = [UIColor redColor];
            furniture.tintColor = [UIColor redColor];
            
        }else if(!touching && notCurrentFurniture){
            NSLog(@"not touchinganything!");
            pieceOfFurniture.tintColor = [UIColor blackColor];
            furniture.tintColor = [UIColor blackColor];
        }
    }
}

@end

