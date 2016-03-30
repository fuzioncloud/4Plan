//
//  ENWBed.h
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "ENWFurniture.h"
#import "ENWconstants.h"

typedef NS_ENUM(NSInteger, BedSize) {
    Twin=0,
    Full=1,
    Queen=2,
    King=3,
    CaliforniaKing=4,
    Futon=5,
    Crib=6
};


@interface ENWBed : ENWFurniture


@property (nonatomic) BedSize bedSize;

-(instancetype)init;

-(instancetype)initWithBedSize: (BedSize) bedSize;

+(instancetype)twinBed;

+(instancetype)fullBed;

+(instancetype)queenBed;

+(instancetype)kingBed;

+(instancetype)californiaKingBed;

+(instancetype)cribBed;

+(instancetype)futonBed;

@end
