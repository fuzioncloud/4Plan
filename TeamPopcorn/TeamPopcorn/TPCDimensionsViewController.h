//
//  DimensionsViewController.h
//  TeamPopcorn
//
//  Created by susan lovaglio on 3/31/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPCModels.h"
#import "TPCFurnitureButton.h"

@class TPCDimensionsViewController;

@protocol TPCDimensionViewControllerDelegate

-(void)didUpdateFurnitureSize:(TPCDimensionsViewController*)dimvc;

@end

@interface TPCDimensionsViewController : UIViewController
@property (strong, nonatomic) TPCFurnitureButton* furnitureButton;
@property (strong,nonatomic) TPCFurniture *furniture;
@property (nonatomic) id<TPCDimensionViewControllerDelegate> delegate;

@end
