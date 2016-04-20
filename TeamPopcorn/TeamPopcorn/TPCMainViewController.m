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
#import "TPCModels.h"
#import "TPCFurnitureButton.h"
#import "TPCEnterRoomDimensionViewController.h"
#import "TPCItemsMenuViewController.h"
#import "TPCRenameRoomViewController.h"

#import <Masonry/Masonry.h>

@interface TPCMainViewController () <UIPopoverPresentationControllerDelegate, TPCDimensionViewControllerDelegate, TPCStateManagerDelegate>


@property (strong, nonatomic) UIView *roomLayoutView;
@property (strong, nonatomic) UIButton *deleteButton;
@property (strong, nonatomic) TPCFurniture *itemToDelete;
@property (strong, nonatomic) TPCFurnitureButton *furnitureButtonToDelete;
@property (strong, nonatomic) TPCDimensionsViewController *dimensionsvc;
@property (strong, nonatomic) TPCItemsMenuViewController *itemsvc;


@property (strong, nonatomic) TPCFurnitureButton *tappedFurnitureButton;
@property (strong, nonatomic) UIView *itemsMenuContainerView;
@property (strong, nonatomic) UIView *recognizerLayerView;
@property (strong, nonatomic) NSLayoutConstraint *itemsMenuTrailing;
@property (assign, nonatomic) BOOL isMenuOut;
@property (strong, nonatomic) NSMutableArray *furnitureButtonArray;
@property (strong, nonatomic) NSMutableArray *localFurnitureArray;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;




@end

@implementation TPCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self constrainForFloorPlan]; // move
    [self barButtonItem]; // move
    
    self.furnitureButtonArray = [NSMutableArray new];
    [self constrainForFloorPlan];
    [self barButtonItem]; // move
    [self createSaveButton];
    [self constraintsForItemsMenu];
    [self furnitureTouching];
    [self refreshRoomScene];
    self.dimensionsvc.delegate=self;
    self.dataStore.delegate=self;
    self.dataStore.room = self.currentRoom;
    
    self.currentRoom.scaleForFurnitureL=self.roomLayoutView.bounds.size.height/self.currentRoom.length;
    self.currentRoom.scaleForFurnitureW=self.roomLayoutView.bounds.size.width/self.currentRoom.width;
    
    self.view.backgroundColor = [UIColor colorWithRed:175.0f/255.0f green:215.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
    
}


    
   

-(void) barButtonItem {
    
    UIImage *addSymbol = [UIImage imageNamed:@"addFurnitureButtonSmall"];
    UIBarButtonItem *furnitureBarButton = [[UIBarButtonItem alloc]initWithImage: addSymbol style:UIBarButtonItemStylePlain target:self action:@selector(buttonAction:)];
    self.navigationItem.rightBarButtonItem = furnitureBarButton;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    furnitureBarButton.imageInsets = UIEdgeInsetsMake(1, 1, 1, 1);
    
    // Setting the title view...
    CGRect titleViewFrame = CGRectMake(0, 0, 160, 40);
    UIView *titleView = [[UIView alloc]initWithFrame:titleViewFrame];
    
    CGRect titleLabelFrame = CGRectMake(0, 0, 160, 30);
    UILabel *title = [[UILabel alloc]initWithFrame:titleLabelFrame];
    
    NSString *name = self.currentRoom.name;
    if (name) {
        UIFont *font = [UIFont fontWithName:@"CourierNewPS-ItalicMT" size:24];
        NSDictionary *attr = @{NSFontAttributeName: font};
        NSAttributedString *niceName = [[NSAttributedString alloc]initWithString:name attributes:attr];
        title.attributedText = niceName;
        title.textAlignment = NSTextAlignmentCenter;
    }
    CGRect subTitleLabelFrame = CGRectMake(0, 28, 160, 10);
    UILabel *subTitle = [[UILabel alloc]initWithFrame:subTitleLabelFrame];
    NSDictionary *subAttr = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    NSAttributedString *niceSub = [[NSAttributedString alloc]initWithString:@"tap to rename..." attributes:subAttr];
    subTitle.attributedText = niceSub;
    subTitle.textAlignment = NSTextAlignmentCenter;

    [titleView addSubview:title];
    [titleView addSubview:subTitle];

    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showRenamePopover)];
    [titleView addGestureRecognizer:tapper];
    
    self.navigationItem.titleView = titleView;
    
}

-(void)showRenamePopover {
//    self.navigationItem.titleView.backgroundColor = [UIColor redColor];
    TPCRenameRoomViewController *renameVC = [self.storyboard instantiateViewControllerWithIdentifier:@"renameVC"];
    
    renameVC.nameStr = self.currentRoom.name;
    
    renameVC.modalPresentationStyle = UIModalPresentationPopover;
    renameVC.preferredContentSize = CGSizeMake(260, 40);
    UIPopoverPresentationController *popov = renameVC.popoverPresentationController;
    popov.delegate = self;
    popov.sourceView = self.navigationItem.titleView;
    popov.permittedArrowDirections = UIPopoverArrowDirectionAny;
    
    [self presentViewController:renameVC animated:YES completion:nil];

    
}

-(void) createSaveButton {
    
    UIButton *saveButton = [[UIButton alloc]init];
    
    [saveButton addTarget:self action:@selector(saveButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [saveButton setTitle:@"save" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:saveButton];
    
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.equalTo(self.view.mas_trailingMargin);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(@70);
        make.height.equalTo(@35);
        
    }];
}
- (IBAction)homeButtonTapped:(id)sender {
    
}

-(void) saveButtonPressed{
    
    // temp disabling the save button...
    return;
    
//    if (!self.dataStore.savedRooms) {
//        self.dataStore.savedRooms = [NSArray new];
//    }
//    
//    NSLog(@"save tapped");
//    
//    UIAlertController *saveButtonAlert = [UIAlertController alertControllerWithTitle:@"Save" message:@"Enter name of room" preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *save = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//        
//        self.currentRoom.name = saveButtonAlert.textFields[0].text;
//        
//        NSMutableArray *rooms = [self.dataStore.savedRooms mutableCopy];
//        [rooms addObject:self.currentRoom];
//        self.dataStore.savedRooms = rooms;
//        
//        
//        NSLog(@"furniture in saved room:%@", self.currentRoom.savedFurniture);
//    }];
//    
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
//    
//    [saveButtonAlert addTextFieldWithConfigurationHandler:^(UITextField * textField) {
//        textField.placeholder = NSLocalizedString(@"Enter room name", @"Enter room name");
//    }];
//    
//    [saveButtonAlert addAction:cancel];
//    [saveButtonAlert addAction:save];
//    
//    [self presentViewController:saveButtonAlert animated:YES completion:nil];

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
    
    
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat viewHeight = self.view.bounds.size.height - (navHeight + statusBarHeight);
    
    CGFloat enteredWidth = self.currentRoom.width;
    CGFloat enteredHeight = self.currentRoom.length;
    
    CGFloat widthScaleFactor = (viewWidth-(roomLayoutPadding*2))/enteredWidth;
    CGFloat heightScaleFactor = (viewHeight-(roomLayoutPadding*2))/enteredHeight;
    
    CGFloat scaleFactor;
    
    if (enteredHeight > enteredWidth) {
        scaleFactor = heightScaleFactor;
    } else {
        scaleFactor = widthScaleFactor;
    }
    
    CGFloat floorWidth = enteredWidth * scaleFactor;
    CGFloat floorHeight = enteredHeight * scaleFactor;
    
    self.currentRoom.scaledWidth=floorWidth;
    self.currentRoom.scaledLength=floorHeight;

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
    self.roomLayoutView.layer.backgroundColor = [UIColor colorWithRed:0.98 green:0.95 blue:0.89 alpha:1.0].CGColor;
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

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.deleteButton removeFromSuperview];
    
    [self.view layoutSubviews];
    
    [self refreshRoomScene];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self furnitureTouching];

}

-(void)refreshRoomScene {
    
    [self.deleteButton removeFromSuperview];
    
    self.dataStore = [TPCStateManager currentState];
    
    [self setButton];
    
    [self.view layoutIfNeeded];
    
}

-(void)setButton {
    
    for (TPCFurniture *furniture in self.dataStore.room.savedFurniture) {
        if (!self.localFurnitureArray){
            
            self.localFurnitureArray=[NSMutableArray new];
        }
        if (![self.localFurnitureArray containsObject:furniture]) {
            [self.localFurnitureArray addObject:furniture];
            
            TPCFurnitureButton *furnitureButton = [[TPCFurnitureButton alloc]init];
            
            furnitureButton.furnitureItem = furniture;
            
            [furnitureButton setBackgroundImage:furniture.image forState:normal];
            furnitureButton.imageView.image = furniture.image;
            furnitureButton.imageView.contentMode = UIViewContentModeScaleToFill;
            furnitureButton.backgroundColor = [UIColor darkGrayColor];
            furnitureButton.tintColor = [UIColor blackColor];
            
            furniture.widthscaled=furniture.width*self.currentRoom.scaleForFurnitureW;
            furniture.lengthscaled=furniture.length*self.currentRoom.scaleForFurnitureL;
            
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
                furnitureButton.furnitureItem.angle = 0;
                
            }
            else{
                
                CGRect furnitureRect = CGRectMake(furniture.centerValues.x, furniture.centerValues.y, furniture.widthscaled, furniture.lengthscaled);
                CGRect roomRect = CGRectMake(0, 0, self.dataStore.room.scaledWidth, self.dataStore.room.scaledLength);
                
                if (CGRectContainsRect(roomRect, furnitureRect)) {
                    
                    
                    
                    
                    [furnitureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(@(furniture.centerValues.x));
                        make.top.equalTo(@(furniture.centerValues.y));
                        make.width.equalTo(@(furniture.widthscaled));
                        make.height.equalTo(@(furniture.lengthscaled));

                    }];
                    
                    
                    
                    
                    [furnitureButton layoutIfNeeded];
                    
                    
                    
                    [UIView animateWithDuration:.1 animations:^{
                        
                        [furnitureButton setTransform:CGAffineTransformMakeRotation(furnitureButton.furnitureItem.angle)];
                    }];
                }
                else{
                    
                    [furnitureButton mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.centerX.equalTo(self.roomLayoutView.mas_centerX);
                        make.centerY.equalTo(self.roomLayoutView.mas_centerY);
                        make.width.equalTo(@(furniture.widthScale));
                        make.height.equalTo(@(furniture.lengthScale));
                    }];
                    
                    [furnitureButton layoutIfNeeded];

                }
            }

            furnitureButton.backgroundColor = [UIColor darkGrayColor];

        }
        
    }
    
    
    [self.view layoutIfNeeded];
    [self.roomLayoutView layoutIfNeeded];
    
    [self furnitureTouching];
    

}
-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    
    
}

-(void) didUpdateFurnitureSize:(TPCDimensionsViewController *)dimvc {
    
    self.tappedFurnitureButton.furnitureItem.widthScale=self.tappedFurnitureButton.furnitureItem.width*self.dataStore.room.scaleForFurnitureW;
    self.tappedFurnitureButton.furnitureItem.lengthScale=self.tappedFurnitureButton.furnitureItem.length*self.dataStore.room.scaleForFurnitureL;
    
    if (( self.tappedFurnitureButton.furnitureItem.widthScale>self.dataStore.room.scaledWidth)||( self.tappedFurnitureButton.furnitureItem.lengthScale>self.dataStore.room.scaledLength)) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"Your changes have made the item too large for the room. Reverted to previous size." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*okay = [UIAlertAction actionWithTitle:@"okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:okay];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    else {
        
        self.tappedFurnitureButton.furnitureItem.widthscaled=self.tappedFurnitureButton.furnitureItem.width*self.currentRoom.scaleForFurnitureW;
        self.tappedFurnitureButton.furnitureItem.lengthscaled=self.tappedFurnitureButton.furnitureItem.length*self.currentRoom.scaleForFurnitureL;
        
        [self.tappedFurnitureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.roomLayoutView.mas_centerX);
            make.centerY.equalTo(self.roomLayoutView.mas_centerY);
            make.width.equalTo(@(self.tappedFurnitureButton.furnitureItem.widthscaled));
            make.height.equalTo(@(self.tappedFurnitureButton.furnitureItem.lengthscaled));
        }];
        
        [self.roomLayoutView layoutIfNeeded];
    }
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
        
        if (!outOfBounds) {
            
            CGFloat xOffset = selectedFurniture.bounds.size.width / 2;
            CGFloat yOffset = selectedFurniture.bounds.size.height / 2;
            
            
            [selectedFurniture mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(touchLocation.x- xOffset));
                make.top.equalTo(@(touchLocation.y - yOffset));
                make.size.equalTo([NSValue valueWithCGSize:selectedFurniture.bounds.size]);
            }];
            
            [selectedFurniture layoutIfNeeded];
            
        
            
            selectedFurniture.furnitureItem.centerValues=CGPointMake((touchLocation.x-xOffset), (touchLocation.y-yOffset));
        }
    }
    
    [self furnitureTouching];
}

-(void)rotateFurniture:(UIRotationGestureRecognizer*)rotateGestureRecognizer{
    
    [self.deleteButton removeFromSuperview];
    
    rotateGestureRecognizer.view.transform = CGAffineTransformRotate(rotateGestureRecognizer.view.transform, rotateGestureRecognizer.rotation);
    
    TPCFurnitureButton *selectedFurnitureButton = (TPCFurnitureButton *)rotateGestureRecognizer.view;
    TPCFurniture *selectedFurniture = selectedFurnitureButton.furnitureItem;
    
    if (rotateGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        selectedFurniture.angle = atan2(rotateGestureRecognizer.view.transform.b, rotateGestureRecognizer.view.transform.a);
    }
    
    rotateGestureRecognizer.rotation = 0;
    
    [self furnitureTouching];
}

-(void)deleteFurniture:(UILongPressGestureRecognizer*)longPressGestureRecognizer{
    
    [self.deleteButton removeFromSuperview];
    
    UIImage *image = [UIImage imageNamed:@"delete"];
    TPCFurnitureButton *selectedButton = (TPCFurnitureButton *)longPressGestureRecognizer.view;
    
    if(longPressGestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    self.furnitureButtonToDelete = selectedButton;
    self.itemToDelete = selectedButton.furnitureItem;
    self.deleteButton = [[UIButton alloc]init];
    [self.deleteButton setImage:image forState:UIControlStateNormal];
    
    if ([self.furnitureButtonToDelete.tintColor isEqual:[UIColor blackColor]]) {
        self.deleteButton.tintColor = [UIColor redColor];
    }else if ([self.furnitureButtonToDelete.tintColor isEqual:[UIColor redColor]]){
        self.deleteButton.tintColor = [UIColor blackColor];
    }
    [self.view bringSubviewToFront:self.deleteButton];
    [self.furnitureButtonToDelete addSubview:self.deleteButton];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(75));
        make.height.equalTo(@(75));
        make.centerX.equalTo(selectedButton.mas_centerX);
        make.centerY.equalTo(selectedButton.mas_centerY);
    }];
    
    UITapGestureRecognizer *tappedTheX = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedTheXButton:)];
    [self.deleteButton addGestureRecognizer:tappedTheX];
}

-(void)tappedTheXButton:(UITapGestureRecognizer*)theX {
    
    [self.deleteButton removeFromSuperview];
    
    NSMutableArray *mutableArray = [self.dataStore.room.savedFurniture mutableCopy];
    [mutableArray removeObject:self.itemToDelete];
    
    self.dataStore.room.savedFurniture = mutableArray;
    
    [self.furnitureButtonToDelete removeFromSuperview];
    
    [self furnitureTouching];
}

-(BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    return YES;
}

-(void)furnitureTouching{
    
    for (TPCFurnitureButton *button in self.roomLayoutView.subviews) {
        
        
        BOOL shouldBeRed = NO;
        
        for (TPCFurnitureButton *buttonAgain in self.roomLayoutView.subviews) {
            
            if (button == buttonAgain) { NSLog(@"about to call continue, button is the same."); continue; }
            
            BOOL buttonButtonAgainTouching = [self view:button intersectsWith:buttonAgain];
            
            if(buttonButtonAgainTouching){
                
                shouldBeRed = YES;
                
                break;
            }
        }
        button.tintColor = shouldBeRed ? [UIColor redColor] : [UIColor blackColor];
    }
}

// magic separating axis theorem from outside source
- (void)projectionOfPolygon:(CGPoint *)poly count:(int)count onto:(CGPoint)perp min:(CGFloat *)minp max:(CGFloat *)maxp
{
    CGFloat minproj = MAXFLOAT;
    CGFloat maxproj = -MAXFLOAT;
    for (int j = 0; j < count; j++) {
        CGFloat proj = poly[j].x * perp.x + poly[j].y * perp.y;
        if (proj > maxproj)
            maxproj = proj;
        if (proj < minproj)
            minproj = proj;
    }
    *minp = minproj;
    *maxp = maxproj;
}

-(BOOL)convexPolygon:(CGPoint *)poly1 count:(int)count1 intersectsWith:(CGPoint *)poly2 count:(int)count2
{

    for (int i = 0; i < count1; i++) {
        // Perpendicular vector for one edge of poly1:
        CGPoint p1 = poly1[i];
        CGPoint p2 = poly1[(i+1) % count1];
        CGPoint perp = CGPointMake(- (p2.y - p1.y), p2.x - p1.x);
        
        // Projection intervals of poly1, poly2 onto perpendicular vector:
        CGFloat minp1, maxp1, minp2, maxp2;
        [self projectionOfPolygon:poly1 count:count1 onto:perp min:&minp1 max:&maxp1];
        [self projectionOfPolygon:poly2 count:count1 onto:perp min:&minp2 max:&maxp2];
        
        
        
        
        // If projections do not overlap then we have a "separating axis"
        // which means that the polygons do not intersect:
        if (maxp1 < minp2 || maxp2 < minp1)
            return NO;
    }
    
    // And now the other way around with edges from poly2:
    for (int i = 0; i < count2; i++) {
        CGPoint p1 = poly2[i];
        CGPoint p2 = poly2[(i+1) % count2];
        CGPoint perp = CGPointMake(- (p2.y - p1.y), p2.x - p1.x);
        
        CGFloat minp1, maxp1, minp2, maxp2;
        [self projectionOfPolygon:poly1 count:count1 onto:perp min:&minp1 max:&maxp1];
        [self projectionOfPolygon:poly2 count:count1 onto:perp min:&minp2 max:&maxp2];
        
        if (maxp1 < minp2 || maxp2 < minp1)
            return NO;
    }
    
    // No separating axis found, then the polygons must intersect:
    return YES;
}

- (BOOL)view:(UIView *)view1 intersectsWith:(UIView *)view2
{
     CGPoint poly1[4];
    CGRect bounds1 = view1.bounds;
    
    
    
    poly1[0] = [view1 convertPoint:bounds1.origin toView:self.roomLayoutView];
    poly1[1] = [view1 convertPoint:CGPointMake(bounds1.origin.x + bounds1.size.width, bounds1.origin.y) toView:self.roomLayoutView];
    poly1[2] = [view1 convertPoint:CGPointMake(bounds1.origin.x + bounds1.size.width, bounds1.origin.y + bounds1.size.height) toView:self.roomLayoutView];
    poly1[3] = [view1 convertPoint:CGPointMake(bounds1.origin.x, bounds1.origin.y + bounds1.size.height) toView:self.roomLayoutView];
    
    CGPoint poly2[4];
    CGRect bounds2 = view2.bounds;
    poly2[0] = [view2 convertPoint:bounds2.origin toView:self.roomLayoutView];
    poly2[1] = [view2 convertPoint:CGPointMake(bounds2.origin.x + bounds2.size.width, bounds2.origin.y) toView:self.roomLayoutView];
    poly2[2] = [view2 convertPoint:CGPointMake(bounds2.origin.x + bounds2.size.width, bounds2.origin.y + bounds2.size.height) toView:self.roomLayoutView];
    poly2[3] = [view2 convertPoint:CGPointMake(bounds2.origin.x, bounds2.origin.y + bounds2.size.height) toView:self.roomLayoutView];
    
    return [self convexPolygon:poly1 count:4 intersectsWith:poly2 count:4];
}

@end
