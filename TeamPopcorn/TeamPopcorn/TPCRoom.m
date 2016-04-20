//
//  TPCRoom.m
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCFurnitureButton.h"
#import "TPCStateManager.h"


@implementation TPCRoom

@synthesize savedFurniture = _savedFurniture;
@synthesize scaledWidth = _scaledWidth;
@synthesize scaledLength = _scaledLength;
@synthesize scaleForFurnitureW = _scaleForFurnitureW;
@synthesize scaleForFurnitureL = _scaleForFurnitureL;

-(NSArray<TPCFurniture *> *)savedFurniture {
    return [self.placedFurniturePieces array];
}

-(void)setSavedFurniture:(NSArray *)savedFurniture {
    self.placedFurniturePieces = [NSOrderedSet orderedSetWithArray:savedFurniture];
}

+(instancetype)roomOfWidth:(NSUInteger)w
                    height:(NSUInteger)h
                    length:(NSUInteger)l {
    NSManagedObjectContext *context = [TPCStateManager currentState].managedObjectContext;
    
    TPCRoom *newRoom = [NSEntityDescription
        insertNewObjectForEntityForName:@"TPCRoom"
        inManagedObjectContext:context];
    
    if (newRoom) {
        newRoom.width = w;
        newRoom.height = h;
        newRoom.length = l;
        if (w == l) {
            newRoom.shape = @"Square";
        }
        else {
            newRoom.shape = @"Rectangle";
        }
    }
    
    [[TPCStateManager currentState] saveContext];
    return newRoom;
}

//-(void)setName:(NSString *)name {
////    self.name = name;
//    [[TPCStateManager currentState] saveContext];
//}
@end
