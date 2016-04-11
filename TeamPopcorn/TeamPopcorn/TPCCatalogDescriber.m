//
//  TPCCatalogDescriber.m
//  TeamPopcorn
//
//  Created by Flatiron School on 3/30/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCCatalogDescriber.h"

@implementation TPCCatalogDescriber

+(instancetype)withName:(NSString *)catalogName index:(NSInteger)catalogIndex {
    return [[self alloc] initWithName:catalogName atIndex:catalogIndex];
}

+(instancetype)describerForIndex:(NSInteger)catalogIndex {
    switch (catalogIndex) {
        case BedIndex:
            return [[self alloc] initWithName:@"Beds" atIndex:catalogIndex];
        case ChairIndex:
            return [[self alloc] initWithName:@"Chairs" atIndex:catalogIndex];
        case MiscIndex:
            return [[self alloc] initWithName:@"Misc" atIndex:catalogIndex];
        case SofaIndex:
            return [[self alloc] initWithName:@"Sofas" atIndex:catalogIndex];
        case TableIndex:
            return [[self alloc] initWithName:@"Tables" atIndex:catalogIndex];
        default:
            return nil;
    }
}



-(instancetype)initWithName:(NSString *)catalogName atIndex:(NSInteger)catalogIndex {
    self = [super init];
    if (self) {
        _catalogName = catalogName;
        _catalogIndex = catalogIndex;
    }
    return self;
}

-(NSInteger)hash {
    return self.catalogIndex;
}

-(BOOL)isEqual:(id)object {
    if (![object isKindOfClass:self.class]) {
        return NO;
    } else {
        typeof(self) obj = (typeof(self))object;

        return self.catalogIndex == obj.catalogIndex &&
              [self.catalogName isEqualToString:obj.catalogName];
    }
}

// NSCopying protocol

-(id)copyWithZone:(NSZone *)zone {
    return [[self.class alloc]initWithName:self.catalogName atIndex:self.catalogIndex];
}


@end
