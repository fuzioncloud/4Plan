//
//  FurnitureButton.h
//  TeamPopcorn
//
//  Created by susan lovaglio on 4/4/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENWFurniture.h"

@interface FurnitureButton : UIButton

@property(nonatomic, strong) ENWFurniture *furnitureItem;
@property(nonatomic, strong) NSLayoutConstraint *xPosition;
@property(nonatomic, strong) NSLayoutConstraint *yPosition;
@property(nonatomic, strong) NSLayoutConstraint *widthConstraint;
@property(nonatomic, strong) NSLayoutConstraint *lengthConstraint;

@end
