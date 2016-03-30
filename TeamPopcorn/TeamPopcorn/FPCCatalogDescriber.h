//
//  FPCFurnitureDescriber.h
//  TeamPopcorn
//
//  Created by Flatiron School on 3/30/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPCCatalogDescriber : NSObject

@property (strong, nonatomic) NSString *catalogName;
@property (assign, nonatomic) NSInteger catalogIndex;

-(instancetype)initWithName:(NSString *)catalogName atIndex:(NSInteger)catalogIndex;

@end
