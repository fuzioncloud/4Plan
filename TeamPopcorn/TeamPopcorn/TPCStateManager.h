//
//  TPCStateManager.h
//  TeamPopcorn
//
//  Created by Flatiron School on 3/31/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPCModelsGenerator.h"
#import "TPCFurnitureButton.h"

@protocol TPCStateManagerDelegate

@end

@interface TPCStateManager : NSObject

@property (strong, nonatomic) TPCRoom *room;
@property (strong, nonatomic) NSMutableArray<TPCFurniture *> *arrangedFurniture;
@property (strong, nonatomic, readwrite) NSMutableArray<TPCFurnitureButton *>*arrangedButtons;
@property (nonatomic) BOOL roomHasChanged;
@property (nonatomic) id<TPCStateManagerDelegate> delegate;
@property (strong, nonatomic) NSMutableArray<TPCRoom *> *savedRooms;

+(instancetype)currentState;

-(TPCRoom *)setRoomOfWidth:(NSUInteger)w
               height:(NSUInteger)h
               length:(NSUInteger)l;

-(void)placeFuriniture:(TPCFurniture *)furniturePiece;

-(void)checkIfRoomHasChanged:(TPCRoom*) originalRoom;

@end
