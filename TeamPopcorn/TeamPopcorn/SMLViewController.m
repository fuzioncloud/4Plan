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
#import "EnterRoomDimensionViewController.h"
#import "FPCItemsMenuViewController.h"


@interface SMLViewController () <UIPopoverPresentationControllerDelegate, DimensionViewControllerDelegate>

@property (strong, nonatomic) FPCStateManager *dataStore;
@property (strong, nonatomic) UIView *roomLayoutView;

@property (strong, nonatomic) FurnitureButton *deleteButton;
@property (strong, nonatomic) ENWFurniture *itemToDelete;
@property (strong, nonatomic) FurnitureButton *furnitureButtonToDelete;

@end

@implementation SMLViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self constrainForFloorPlan]; //MV
    [self barButtonItem]; //MV

    [self furnitureTouching];
    
}

-(void) barButtonItem {
    
    UIImage *addSymbol = [UIImage imageNamed:@"addFurnitureButtonSmall"];
    UIBarButtonItem *furnitureBarButton = [[UIBarButtonItem alloc]initWithImage: addSymbol style:UIBarButtonItemStylePlain target:self action:@selector(buttonAction:)];
    self.navigationItem.rightBarButtonItem = furnitureBarButton;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    furnitureBarButton.imageInsets = UIEdgeInsetsMake(1, 1, 1, 1);
    [self.navigationItem setRightBarButtonItem:furnitureBarButton];
    
}

-(void) buttonAction: (id) sender {
 
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FPCItemsMenuViewController *newVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"FPCItemsMenuViewController"];
    [self presentViewController:newVC animated:YES completion:nil];    
}

-(void) constrainForFloorPlan {

    self.dataStore = [FPCStateManager currentState];

    CGFloat roomLayoutBorder = 1.0;
    CGFloat roomLayoutPadding = 20.0;
    

    self.roomLayoutView = [[UIView alloc] init];
    [self.view addSubview:self.roomLayoutView];
    
    NSLog(@"width entered %lu", self.dataStore.room.w);
    NSLog(@"length entered %lu", self.dataStore.room.l);
    
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat viewHeight = self.view.bounds.size.height - (navHeight + statusBarHeight);
    
    CGFloat enteredWidth = self.dataStore.room.w;
    CGFloat enteredHeight = self.dataStore.room.l;
    
    CGFloat widthFactor = viewWidth / enteredWidth;
    CGFloat heightFactor = viewHeight / enteredHeight;
    
    CGFloat scaleFactor;
    
    if (widthFactor < heightFactor) {
        scaleFactor = widthFactor;
    } else {
        scaleFactor = heightFactor;
    }
    
    CGFloat floorWidth = enteredWidth * scaleFactor;
    CGFloat floorHeight = enteredHeight * scaleFactor;
    
    floorWidth = floorWidth - roomLayoutBorder - (roomLayoutPadding * 2);
    floorHeight = floorHeight - roomLayoutBorder - (roomLayoutPadding * 2);

    self.roomLayoutView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat topAnchorConstant = navHeight + statusBarHeight + roomLayoutPadding;
    [self.roomLayoutView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.roomLayoutView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active =YES;
    [self.roomLayoutView.topAnchor constraintGreaterThanOrEqualToAnchor:self.view.topAnchor constant:topAnchorConstant].active = YES;
    [self.roomLayoutView.widthAnchor constraintEqualToConstant:floorWidth].active = YES;
    [self.roomLayoutView.heightAnchor constraintEqualToConstant:floorHeight].active = YES;

    
    [self.roomLayoutView layoutIfNeeded];
    
    self.roomLayoutView.layer.borderColor = [UIColor blackColor].CGColor;
    self.roomLayoutView.layer.borderWidth = roomLayoutBorder;
    self.roomLayoutView.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    

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
    [super viewWillAppear:animated];
    
    [self.deleteButton removeFromSuperview];
    
    self.view.backgroundColor = [UIColor colorWithHue:0.256 saturation:0.35 brightness:1.0 alpha:1];
    
    self.dataStore = [FPCStateManager currentState];
    ENWFurniture *newlyAddedPiece = self.dataStore.arrangedFurniture.lastObject;
    
    if (newlyAddedPiece) {
        
        
        
        FurnitureButton *placedPiece = [[FurnitureButton alloc]init];
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
        
        
        [self.roomLayoutView addSubview:placedPiece];
        
        
                placedPiece.translatesAutoresizingMaskIntoConstraints = NO;
        [placedPiece.centerXAnchor constraintEqualToAnchor:self.roomLayoutView.centerXAnchor].active=YES;
        [placedPiece.centerYAnchor constraintEqualToAnchor:self.roomLayoutView.centerYAnchor].active=YES;
        [placedPiece.widthAnchor constraintEqualToConstant:placedPiece.furnitureItem.width].active=YES;
        [placedPiece.heightAnchor constraintEqualToConstant:placedPiece.furnitureItem.length].active=YES;
        
        
    }
    
    
    [self furnitureTouching];
}

-(void) updateDisplayedFurniture {
    ENWFurniture *newlyAddedPiece = self.dataStore.arrangedFurniture.lastObject;
    
    
    
    if (newlyAddedPiece) {
        
        
        CGFloat centerX = self.roomLayoutView.center.x;
        CGFloat centerY = self.roomLayoutView.center.y;
        
        CGRect frame = CGRectMake(centerX, centerY, newlyAddedPiece.widthscale, newlyAddedPiece.lengthscale);
        
        FurnitureButton *placedPiece = [[FurnitureButton alloc]initWithFrame:frame];
        
        [placedPiece setBackgroundImage:newlyAddedPiece.image forState:normal];
        placedPiece.imageView.image = newlyAddedPiece.image;
        placedPiece.imageView.contentMode = UIViewContentModeScaleToFill;
        placedPiece.backgroundColor = [UIColor darkGrayColor];
        placedPiece.tintColor = [UIColor blackColor];
        placedPiece.furnitureItem = newlyAddedPiece;
        [self.roomLayoutView addSubview:placedPiece];
        
        placedPiece.translatesAutoresizingMaskIntoConstraints = NO;
        [placedPiece.widthAnchor constraintEqualToConstant:newlyAddedPiece.width].active = YES;
        [placedPiece.heightAnchor constraintEqualToConstant:newlyAddedPiece.height].active = YES;
        
        [placedPiece.centerXAnchor constraintEqualToAnchor:self.roomLayoutView.centerXAnchor].active = YES;
        [placedPiece.centerYAnchor constraintEqualToAnchor:self.roomLayoutView.centerYAnchor].active = YES;
    }

    
}

-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    NSLog(@"Dismissing popver");
    [self updateDisplayedFurniture];
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController*)controller {
    
    return UIModalPresentationNone;
    
}

-(void)showDimensionsPopOver: (UITapGestureRecognizer*)tapGesture{

    [self.deleteButton removeFromSuperview];
    
    FurnitureButton *button = (FurnitureButton *)tapGesture.view;
    ENWFurniture *furniture = button.furnitureItem;
    DimensionsViewController *dimvc = [self.storyboard instantiateViewControllerWithIdentifier:@"dimensionVC"];
    dimvc.furniture = furniture;
    dimvc.preferredContentSize = CGSizeMake(160, 140);
    
    dimvc.modalPresentationStyle = UIModalPresentationPopover;
    dimvc.delegate = self;
    UIPopoverPresentationController *popov = dimvc.popoverPresentationController;
    popov.delegate = self;
    popov.sourceView = tapGesture.view;
    popov.permittedArrowDirections = UIPopoverArrowDirectionDown;
    
    
    [self presentViewController:dimvc animated:YES completion:nil];
    
}

-(void)moveFurniture:(UIPanGestureRecognizer*)panGestureRecognizer{
    
    [self.deleteButton removeFromSuperview];
    //location of the touch translated into
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.roomLayoutView];

    CGPoint leadingEdgeofFurniture = CGPointMake(touchLocation.x - (panGestureRecognizer.view.bounds.size.width/2), 0);
    
    CGPoint trailingEdgeOfFurniture = CGPointMake(touchLocation.x + (panGestureRecognizer.view.bounds.size.width/2), 0);
    
    CGPoint topOfFurniture = CGPointMake(0, touchLocation.y - (panGestureRecognizer.view.bounds.size.height/2));

    CGPoint bottomOfFurniture = CGPointMake(0, touchLocation.y + (panGestureRecognizer.view.bounds.size.height/2));

    CGPoint topBorder = self.roomLayoutView.bounds.origin;
    
    CGPoint bottomBorder = CGPointMake(self.roomLayoutView.bounds.origin.x + self.roomLayoutView.bounds.size.width, self.roomLayoutView.bounds.origin.y + self.roomLayoutView.bounds.size.height);
    
    BOOL outOfBounds = leadingEdgeofFurniture.x < topBorder.x || topOfFurniture.y < topBorder.y || trailingEdgeOfFurniture.x > bottomBorder.x || bottomOfFurniture.y > bottomBorder.y;
    
    if (outOfBounds) {
        
    }else{

        panGestureRecognizer.view.center = touchLocation;
    }

    [self furnitureTouching];
}

-(void)rotateFurniture:(UIRotationGestureRecognizer*)rotateGestureRecognizer{
    
    [self.deleteButton removeFromSuperview];
    
    if (rotateGestureRecognizer.state != UIGestureRecognizerStateBegan){
        return;
    }
    
    rotateGestureRecognizer.view.transform = CGAffineTransformRotate(rotateGestureRecognizer.view.transform, rotateGestureRecognizer.rotation);
    
    rotateGestureRecognizer.rotation = 0;
    
    [self furnitureTouching];
}

-(void)deleteFurniture:(UILongPressGestureRecognizer*)longPressGestureRecognizer{
    
    UIImage *image = [UIImage imageNamed:@"delete"];
    FurnitureButton *selectedButton = (FurnitureButton *)longPressGestureRecognizer.view;
    CGPoint touchLocation = [longPressGestureRecognizer locationInView:self.roomLayoutView];
    
    if(longPressGestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    self.furnitureButtonToDelete = selectedButton;
    self.itemToDelete = selectedButton.furnitureItem;
    self.deleteButton = [[FurnitureButton alloc]init];
    [self.deleteButton setImage:image forState:UIControlStateNormal];
    [self.roomLayoutView addSubview:self.deleteButton];
    
    self.deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.deleteButton.widthAnchor constraintEqualToAnchor:longPressGestureRecognizer.view.widthAnchor multiplier:.7].active = YES;
    [self.deleteButton.heightAnchor constraintEqualToAnchor:longPressGestureRecognizer.view.heightAnchor multiplier:.4].active = YES;
    
    [self.deleteButton.centerYAnchor constraintEqualToAnchor:longPressGestureRecognizer.view.topAnchor].active = YES;
    [self.deleteButton.centerXAnchor constraintEqualToAnchor:longPressGestureRecognizer.view.leadingAnchor].active = YES;
    
    longPressGestureRecognizer.view.center = touchLocation;
    self.deleteButton.center = longPressGestureRecognizer.view.center;
    UITapGestureRecognizer *tappedTheX = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedTheXButton:)];
    [self.deleteButton addGestureRecognizer:tappedTheX];
    
}

-(void)tappedTheXButton:(UITapGestureRecognizer*)theX {
    
    [self.deleteButton removeFromSuperview];
    
    [self.dataStore.arrangedFurniture removeObject:self.itemToDelete];
    
    [self.furnitureButtonToDelete removeFromSuperview];
}

-(void)furnitureTouching{
    
    for (FurnitureButton *button in self.roomLayoutView.subviews) {
        
        NSMutableArray *buttonsThatAreTouchingButton = [NSMutableArray new];
        
        for (FurnitureButton *buttonAgain in self.roomLayoutView.subviews) {
            
            if (button == buttonAgain) { continue; }
            
            BOOL buttonButtonAgainTouching = CGRectIntersectsRect(button.frame, buttonAgain.frame);

            if(buttonButtonAgainTouching){
               
                [buttonsThatAreTouchingButton addObject:buttonAgain];
            }
            
            else if (!buttonButtonAgainTouching){
            }
        }
        
        if (buttonsThatAreTouchingButton.count > 0) {
            
            button.tintColor = [UIColor redColor];
            
        } else {
            
            button.tintColor = [UIColor blackColor];
        }
    }
}

@end

