//
//  TPCTable.h
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCFurniture.h"
#import "TPCConstants.h"

typedef NS_ENUM(NSInteger, TPCTableStyle) {
    basicTable,
    bedsideTable,
    coffeeTable,
    deskTable,
    roundTable
};

@interface TPCTable : TPCFurniture

@property(nonatomic) TPCTableStyle tableStyle;

-(instancetype)init;

-(instancetype)initWithTableStlye: (TPCTableStyle) tableStyle;


+(instancetype)basicTable;

+(instancetype)bedsideTable;

+(instancetype)coffeeTable;

+(instancetype)deskTable;

+(instancetype)roundTable;

@end
