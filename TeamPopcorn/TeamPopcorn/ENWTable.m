//
//  ENWTable.m
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "ENWTable.h"

@implementation ENWTable

-(instancetype)init {
    self=[self initWithWidth:50 length:60 height:50 image:[UIImage imageNamed:@"basicTable.png"]];
    return self;
}

//-(instancetype) initWithWidth:(NSUInteger)width length:(NSUInteger)length height:(NSUInteger)height image:(UIImage *)image {
//    self=[super init];
//    if(self) {
//        _width=width;
//        _length=length;
//        _height=height;
//        _image=image;
//        
//        
//    }
//}


@end
