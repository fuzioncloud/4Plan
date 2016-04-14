//
//  TPCChair.h
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPCFurniture.h"
#import "TPCFurniture.h"
#import "TPCConstants.h"

typedef NS_ENUM(int64_t, TPCChairStyle) {
    basicChair,
    campingChair,
    lazyboyChair,
    officeChair,
    rockingChair
};

NS_ASSUME_NONNULL_BEGIN

@interface TPCChair : TPCFurniture

// Insert code here to declare functionality of your managed object subclass

-(instancetype)init;

-(instancetype)initWithChairstlye: (TPCChairStyle) chairStyle;

+(instancetype)basicChair;

+(instancetype)campingChair;

+(instancetype)lazyboyChair;

+(instancetype)officeChair;

+(instancetype)rockingChair;

@end

NS_ASSUME_NONNULL_END

#import "TPCChair+CoreDataProperties.h"
