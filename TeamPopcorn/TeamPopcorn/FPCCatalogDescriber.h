//
//  FPCCatalogDescriber.h
//  TeamPopcorn
//
//  Created by Flatiron School on 3/30/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger) {
    BedIndex = 0,
    ChairIndex = 1,
    MiscIndex = 2,
    SofaIndex = 3,
    TableIndex = 4
}CatalogIndex;

@interface FPCCatalogDescriber : NSObject <NSCopying>

@property (strong, nonatomic) NSString *catalogName;
@property (assign, nonatomic) NSInteger catalogIndex;
@property (assign, nonatomic, readonly) NSInteger hash;

+(instancetype)withName:(NSString *)catalogName index:(NSInteger)catalogIndex;

+(instancetype)describerForIndex:(NSInteger)catalogIndex;

-(BOOL)isEqual:(id)object;


// NSCopying protocol
-(id)copyWithZone:(NSZone *)zone;

@end
