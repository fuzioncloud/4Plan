//
//  TPCBed.h
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPCConstants.h"
#import "TPCFurniture.h"

typedef NS_ENUM(int64_t, TPCBedSize) {
    Twin=0,
    Full=1,
    Queen=2,
    King=3,
    CaliforniaKing=4,
    Futon=5,
    Crib=6
};

NS_ASSUME_NONNULL_BEGIN

@interface TPCBed : TPCFurniture

// Insert code here to declare functionality of your managed object subclass

-(instancetype)init;

-(instancetype)initWithBedSize:(TPCBedSize)bedSize;

+(instancetype)twinBed;

+(instancetype)fullBed;

+(instancetype)queenBed;

+(instancetype)kingBed;

+(instancetype)californiaKingBed;

+(instancetype)cribBed;

+(instancetype)futonBed;


@end

NS_ASSUME_NONNULL_END

#import "TPCBed+CoreDataProperties.h"
