//
//  TPCChair.h
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCFurniture.h"
#import "TPCConstants.h"

typedef NS_ENUM(NSInteger, TPCChairStyle) {
    basicChair,
    campingChair,
    lazyboyChair,
    officeChair,
    rockingChair
};

@interface TPCChair : TPCFurniture

@property   (nonatomic) TPCChairStyle chairStyle;

-(instancetype)init;

-(instancetype)initWithChairstlye: (TPCChairStyle) chairStyle;

+(instancetype)basicChair;

+(instancetype)campingChair;

+(instancetype)lazyboyChair;

+(instancetype)officeChair;

+(instancetype)rockingChair;

@end





