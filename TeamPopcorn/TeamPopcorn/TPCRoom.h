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
@property (atomic) CGFloat scaledWidth;
@property (atomic) CGFloat scaledLength;
@property (atomic) CGFloat scaleForFurnitureW;
@property (atomic) CGFloat scaleForFurnitureL;

+(instancetype)roomOfWidth:(NSUInteger)w
                    height:(NSUInteger)h
                    length:(NSUInteger)l;

@end
