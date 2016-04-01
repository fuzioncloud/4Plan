//
//  ENWTable.h
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "ENWFurniture.h"
#import "ENWconstants.h"

typedef NS_ENUM(NSInteger, tableStyle) {
    basicTable,
    bedsideTable,
    coffeeTable,
    deskTable,
    roundTable
};

@interface ENWTable : ENWFurniture

@property(nonatomic) tableStyle tableStyle;

-(instancetype)init;

-(instancetype)initWithTableStlye: (tableStyle) tableStyle;


+(instancetype)basicTable;

+(instancetype)bedsideTable;

+(instancetype)coffeeTable;

+(instancetype)deskTable;

+(instancetype)roundTable;

@end
