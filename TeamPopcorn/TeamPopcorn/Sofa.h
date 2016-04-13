//
//  TPCSofa.h
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCFurniture.h"
#import "TPCConstants.h"

typedef NS_ENUM(NSInteger, TPCSofaStyle) {
    basicSofa,
    cornerSofa,
    highSofa,
    loveseatSofa,
    lowSofa
};

@interface TPCSofa : TPCFurniture

@property   (nonatomic) TPCSofaStyle sofaStyle;

-(instancetype)init;

-(instancetype)initWithSofaStlye: (TPCSofaStyle) sofaStyle;

+(instancetype)basicSofa;

+(instancetype)cornerSofa;

+(instancetype)highSofa;

+(instancetype)loveseatSofa;

+(instancetype)lowSofa;

@end