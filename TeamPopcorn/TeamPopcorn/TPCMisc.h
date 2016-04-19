//
//  TPCMisc.h
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPCFurniture.h"
#import "TPCConstants.h"

typedef NS_ENUM(int64_t, TPCMiscStyle) {
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

NS_ASSUME_NONNULL_BEGIN

@interface TPCMisc : TPCFurniture

// Insert code here to declare functionality of your managed object subclass

-(instancetype)init;

-(instancetype)initWithMiscStlye:(TPCMiscStyle)miscStyle;

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

NS_ASSUME_NONNULL_END

#import "TPCMisc+CoreDataProperties.h"
