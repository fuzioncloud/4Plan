//
//  TPCRoom.h
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "TPCRoom.h"

NS_ASSUME_NONNULL_BEGIN

@class TPCFurniture;

@interface TPCRoom : NSManagedObject


@property (strong, nonatomic) NSArray *savedFurniture;
@property (nonatomic) CGFloat scaledWidth, scaledLength, scaleForFurnitureW, scaleForFurnitureL;



+(instancetype)roomOfWidth:(NSUInteger)w
                    height:(NSUInteger)h
                    length:(NSUInteger)l;

@end

NS_ASSUME_NONNULL_END

#import "TPCRoom+CoreDataProperties.h"
