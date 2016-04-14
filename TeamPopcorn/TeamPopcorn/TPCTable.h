//
//  TPCTable.h
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPCFurniture.h"
#import "TPCConstants.h"

typedef NS_ENUM(int64_t, TPCTableStyle) {
    basicTable,
    bedsideTable,
    coffeeTable,
    deskTable,
    roundTable
};

NS_ASSUME_NONNULL_BEGIN

@interface TPCTable : TPCFurniture

// Insert code here to declare functionality of your managed object subclass

-(instancetype)init;

-(instancetype)initWithTableStlye: (TPCTableStyle) tableStyle;


+(instancetype)basicTable;

+(instancetype)bedsideTable;

+(instancetype)coffeeTable;

+(instancetype)deskTable;

+(instancetype)roundTable;

@end

NS_ASSUME_NONNULL_END

#import "TPCTable+CoreDataProperties.h"
