//
//  TPCMisc.h
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCFurniture.h"
#import "TPCConstants.h"

typedef NS_ENUM(NSInteger, TPCMiscStyle) {
    basicMisc,
    bicycleMisc,
    boxMisc,
    randomMisc,
    wardrobeMisc,
    doorMisc,
    visibleDoorMisc,
    skateboardMisc,
    smallboxMisc,
    binderMisc,
    cameraMisc
};

@interface TPCMisc : TPCFurniture

@property   (nonatomic) TPCMiscStyle miscStyle;

-(instancetype)init;

-(instancetype)initWithMiscStlye: (TPCMiscStyle) miscStyle;

+(instancetype)basicMisc;

+(instancetype)bicycleMisc;

+(instancetype)boxMisc;

+(instancetype)randomMisc;

+(instancetype)wardrobeMisc;

+(instancetype)doorMisc;

+(instancetype)visibleDoorMisc;

+(instancetype)skateboardMisc;

+(instancetype)smallboxMisc;

+(instancetype)binderMisc;

+(instancetype)cameraMisc;

@end
