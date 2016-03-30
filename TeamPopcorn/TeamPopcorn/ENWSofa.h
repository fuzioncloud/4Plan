//
//  ENWSofa.h
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "ENWFurniture.h"
#import "ENWconstants.h"

typedef NS_ENUM(NSInteger, sofaStyle) {
    basicSofa,
    cornerSofa,
    highSofa,
    loveseatSofa,
    lowSofa
};

@interface ENWSofa : ENWFurniture

@property (nonatomic) NSString* name;
@property   (nonatomic) sofaStyle sofaStyle;

-(instancetype)init;

-(instancetype)initWithSofaStlye: (sofaStyle) sofaStyle;

+(instancetype)basicSofa;

+(instancetype)cornerSofa;

+(instancetype)highSofa;

+(instancetype)loveseatSofa;

+(instancetype)lowSofa;

@end