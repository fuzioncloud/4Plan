//
//  StateManager.h
//  TeamPopcorn
//
//  Created by Flatiron School on 3/31/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FPCModelsGenerator.h"

@interface FPCStateManager : NSObject

@property (strong, nonatomic) FPCRoom *room;
@property (strong, nonatomic) NSMutableArray<ENWFurniture *> *arrangedFurniture;

+(instancetype)currentState;

@end
