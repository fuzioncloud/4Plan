//
//  DimensionsViewController.h
//  TeamPopcorn
//
//  Created by susan lovaglio on 3/31/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPCModels.h"
#import "FurnitureButton.h"

@protocol DimensionViewControllerDelegate

-(void)dimensionVCDidUpdateDimensions:(FurnitureButton*)placedpiece;

@end

@interface DimensionsViewController : UIViewController

@property (strong,nonatomic) ENWFurniture *furniture;
@property (nonatomic) id<DimensionViewControllerDelegate> delegate;

@end
