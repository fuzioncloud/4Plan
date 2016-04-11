//
//  TPCFurniture.m
//  
//
//  Created by michelle vargas on 4/11/16.
//
//

#import "TPCFurniture.h"

@implementation TPCFurniture

// Insert code here to add functionality to your managed object subclass


-(instancetype)init {
    self=[self initWithWidth:0 length:0 height:0 image:nil weight:0];
    return self;
}

-(instancetype)initWithWidth:(NSUInteger)width length:(NSUInteger)length height:(NSUInteger)height image:(UIImage *)image weight:(NSUInteger)weight{
    self=[super init];
    if(self) {
        _width=width;
        _length=length;
        _height=height;
        _image=image;
        _weight=weight;
    }
    return self;
}



@end
