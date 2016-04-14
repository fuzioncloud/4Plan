//
//  TPCFurniture.h
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>


@class TPCFurnitureButton;

NS_ASSUME_NONNULL_BEGIN

@interface TPCFurniture : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@property (nonatomic) CGPoint centerValues;

//@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIImage *image;

//@property (nullable, nonatomic, retain) TPCFurnitureButton *placedFurniture;

-(instancetype)init;

-(instancetype)initWithWidth:(NSUInteger)width
                      length:(NSUInteger)length
                      height:(NSUInteger)height
                       image:(UIImage*)image
                      weight:(NSUInteger)weight;

@end

NS_ASSUME_NONNULL_END

#import "TPCFurniture+CoreDataProperties.h"
