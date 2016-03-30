//
//  ViewController.m
//  TeamPopcorn
//
//  Created by Flatiron School on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *sofa;
@property (weak, nonatomic) IBOutlet UIImageView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *panGestureRecognizerSofa = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveFurniture:)];
    [self.sofa addGestureRecognizer:panGestureRecognizerSofa];
    
    UIRotationGestureRecognizer *rotationGestureRecognizerSofa = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateFurniture:)];
    [self.sofa addGestureRecognizer:rotationGestureRecognizerSofa];
    
    UIPanGestureRecognizer *panGestureRecognizerTable = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveFurniture:)];
    [self.table addGestureRecognizer:panGestureRecognizerTable];
    
    UIRotationGestureRecognizer *rotationGestureRecognizerTable = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateFurniture:)];
    [self.table addGestureRecognizer:rotationGestureRecognizerTable];
    
}

-(void)moveFurniture:(UIPanGestureRecognizer*)panGestureRecognizer{
    
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.view];
    panGestureRecognizer.view.center = touchLocation;
}

-(void)rotateFurniture:(UIRotationGestureRecognizer*)rotateGestureRecognizer{
    
    rotateGestureRecognizer.view.transform = CGAffineTransformRotate(rotateGestureRecognizer.view.transform, rotateGestureRecognizer.rotation);
}
@end
