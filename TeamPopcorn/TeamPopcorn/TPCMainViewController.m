//
//  ViewController.m
//  FurnitureInteraction
//
//  Created by susan lovaglio on 3/29/16.
//  Copyright © 2016 susan lovaglio. All rights reserved.
//

#import "TPCMainViewController.h"
#import "TPCStateManager.h"
#import "TPCFurniture.h"
#import "TPCDimensionsViewController.h"
#import <Masonry/Masonry.h>

#import "TPCFurnitureButton.h"
#import "TPCEnterRoomDimensionViewController.h"
#import "TPCItemsMenuViewController.h"

#import <Masonry/Masonry.h>

@interface TPCMainViewController () <UIPopoverPresentationControllerDelegate, TPCDimensionViewControllerDelegate, TPCStateManagerDelegate>

@property (strong, nonatomic) TPCStateManager *dataStore;
@property (strong, nonatomic) UIView *roomLayoutView;
@property (strong, nonatomic) UIButton *deleteButton;
@property (strong, nonatomic) TPCFurniture *itemToDelete;
@property (strong, nonatomic) TPCFurnitureButton *furnitureButtonToDelete;
@property (strong, nonatomic) TPCDimensionsViewController *dimensionsvc;


@property (strong, nonatomic) TPCFurnitureButton *tappedFurnitureButton;

@property (strong, nonatomic) UIView *itemsMenuContainerView;
@property (strong, nonatomic) UIView *recognizerLayerView;
@property (strong, nonatomic) NSLayoutConstraint *itemsMenuTrailing;
@property (assign, nonatomic) BOOL isMenuOut;




@end

@implementation TPCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"lskdjflaksdjflkasdj flkadjslfk jasdlkfjad slkfj\n\n\n");
    
    [self constrainForFloorPlan]; // move
    [self barButtonItem]; // move
    
    [self constraintsForItemsMenu];
    [self furnitureTouching];
    self.dimensionsvc.delegate=self;
    self.dataStore.delegate=self;
    
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
    
    [self showDismissMenu];
}

-(void) constrainForFloorPlan {
    
    self.dataStore = [TPCStateManager currentState];
    
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

-(void)constraintsForItemsMenu {
    //    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    //    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.isMenuOut = NO;
    self.recognizerLayerView = [[UIView alloc] init];
    self.recognizerLayerView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.8];
    self.recognizerLayerView.alpha = 0;
    UITapGestureRecognizer *quitTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDismissMenu)];
    [self.recognizerLayerView addGestureRecognizer:quitTap];
    
    self.itemsMenuContainerView = [[UIView alloc] init];
    UINavigationController *menuNavC = [self.storyboard instantiateViewControllerWithIdentifier:@"Items Menu Navigation Controller"];
    
    // Adding to [subviews]
    [self.view addSubview:self.recognizerLayerView];
    [self.view addSubview:self.itemsMenuContainerView];
    
    // Giving constraints
    [self.recognizerLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.itemsMenuContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width).multipliedBy(0.75);
        make.top.and.bottom.equalTo(self.view);
    }];
    CGFloat offset = self.view.frame.size.width * 0.75;
    self.itemsMenuTrailing = [self.itemsMenuContainerView.trailingAnchor
                              constraintEqualToAnchor:self.view.trailingAnchor
                              constant:offset - 8];
    self.itemsMenuTrailing.active = YES;
    
    // Setting the embedded TPCItemsMenuViewController
    [self setEmbeddedViewController:menuNavC];
}

-(void)setEmbeddedViewController:(UIViewController *)controller
{
    if([self.childViewControllers containsObject:controller]) {
        return;
    }
    
    for(UIViewController *vc in self.childViewControllers) {
        [vc willMoveToParentViewController:nil];
        
        if(vc.isViewLoaded) {
            [vc.view removeFromSuperview];
        }
        
        [vc removeFromParentViewController];
    }
    
    if(!controller) {
        return;
    }
    
    [self addChildViewController:controller];
    [self.itemsMenuContainerView addSubview:controller.view];
    [controller.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [controller didMoveToParentViewController:self];
}


-(void)showDismissMenu {
    CGFloat offset, alpha;
    
    if (self.isMenuOut) {
        alpha = 0;
        offset = self.itemsMenuContainerView.frame.size.width - 8;
    }
    else {
        alpha = 0.6;
        offset = 8;
    }
    
    [UIView animateWithDuration:0.8 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.recognizerLayerView.alpha = alpha;
        self.itemsMenuTrailing.constant = offset;
        [self.view layoutIfNeeded];
        self.isMenuOut = !self.isMenuOut;
    } completion:nil];
    
}

-(void)checkIfItemTooBig {
    for (TPCFurnitureButton *button in self.dataStore.arrangedButtons) {
        if ((button.furnitureItem.widthscaled>self.roomLayoutView.bounds.size.width)||(button.furnitureItem.lengthscaled>self.roomLayoutView.bounds.size.height)) {
            [self.dataStore.arrangedButtons removeObject:button];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"You have an item that is too large, all offending items have been deleted" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okay = [UIAlertAction actionWithTitle:@"okay" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                         }];
            [alert addAction:okay];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.deleteButton removeFromSuperview];
    
    [self checkIfItemTooBig];
    
    [self refreshRoomScene];
    
    NSLog(@"here is the furniture array: %@",self.dataStore.arrangedButtons);
    
    //    [self.dataStore checkIfRoomHasChanged:self.dataStore.room];
    //
    //    NSLog(@"room change status:%d",self.dataStore.roomHasChanged);
}

-(void)refreshRoomScene {
    
    [self.deleteButton removeFromSuperview];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
<<<<<<< HEAD
    self.dataStore = [TPCStateManager currentState];
    
    if (!self.dataStore.arrangedButtons) {
        self.dataStore.arrangedButtons = [NSMutableArray new];
    }

    TPCFurniture *newlyAddedPiece = self.dataStore.arrangedFurniture.lastObject;
    NSLog(@"newlyaddedpiece: %@", newlyAddedPiece);
    BOOL inSubView = NO;
    
    for (TPCFurniture *furniture in self.dataStore.arrangedFurniture) {
        NSLog(@"furniture: %@", furniture);
        if (![newlyAddedPiece isEqual: furniture]) {
            inSubView = NO;
            NSLog(@"insubview: %d", inSubView);
        }else{
            inSubView = YES;
            NSLog(@"insubview: %d", inSubView);
        }
    }
    
    NSLog(@"subviews: %@", self.dataStore.arrangedFurniture);
    
    if (!inSubView) {
        
        TPCFurnitureButton *placedPiece = [[TPCFurnitureButton alloc]init];
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

        [self.dataStore.arrangedButtons addObject:placedPiece];
=======
    
    for (TPCFurnitureButton *buttonInDataStore in self.dataStore.arrangedButtons) {
        if (![self.roomLayoutView.subviews containsObject:buttonInDataStore]){
            
            
            CGFloat widthscale = self.roomLayoutView.bounds.size.width/self.dataStore.room.w;
            CGFloat lengthscale =self.roomLayoutView.bounds.size.height/self.dataStore.room.l;
            buttonInDataStore.furnitureItem.widthscaled=buttonInDataStore.furnitureItem.width*widthscale;
            buttonInDataStore.furnitureItem.lengthscaled=buttonInDataStore.furnitureItem.length*lengthscale;
            
            [self.roomLayoutView addSubview:buttonInDataStore];
            
            
            UIPanGestureRecognizer *panGestureRecognizerSofa = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveFurniture:)];
            [buttonInDataStore addGestureRecognizer:panGestureRecognizerSofa];
            
            UIRotationGestureRecognizer *rotationGestureRecognizerSofa = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateFurniture:)];
            [buttonInDataStore addGestureRecognizer:rotationGestureRecognizerSofa];
            
            
            UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteFurniture:)];
            longPressGestureRecognizer.minimumPressDuration = .3;
            [buttonInDataStore addGestureRecognizer:longPressGestureRecognizer];
            
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDimensionsPopOver:)];
            [buttonInDataStore addGestureRecognizer: tapGestureRecognizer];
            
            if (!buttonInDataStore.hasMoved) {
                
                NSLog(@"------- leftConstraint is nil- about to do some stuff.");
                
                [buttonInDataStore mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.centerX.equalTo(self.roomLayoutView.mas_centerX);
                    make.centerY.equalTo(self.roomLayoutView.mas_centerY);
                    make.width.equalTo(@(buttonInDataStore.furnitureItem.widthscaled));
                    make.height.equalTo(@(buttonInDataStore.furnitureItem.lengthscaled));
                    
                }];
            }
            else{
>>>>>>> master
                
                NSLog(@"------- leftConstraint is NOT NIL (BEEN SET ALREADY) - about to do some stuff.");
                NSLog(@"CENTER VALUE AFTER COMING BACK ROM THE VIEW: Cener Value: x: %f -- y: %f", buttonInDataStore.centerValues.x, buttonInDataStore.centerValues.y);
                
                CGFloat xOffset = buttonInDataStore.bounds.size.width / 2;
                CGFloat yOffset = buttonInDataStore.bounds.size.height / 2;
                
                [buttonInDataStore mas_remakeConstraints:^(MASConstraintMaker *make) {
                    

                    make.left.equalTo(@(buttonInDataStore.frame.origin.x));
                    make.top.equalTo(@(buttonInDataStore.frame.origin.y));
                    make.width.equalTo(@(buttonInDataStore.furnitureItem.widthscaled));
                    make.height.equalTo(@(buttonInDataStore.furnitureItem.lengthscaled));
                    

                }];
            }
            
<<<<<<< HEAD
            [placedPiece mas_updateConstraints:^(MASConstraintMaker *make) {
                placedPiece.leftConstraint = make.left.equalTo(self.roomLayoutView.mas_centerX);
                placedPiece.topConstraint = make.top.equalTo(self.roomLayoutView.mas_centerY);
                placedPiece.widthConstraint = make.width.equalTo(@(placedPiece.furnitureItem.width));
                placedPiece.lengthConstraint = make.height.equalTo(@(placedPiece.furnitureItem.height));
            }];
            
        }else{
            [placedPiece mas_remakeConstraints:^(MASConstraintMaker *make) {
                placedPiece.leftConstraint = make.left.equalTo(placedPiece.leftConstraint);
                placedPiece.topConstraint = make.top.equalTo(placedPiece.topConstraint);
                placedPiece.widthConstraint = make.width.equalTo(placedPiece.widthConstraint);
                placedPiece.lengthConstraint = make.height.equalTo(placedPiece.lengthConstraint);
            }];
        }
    }
    
=======
        }
    }
    
    NSLog(@"here is the array of subviews: %@",self.roomLayoutView.subviews);
    
>>>>>>> master
    [self furnitureTouching];
    
    
}

-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    
    [self updateFurnitureSize];
    
    
}

//-(void)newlyAddedPiece:(TPCFurniture*)selectedFurniture {
//
//    self.dataStore = [TPCStateManager currentState];
//    if (!self.dataStore.arrangedButtons) {
//        self.dataStore.arrangedButtons=[NSMutableArray<TPCFurnitureButton *> new];
//    }
//
//
//        TPCFurnitureButton *placedPiece = [[TPCFurnitureButton alloc]init];
//        [placedPiece setBackgroundImage:selectedFurniture.image forState:normal];
//        placedPiece.imageView.image = selectedFurniture.image;
//        placedPiece.imageView.contentMode = UIViewContentModeScaleToFill;
//        placedPiece.backgroundColor = [UIColor darkGrayColor];
//        placedPiece.tintColor = [UIColor blackColor];
//        placedPiece.furnitureItem = selectedFurniture;
//
//
//        CGFloat widthscale = self.roomLayoutView.bounds.size.width/self.dataStore.room.w;
//        CGFloat lengthscale =self.roomLayoutView.bounds.size.height/self.dataStore.room.l;
//        placedPiece.furnitureItem.widthscaled=placedPiece.furnitureItem.width*widthscale;
//        placedPiece.furnitureItem.lengthscaled=placedPiece.furnitureItem.length*lengthscale;
//
//        [self.dataStore.arrangedButtons addObject:placedPiece];
//
//
//}

-(void) updateFurnitureSize {
    
    CGFloat widthscale= self.roomLayoutView.bounds.size.width/self.dataStore.room.w;
    CGFloat lengthscale=self.roomLayoutView.bounds.size.height/self.dataStore.room.l;
    self.tappedFurnitureButton.furnitureItem.widthscaled=self.tappedFurnitureButton.furnitureItem.width*widthscale;
    self.tappedFurnitureButton.furnitureItem.lengthscaled=self.tappedFurnitureButton.furnitureItem.length*lengthscale;
    
    [self.tappedFurnitureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        self.tappedFurnitureButton.widthConstraint = make.width.equalTo(@(self.tappedFurnitureButton.furnitureItem.widthscaled));
        self.tappedFurnitureButton.lengthConstraint = make.height.equalTo(@(self.tappedFurnitureButton.furnitureItem.lengthscaled));
        make.centerX.equalTo(self.roomLayoutView.mas_centerX);
        make.centerY.equalTo(self.roomLayoutView.mas_centerY);
    }];
    
    [self.view layoutIfNeeded];
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController*)controller {
    
    return UIModalPresentationNone;
    
}

-(void)showDimensionsPopOver: (UITapGestureRecognizer*)tapGesture{
    
    [self.deleteButton removeFromSuperview];
    
    TPCFurnitureButton *button = (TPCFurnitureButton *)tapGesture.view;
    self.tappedFurnitureButton = button;
    TPCFurniture *furniture = button.furnitureItem;
    TPCDimensionsViewController *dimvc = [self.storyboard instantiateViewControllerWithIdentifier:@"dimensionVC"];
    dimvc.furniture = furniture;
    dimvc.furnitureButton = button;
    dimvc.preferredContentSize = CGSizeMake(160, 140);
    
    dimvc.modalPresentationStyle = UIModalPresentationPopover;
    dimvc.delegate = self;
    UIPopoverPresentationController *popov = dimvc.popoverPresentationController;
    popov.delegate = self;
    popov.sourceView = tapGesture.view;
    popov.permittedArrowDirections = UIPopoverArrowDirectionDown;
    
    [self presentViewController:dimvc animated:YES completion:nil];
    
    NSLog(@"%@",self.dataStore.arrangedFurniture.lastObject);
    NSLog(@"%@",self.dataStore.arrangedButtons.lastObject);
    NSLog(@"%lu/n/n/n%lu",furniture.width,furniture.length);
    
    
}

-(void)moveFurniture:(UIPanGestureRecognizer*)panGestureRecognizer{
    
    [self.deleteButton removeFromSuperview];
    
    TPCFurnitureButton *selectedFurniture = (TPCFurnitureButton*)panGestureRecognizer.view;
    
    selectedFurniture.hasMoved = YES;
    
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
                make.left.equalTo(@(touchLocation.x- xOffset));
                make.top.equalTo(@(touchLocation.y - yOffset));
                make.size.equalTo([NSValue valueWithCGSize:oldfFrameOfMovingView.size]);
            }];
            
            selectedFurniture.centerValues = CGPointMake(selectedFurniture.center.x, selectedFurniture.center.y);
            
            NSLog(@"Center Value: x: %f -- y: %f", selectedFurniture.centerValues.x, selectedFurniture.centerValues.y);
            
            
            
            
            
            
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
    TPCFurnitureButton *selectedButton = (TPCFurnitureButton *)longPressGestureRecognizer.view;
    
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
    
    [self.dataStore.arrangedButtons removeObject:self.furnitureButtonToDelete];
    [self.furnitureButtonToDelete removeFromSuperview];
}

-(BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    return YES;
}

-(void)furnitureTouching{
    
    for (TPCFurnitureButton *button in self.roomLayoutView.subviews) {
        BOOL shouldBeRed = NO;
        for (TPCFurnitureButton *buttonAgain in self.roomLayoutView.subviews) {
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

