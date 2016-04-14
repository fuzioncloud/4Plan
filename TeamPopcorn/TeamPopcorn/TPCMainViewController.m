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
@property (strong, nonatomic) UIButton *deleteButton;
@property (strong, nonatomic) TPCFurniture *itemToDelete;
@property (strong, nonatomic) TPCFurnitureButton *furnitureButtonToDelete;
@property (strong, nonatomic) TPCDimensionsViewController *dimensionsvc;


@property (strong, nonatomic) TPCFurnitureButton *tappedFurnitureButton;

@property (strong, nonatomic) UIView *itemsMenuContainerView;
@property (strong, nonatomic) UIView *recognizerLayerView;
@property (strong, nonatomic) NSLayoutConstraint *itemsMenuTrailing;
@property (assign, nonatomic) BOOL isMenuOut;
@property (strong, nonatomic) NSMutableArray *localFurnitureArray;





@end

@implementation TPCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self constrainForFloorPlan]; // move
    [self barButtonItem]; // move
    
    [self constraintsForItemsMenu];
    [self furnitureTouching];
    self.dimensionsvc.delegate=self;
    self.dataStore.delegate=self;
    
    self.dataStore.room.scaleForFurnitureL=self.roomLayoutView.bounds.size.height/self.dataStore.room.length;
    self.dataStore.room.scaleForFurnitureW=self.roomLayoutView.bounds.size.width/self.dataStore.room.width;
    
    
}

-(void) barButtonItem {
    
//    UIButton *blah = [UIButton buttonWithType:UIButtonTypeSystem];
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
    
    //GOOD
    self.dataStore = [TPCStateManager currentState];
    
    CGFloat roomLayoutBorder = 1.0;
    CGFloat roomLayoutPadding = 20.0;
    
    
    self.roomLayoutView = [[UIView alloc] init];
    [self.view addSubview:self.roomLayoutView];
    
    NSLog(@"width entered %lld", self.dataStore.room.width);
    NSLog(@"length entered %lld", self.dataStore.room.length);
    
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat viewHeight = self.view.bounds.size.height - (navHeight + statusBarHeight);
    
    CGFloat enteredWidth = self.dataStore.room.width;
    CGFloat enteredHeight = self.dataStore.room.length;
    
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
    self.dataStore.room.scaledWidth=floorWidth;
    self.dataStore.room.scaledLength=floorHeight;
    
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

-(void)checkIfItemsTooBig {

    for (TPCFurniture *furniture in self.dataStore.room.savedFurniture) {
        furniture.widthScale=furniture.width*self.dataStore.room.scaleForFurnitureW;
        furniture.lengthScale=furniture.length*self.dataStore.room.scaleForFurnitureL;
        if ((furniture.widthScale>self.dataStore.room.scaledWidth)||(furniture.lengthScale>self.dataStore.room.scaledLength)) {
            NSLog(@"%flalalala%f", furniture.widthScale, furniture.lengthScale);
            
            NSMutableArray *mutableArray = [self.dataStore.room.savedFurniture mutableCopy];
            [mutableArray removeObject:furniture];
            self.dataStore.room.savedFurniture = mutableArray;
            
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
    [self.view layoutSubviews];
    [self refreshRoomScene];
    

}

-(void)refreshRoomScene {
    
    [self checkIfItemsTooBig];
    
    [self.deleteButton removeFromSuperview];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    [self setButton];
    
    [self furnitureTouching];
    
    
    
}


-(void)setButton {
    
    for (TPCFurniture *furniture in self.dataStore.room.savedFurniture) {
        NSLog(@"Data store furniture: %@", self.dataStore.room.savedFurniture);
        NSLog(@"Local furniture: %@", self.localFurnitureArray);
        if (!self.localFurnitureArray){
            self.localFurnitureArray=[NSMutableArray new];
        }
        if (![self.localFurnitureArray containsObject:furniture]){
            [self.localFurnitureArray addObject:furniture];
        
            TPCFurnitureButton *furnitureButton = [[TPCFurnitureButton alloc]init];
            
            furnitureButton.furnitureItem = furniture;
            
            
            
            [furnitureButton setBackgroundImage:furniture.image forState:normal];
            furnitureButton.imageView.image = furniture.image;
            furnitureButton.imageView.contentMode = UIViewContentModeScaleToFill;
            furnitureButton.backgroundColor = [UIColor darkGrayColor];
            furnitureButton.tintColor = [UIColor blackColor];
            
            
            furniture.widthScale=furniture.width*self.dataStore.room.scaleForFurnitureW;
            furniture.lengthScale=furniture.length*self.dataStore.room.scaleForFurnitureL;
            
            
            [self.roomLayoutView addSubview:furnitureButton];
            
            
            UIPanGestureRecognizer *panGestureRecognizerSofa = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveFurniture:)];
            [furnitureButton addGestureRecognizer:panGestureRecognizerSofa];
            
            UIRotationGestureRecognizer *rotationGestureRecognizerSofa = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateFurniture:)];
            [furnitureButton addGestureRecognizer:rotationGestureRecognizerSofa];
            
            
            UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteFurniture:)];
            longPressGestureRecognizer.minimumPressDuration = .3;
            [furnitureButton addGestureRecognizer:longPressGestureRecognizer];
            
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDimensionsPopOver:)];
            [furnitureButton addGestureRecognizer: tapGestureRecognizer];
            
            if (!furniture.hasMoved) {
                
                
                [furnitureButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.centerX.equalTo(self.roomLayoutView.mas_centerX);
                    make.centerY.equalTo(self.roomLayoutView.mas_centerY);
                    make.width.equalTo(@(furniture.widthScale));
                    make.height.equalTo(@(furniture.lengthScale));
                    
                }];
            }
            else{
                
                
                [furnitureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    
                    make.left.equalTo(@(furniture.centerValues.x));
                    make.top.equalTo(@(furniture.centerValues.y));
                    make.width.equalTo(@(furniture.widthScale));
                    make.height.equalTo(@(furniture.lengthScale));
                    
                    if (![self isInBounds:furnitureButton]) {
                        make.centerX.equalTo(self.roomLayoutView.mas_centerX);
                        make.centerY.equalTo(self.roomLayoutView.mas_centerY);
                        make.width.equalTo(@(furniture.widthScale));
                        make.height.equalTo(@(furniture.lengthScale));
                    }
                    
                }];
            }
            
            
        }
    }
    
    [self furnitureTouching];
    

    
}

-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    
    [self updateFurnitureSize];
    
    
}


-(void) updateFurnitureSize {
    
    self.tappedFurnitureButton.furnitureItem.widthScale=self.tappedFurnitureButton.furnitureItem.width*self.dataStore.room.scaleForFurnitureW;
    self.tappedFurnitureButton.furnitureItem.lengthScale=self.tappedFurnitureButton.furnitureItem.length*self.dataStore.room.scaleForFurnitureL;
    
    
    
    if (( self.tappedFurnitureButton.furnitureItem.widthScale>self.dataStore.room.scaledWidth)||( self.tappedFurnitureButton.furnitureItem.lengthScale>self.dataStore.room.scaledLength)) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"Your changes have made the item too large for the room. Reverted to previous size." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okay = [UIAlertAction actionWithTitle:@"okay" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         
                                                     }];
        [alert addAction:okay];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    else {
        [self.tappedFurnitureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            self.tappedFurnitureButton.widthConstraint = make.width.equalTo(@(self.tappedFurnitureButton.furnitureItem.widthScale));
            self.tappedFurnitureButton.lengthConstraint = make.height.equalTo(@(self.tappedFurnitureButton.furnitureItem.lengthScale));
            make.centerX.equalTo(self.roomLayoutView.mas_centerX);
            make.centerY.equalTo(self.roomLayoutView.mas_centerY);
        }];
        
        [self.view layoutIfNeeded];
    }
    
}

-(BOOL)isInBounds:(TPCFurnitureButton*)furnitureButton {
    return CGRectContainsRect(self.roomLayoutView.bounds, furnitureButton.frame);
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
    
}

-(void)moveFurniture:(UIPanGestureRecognizer*)panGestureRecognizer{
    
    [self.deleteButton removeFromSuperview];
    
    TPCFurnitureButton *selectedFurniture = (TPCFurnitureButton*)panGestureRecognizer.view;
    
    selectedFurniture.furnitureItem.hasMoved = YES;
    
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
            
            
            selectedFurniture.furnitureItem.centerValues=CGPointMake((touchLocation.x-xOffset), (touchLocation.y-yOffset));
            
            
            
            
            
            
            
    
            
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
    
    NSMutableArray *mutableArray = [self.dataStore.room.savedFurniture mutableCopy];
    [mutableArray removeObject:self.itemToDelete];
    self.dataStore.room.savedFurniture = mutableArray;
    

    [self.dataStore.arrangedButtons removeObject:self.furnitureButtonToDelete];
    [self.furnitureButtonToDelete removeFromSuperview];
    [self.localFurnitureArray removeObject:self.furnitureButtonToDelete.furnitureItem];
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

