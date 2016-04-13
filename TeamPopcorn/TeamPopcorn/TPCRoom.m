//
//  TPCRoom.m
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCRoom.h"
#import "TPCFurnitureButton.h"
#import "TPCStateManager.h"


@implementation TPCRoom

// Insert code here to add functionality to your managed object subclass

+(instancetype)roomOfWidth:(NSUInteger)w
                    height:(NSUInteger)h
                    length:(NSUInteger)l {
    NSManagedObjectContext *context = [TPCStateManager currentState].context;
    
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
    return newRoom;
}
@end
