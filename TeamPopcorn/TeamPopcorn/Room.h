//
//  TPCRoom.h
//  TeamPopcorn
//
//  Created by Flatiron School on 3/31/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPCRoom : NSObject

@property (strong, nonatomic, readonly) NSString *shape;
@property (assign,nonatomic) NSUInteger w, h, l;

+(instancetype)roomOfWidth:(NSUInteger)w
                    height:(NSUInteger)h
                    length:(NSUInteger)l;

@end
