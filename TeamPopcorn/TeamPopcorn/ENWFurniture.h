//
//  ENWFurniture.h
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ENWFurniture : NSObject

@property (strong, nonatomic) NSString* name;

@property (atomic) NSUInteger width, length, height, weight;

@property (atomic) NSUInteger horizontalDistanceFromOrigin;
@property (atomic) NSUInteger verticalDistanceFromOrigin;

@property (atomic) CGFloat scale;

@property (strong, nonatomic) UIImage *image;


-(instancetype)init;

-(instancetype)initWithWidth:(NSUInteger)width
                      length:(NSUInteger)length
                      height:(NSUInteger)height
                       image:(UIImage*)image
                      weight:(NSUInteger)weight;


@end
