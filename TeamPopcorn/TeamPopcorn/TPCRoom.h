//
//  TPCRoom.h
//  TeamPopcorn
//
//  Created by Flatiron School on 3/31/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TPCRoom : NSObject

@property (strong, nonatomic, readonly) NSString *shape;
@property (assign,nonatomic) NSUInteger w, h, l;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *savedFurniture;
@property (nonatomic) CGFloat scaledWidth, scaledHeight, scaleForFurnitureW, scaleForFurnitureL;

+(instancetype)roomOfWidth:(NSUInteger)w
                    height:(NSUInteger)h
                    length:(NSUInteger)l;

@end
