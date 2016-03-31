//
//  ENWMisc.h
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "ENWFurniture.h"
#import "ENWconstants.h"

typedef NS_ENUM(NSInteger, miscStyle) {
    basicMisc,
    bicycleMisc,
    boxMisc,
    randomMisc,
    wardrobeMisc,
    doorMisc,
    visibleDoorMisc
};

@interface ENWMisc : ENWFurniture

@property   (nonatomic) miscStyle miscStyle;

-(instancetype)init;

-(instancetype)initWithMiscStlye: (miscStyle) miscStyle;

+(instancetype)basicMisc;

+(instancetype)bicycleMisc;

+(instancetype)boxMisc;

+(instancetype)randomMisc;

+(instancetype)wardrobeMisc;

@end
