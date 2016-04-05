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
#import "EnterRoomDimensionViewController.h"
#import "FPCItemsMenuViewController.h"
@interface SMLViewController () <UIPopoverPresentationControllerDelegate>


@property (weak, nonatomic)  UIImageView *sofa;
@property (weak, nonatomic)  UIImageView *table;
@property (strong, nonatomic) NSArray *usersFurniture;
@property (strong, nonatomic) FPCStateManager *dataStore;
@property (weak, nonatomic) IBOutlet UIView *roomLayoutView;

@end

@implementation SMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.roomLayoutView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLog(@"width entered %@", self.widthField);
    NSLog(@"length entered %@", self.lengthField);
    
    
    CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat viewHeight = self.view.bounds.size.height;
    
    CGFloat enteredWidth = [self.widthField floatValue];
    CGFloat enteredHeight = [self.lengthField floatValue];
    
    CGFloat floorWidth;
    CGFloat floorHeight;
    
    if (enteredWidth >= enteredHeight) {
        // use view width
        
        floorHeight = (viewWidth * enteredHeight) / enteredWidth;
        floorWidth = viewWidth;
        
    } else {
        // use view height
        floorWidth = (viewHeight * enteredWidth) / enteredHeight;
        floorHeight = viewHeight;
    }
    
    
    float percentage = .50;
    int xPosition = _roomLayoutView.superview.frame.size.width * ((1 - percentage) / 8);
    int yPosition = _roomLayoutView.superview.frame.size.height * ((1 - percentage) / 3.0);
    NSInteger width = self.widthField.integerValue*20;
    NSInteger height = self.lengthField.integerValue*20;
   

    NSInteger widthPositionAndPadding = (width + xPosition + 20);
    NSInteger heightPositionAndPadding = (height + yPosition + 20);
    
    BOOL overflowsHorizontally = widthPositionAndPadding > self.view.bounds.size.width;
    BOOL overflowsVertically = heightPositionAndPadding > self.view.bounds.size.height;
    
    if (overflowsHorizontally || overflowsVertically) {
        CGFloat horizontalDifference = widthPositionAndPadding - self.view.bounds.size.width;
        CGFloat verticalDifference = heightPositionAndPadding - self.view.bounds.size.height;
        width -= horizontalDifference;
        height -= verticalDifference;
    }
    
    
    self.roomLayoutView.frame = CGRectMake(xPosition, yPosition, width, height);
    
 
    [self.roomLayoutView sizeToFit];
    
    [self constrainForFloorPlan];
    

//    self.roomLayoutView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.roomLayoutView.topAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:10].active = YES;
//    [self.roomLayoutView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20].active = YES;
//    [self.roomLayoutView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
//    [self.roomLayoutView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;

    
    
    for (UIButton *pieceOfFurniture in self.roomLayoutView.subviews) {
        [self furnitureTouching:pieceOfFurniture];
            }
    

    UIImage *addSymbol = [UIImage imageNamed:@"addFurnitureButtonSmall"];
    UIBarButtonItem *furnitureBarButton = [[UIBarButtonItem alloc]initWithImage: addSymbol style:UIBarButtonItemStylePlain target:self action:@selector(buttonAction:)];
    self.navigationItem.rightBarButtonItem = furnitureBarButton;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
        furnitureBarButton.imageInsets = UIEdgeInsetsMake(1, 1, 1, 1);
    [self.navigationItem setRightBarButtonItem:furnitureBarButton];
}



-(void) constrainForFloorPlan {
    
    
    [self.view removeConstraints:self.view.constraints];
    [self.roomLayoutView removeConstraints:self.view.constraints];
    self.roomLayoutView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.roomLayoutView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:80].active= YES;
    [self.roomLayoutView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.5].active = YES;
    [self.roomLayoutView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor  constant:10].active = YES;
    [self.roomLayoutView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-10].active = YES;
    [self.roomLayoutView.bottomAnchor constraintGreaterThanOrEqualToAnchor:self.view.bottomAnchor constant:-10].active = YES;
    
    
    
    
    
}

-(void) buttonAction: (id) sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FPCItemsMenuViewController *newVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"FPCItemsMenuViewController"];
    [self presentViewController:newVC animated:YES completion:nil];
    
    
}



-(void) resizeToFitSubviews: (UIView *) view {
    
    float w = 0.0,h = 0.0;
    for (UIView *view in view.subviews) {
        float fw = view.frame.origin.x + view.frame.size.width;
        float fh = view.frame.origin.y + view.frame.size.height;
        w = MAX(fw, w);
        h = MAX(fh, h);
        
    }
    
    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y , w , h)];
    
}



-(void)viewWillAppear:(BOOL)animated{
    
    self.view.backgroundColor = [UIColor colorWithHue:0.256 saturation:0.35 brightness:1.0 alpha:1];
    
    self.roomLayoutView.layer.borderColor = [UIColor blackColor].CGColor;
    self.roomLayoutView.layer.borderWidth = 1.0;
    
    self.roomLayoutView.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    

    
    
    self.dataStore = [FPCStateManager currentState];
    ENWFurniture *newlyAddedPiece = self.dataStore.arrangedFurniture.lastObject;
    
    if (newlyAddedPiece) {
    
        CGFloat centerX = self.roomLayoutView.center.x;
        CGFloat centerY = self.roomLayoutView.center.y;
        
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
        [self.roomLayoutView addSubview:placedPiece];
        
        placedPiece.translatesAutoresizingMaskIntoConstraints = NO;
        [placedPiece.widthAnchor constraintEqualToConstant:placedPiece.frame.size.width].active = YES;
        [placedPiece.heightAnchor constraintEqualToConstant:placedPiece.frame.size.height].active = YES;
        
        [placedPiece.centerXAnchor constraintEqualToAnchor:self.roomLayoutView.centerXAnchor].active = YES;
        [placedPiece.centerYAnchor constraintEqualToAnchor:self.roomLayoutView.centerYAnchor].active = YES;
//
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
    
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.roomLayoutView];
    panGestureRecognizer.view.center = touchLocation;
    [self furnitureTouching:(UIButton*)panGestureRecognizer.view];
}

-(void)rotateFurniture:(UIRotationGestureRecognizer*)rotateGestureRecognizer{
    
    rotateGestureRecognizer.view.transform = CGAffineTransformRotate(rotateGestureRecognizer.view.transform, rotateGestureRecognizer.rotation);
    
    rotateGestureRecognizer.rotation = 0;
    
    [self furnitureTouching:(UIButton*)rotateGestureRecognizer.view];
    
}

-(void)furnitureTouching:(UIButton*)furniture{
    
    for (UIView *view in self.roomLayoutView.subviews) {
        
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

