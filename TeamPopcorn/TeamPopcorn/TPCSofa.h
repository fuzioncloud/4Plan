//
//  TPCSofa.h
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPCFurniture.h"
#import "TPCConstants.h"

typedef NS_ENUM(int64_t, TPCSofaStyle) {
    basicSofa,
    cornerSofa,
    highSofa,
    loveseatSofa,
    lowSofa
};

NS_ASSUME_NONNULL_BEGIN

@interface TPCSofa : TPCFurniture

// Insert code here to declare functionality of your managed object subclass

-(instancetype)init;

-(instancetype)initWithSofaStlye: (TPCSofaStyle) sofaStyle;

+(instancetype)basicSofa;

+(instancetype)cornerSofa;

+(instancetype)highSofa;

+(instancetype)loveseatSofa;

+(instancetype)lowSofa;

@end

NS_ASSUME_NONNULL_END

#import "TPCSofa+CoreDataProperties.h"
