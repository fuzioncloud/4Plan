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
#import <Masonry.h>

#import "FurnitureButton.h"
#import "EnterRoomDimensionViewController.h"
#import "FPCItemsMenuViewController.h"


@interface SMLViewController () <UIPopoverPresentationControllerDelegate, DimensionViewControllerDelegate>

@property (strong, nonatomic) FPCStateManager *dataStore;
@property (strong, nonatomic) UIView *roomLayoutView;
@property (strong, nonatomic) UIButton *deleteButton;
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
    
    self.roomLayoutView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.roomLayoutView.layer.borderWidth = roomLayoutBorder;
    self.roomLayoutView.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.deleteButton removeFromSuperview];
    
    [self refreshRoomScene];
}

-(void)refreshRoomScene{
    
    [self.deleteButton removeFromSuperview];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
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
        
        if (placedPiece.leftConstraint == nil) {
            
            [placedPiece mas_updateConstraints:^(MASConstraintMaker *make) {
                placedPiece.leftConstraint = make.left.equalTo(self.roomLayoutView.mas_centerX);
                placedPiece.topConstraint = make.top.equalTo(self.roomLayoutView.mas_centerY);
                placedPiece.widthConstraint = make.width.equalTo(@(placedPiece.furnitureItem.width));
                placedPiece.heightConstraint = make.height.equalTo(@(placedPiece.furnitureItem.height));
            }];
        }else{
            [placedPiece mas_remakeConstraints:^(MASConstraintMaker *make) {
                placedPiece.leftConstraint = make.left.equalTo(placedPiece.leftConstraint);
                placedPiece.topConstraint = make.top.equalTo(placedPiece.topConstraint);
                placedPiece.widthConstraint = make.width.equalTo(placedPiece.widthConstraint);
                placedPiece.heightConstraint = make.height.equalTo(placedPiece.heightConstraint);
            }];
        }
    }
    [self furnitureTouching];
}

//-(void) updateDisplayedFurniture: (FurnitureButton*)furnitureButton {
//
//    CGFloat centerX = self.roomLayoutView.center.x;
//    CGFloat centerY = self.roomLayoutView.center.y;
//
//    CGRect frame = CGRectMake(centerX, centerY, newlyAddedPiece.widthscale, newlyAddedPiece.lengthscale);
//
//    ENWFurniture *newlyAddedPiece = self.dataStore.arrangedFurniture.lastObject;
//
//
//
//    if (newlyAddedPiece) {
//
//
//
//        CGFloat centerX = self.roomLayoutView.center.x;
//        CGFloat centerY = self.roomLayoutView.center.y;
//
//        CGRect frame = CGRectMake(centerX, centerY, newlyAddedPiece.widthscale, newlyAddedPiece.lengthscale);
//
//        FurnitureButton *placedPiece = [[FurnitureButton alloc]initWithFrame:frame];
//
//        [placedPiece setBackgroundImage:newlyAddedPiece.image forState:normal];
//        placedPiece.imageView.image = newlyAddedPiece.image;
//        placedPiece.imageView.contentMode = UIViewContentModeScaleToFill;
//        placedPiece.backgroundColor = [UIColor darkGrayColor];
//        placedPiece.tintColor = [UIColor blackColor];
//        placedPiece.furnitureItem = newlyAddedPiece;
//        [self.roomLayoutView addSubview:placedPiece];
//
//        placedPiece.translatesAutoresizingMaskIntoConstraints = NO;
//        [placedPiece.widthAnchor constraintEqualToConstant:newlyAddedPiece.width].active = YES;
//        [placedPiece.heightAnchor constraintEqualToConstant:newlyAddedPiece.height].active = YES;
//
//        [placedPiece.centerXAnchor constraintEqualToAnchor:self.roomLayoutView.centerXAnchor].active = YES;
//        [placedPiece.centerYAnchor constraintEqualToAnchor:self.roomLayoutView.centerYAnchor].active = YES;
//
//        UIPanGestureRecognizer *panGestureRecognizerSofa = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveFurniture:)];
//        [placedPiece addGestureRecognizer:panGestureRecognizerSofa];
//
//        UIRotationGestureRecognizer *rotationGestureRecognizerSofa = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateFurniture:)];
//        [placedPiece addGestureRecognizer:rotationGestureRecognizerSofa];
//
//
//        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteFurniture:)];
//        longPressGestureRecognizer.minimumPressDuration = .3;
//        [placedPiece addGestureRecognizer:longPressGestureRecognizer];
//
//        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDimensionsPopOver:)];
//        [placedPiece addGestureRecognizer: tapGestureRecognizer];
//
//    }
//
//
//}

//-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
//    NSLog(@"Dismissing popver");
//    [self updateDisplayedFurniture];
//}

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
    
    FurnitureButton *selectedFurniture = (FurnitureButton*)panGestureRecognizer.view;
    
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.roomLayoutView];
    
    NSInteger buffer = 3;
    
    CGPoint leadingEdgeofFurniture = CGPointMake(touchLocation.x - (selectedFurniture.bounds.size.width/2), 0);
    
    CGPoint trailingEdgeOfFurniture = CGPointMake(touchLocation.x + (selectedFurniture.bounds.size.width/2), 0);
    
    CGPoint topOfFurniture = CGPointMake(0, touchLocation.y - (selectedFurniture.bounds.size.height/2));
    
    CGPoint bottomOfFurniture = CGPointMake(0, touchLocation.y + (selectedFurniture.bounds.size.height/2));
    
    CGPoint topBorder = self.roomLayoutView.bounds.origin;
    
    CGPoint bottomBorder = CGPointMake(self.roomLayoutView.bounds.origin.x + self.roomLayoutView.bounds.size.width, self.roomLayoutView.bounds.origin.y + self.roomLayoutView.bounds.size.height);
    
    BOOL outOfBounds = leadingEdgeofFurniture.x < topBorder.x - buffer || topOfFurniture.y < topBorder.y - buffer || trailingEdgeOfFurniture.x > bottomBorder.x + buffer || bottomOfFurniture.y > bottomBorder.y + buffer;
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        if (outOfBounds) {
            NSLog(@"out of bounds");
            
        }else{
            
            CGRect oldfFrameOfMovingView = selectedFurniture.frame;
            
            CGFloat xOffset = selectedFurniture.bounds.size.width / 2;
            CGFloat yOffset = selectedFurniture.bounds.size.height / 2;
            
            
            [selectedFurniture mas_remakeConstraints:^(MASConstraintMaker *make) {
                selectedFurniture.leftConstraint = make.left.equalTo(@(touchLocation.x- xOffset));
                selectedFurniture.topConstraint = make.top.equalTo(@(touchLocation.y - yOffset));
                make.size.equalTo([NSValue valueWithCGSize:oldfFrameOfMovingView.size]);
            }];
        }
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
    
    if(longPressGestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    self.furnitureButtonToDelete = selectedButton;
    self.itemToDelete = selectedButton.furnitureItem;
    self.deleteButton = [[UIButton alloc]init];
    [self.deleteButton setImage:image forState:UIControlStateNormal];
    [self.roomLayoutView addSubview:self.deleteButton];
    
    CGFloat heightCalculation = selectedButton.furnitureItem.length / 3.0;
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(selectedButton.furnitureItem.width));
        make.height.equalTo(@(heightCalculation));
        make.centerX.equalTo(selectedButton.mas_leading);
        make.centerY.equalTo(selectedButton.mas_top);
    }];
    
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
        BOOL shouldBeRed = NO;
        for (FurnitureButton *buttonAgain in self.roomLayoutView.subviews) {
            if (button == buttonAgain) { continue; }
            BOOL buttonButtonAgainTouching = CGRectIntersectsRect(button.frame, buttonAgain.frame);
            if(buttonButtonAgainTouching){
                shouldBeRed = YES;
                break;
            }
        }
        button.tintColor = shouldBeRed ? [UIColor redColor] : [UIColor blackColor];
    }
}

@end

