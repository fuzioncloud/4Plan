//
//  FPCFurnitureDescriber.m
//  TeamPopcorn
//
//  Created by Flatiron School on 3/30/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "FPCCatalogDescriber.h"

@implementation FPCCatalogDescriber

-(instancetype)initWithName:(NSString *)catalogName atIndex:(NSInteger)catalogIndex {
    self = [super init];
    if (self) {
        _catalogName = catalogName;
        _catalogIndex = catalogIndex;
    }
    return self;
}

@end
