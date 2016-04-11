//
//  FurnitureButton.h
//  TeamPopcorn
//
//  Created by susan lovaglio on 4/4/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENWFurniture.h"
#import <Masonry/Masonry.h>

@interface FurnitureButton : UIButton

@property(nonatomic, strong) ENWFurniture *furnitureItem;
@property (strong, nonatomic) MASConstraint *leftConstraint;
@property (strong, nonatomic) MASConstraint *topConstraint;
@property (strong, nonatomic) MASConstraint *widthConstraint;
@property (strong, nonatomic) MASConstraint *heightConstraint;
@property (strong, nonatomic) MASConstraint *lengthConstraint;
@end
