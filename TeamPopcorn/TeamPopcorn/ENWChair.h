//
//  ENWChair.h
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "ENWFurniture.h"
#import "ENWconstants.h"

typedef NS_ENUM(NSInteger, chairStyle) {
    basicChair,
    campingChair,
    lazyboyChair,
    officeChair,
    rockingChair
};

@interface ENWChair : ENWFurniture

@property (nonatomic) NSString *name;
@property   (nonatomic) chairStyle chairStyle;

-(instancetype)init;

-(instancetype)initWithChairstlye: (chairStyle) chairStyle;

+(instancetype)basicChair;

+(instancetype)campingChair;

+(instancetype)lazyboyChair;

+(instancetype)officeChair;

+(instancetype)rockingChair;

@end





