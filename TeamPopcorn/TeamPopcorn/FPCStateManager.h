//
//  StateManager.h
//  TeamPopcorn
//
//  Created by Flatiron School on 3/31/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FPCModelsGenerator.h"
#import "FurnitureButton.h"

@interface FPCStateManager : NSObject

@property (strong, nonatomic, readonly) FPCRoom *room;
@property (strong, nonatomic, readonly) NSMutableArray<ENWFurniture *> *arrangedFurniture;
@property (strong, nonatomic, readwrite) NSMutableArray<FurnitureButton *>*arrangedButtons;

+(instancetype)currentState;

-(void)setRoomOfWidth:(NSUInteger)w
               height:(NSUInteger)h
               length:(NSUInteger)l;

-(void)placeFuriniture:(ENWFurniture *)furniturePiece;

@end
