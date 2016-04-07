//
//  StateManager.m
//  TeamPopcorn
//
//  Created by Flatiron School on 3/31/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "FPCStateManager.h"

@interface FPCStateManager ()
@property (strong, nonatomic, readwrite) FPCRoom *room;
@property (strong, nonatomic, readwrite) NSMutableArray<ENWFurniture *> *arrangedFurniture;

@end


@implementation FPCStateManager

+(instancetype)currentState {
    static FPCStateManager *staticState = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        staticState = [[self alloc]init];
    });
    return staticState;
}

-(void)setRoomOfWidth:(NSUInteger)w
               height:(NSUInteger)h
               length:(NSUInteger)l; {
    if (!self.room) {
        self.room = [FPCRoom roomOfWidth:w*12 height:h*12 length:l*12];
    } else {
        
        self.room = [FPCRoom roomOfWidth:w*12 height:h*12 length:l*12];
        
    }
}

-(void)placeFuriniture:(ENWFurniture *)furniturePiece {
    if (!self.arrangedFurniture) {
        self.arrangedFurniture = [NSMutableArray<ENWFurniture *> new];
    }
    furniturePiece.scale = [self scaleFurniture:furniturePiece inRoom:self.room];
    furniturePiece.horizontalDistanceFromOrigin = self.room.w / 2;
    furniturePiece.verticalDistanceFromOrigin = self.room.l / 2;
    [self.arrangedFurniture addObject:furniturePiece];
}

-(CGFloat)scaleFurniture:(ENWFurniture *)furniturePiece inRoom:(FPCRoom *)room {
    furniturePiece.widthscale = room.w*12 / furniturePiece.width;
    furniturePiece.lengthscale = room.l*12 / furniturePiece.length;
//    CGFloat heightScale = room.h / furniturePiece.height;
    
    return MIN(furniturePiece.widthscale,furniturePiece.lengthscale);
}

@end
