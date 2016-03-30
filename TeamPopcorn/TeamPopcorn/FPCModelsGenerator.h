//
//  FPCModelsGenerator.h
//  TeamPopcorn
//
//  Created by Flatiron School on 3/30/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FPCModels.h"

@interface FPCModelsGenerator : NSObject

+(NSDictionary<FPCCatalogDescriber *,NSArray<ENWFurniture *> *> *)generateModels;

@end
