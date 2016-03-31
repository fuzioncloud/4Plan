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

@property (atomic)NSUInteger width;
@property (atomic)NSUInteger length;
@property (atomic)NSUInteger height;
@property (strong, nonatomic) UIImage *image;
@property (atomic)NSUInteger weight;
@property (atomic) CGFloat scale;
@property (atomic) NSUInteger horizontalDistanceFromOrigin;
@property (atomic) NSUInteger verticalDistanceFromOrigin;





-(instancetype)init;

-(instancetype)initWithWidth:(NSUInteger)width
                      length:(NSUInteger)length
                      height:(NSUInteger)height
                       image:(UIImage*)image
                      weight:(NSUInteger)weight;


@end
