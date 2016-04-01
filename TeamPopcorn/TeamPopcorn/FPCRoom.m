//
//  FPCRoom.m
//  TeamPopcorn
//
//  Created by Flatiron School on 3/31/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "FPCRoom.h"

@interface FPCRoom ()

@property (strong, nonatomic, readwrite) NSString *shape;

@end

@implementation FPCRoom

+(instancetype)roomOfWidth:(NSUInteger)w
                    height:(NSUInteger)h
                    length:(NSUInteger)l {
    FPCRoom *newRoom = [[self alloc] init];
    
    if (newRoom) {
        newRoom.w = w;
        newRoom.h = h;
        newRoom.l = l;
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
