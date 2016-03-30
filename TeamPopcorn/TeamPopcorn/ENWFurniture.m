//
//  ENWFurniture.m
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "ENWFurniture.h"
#import "ENWChair.h"



@implementation ENWFurniture

-(instancetype)init {
    self=[self initWithWidth:0 length:0 height:0 image:nil weight:0];
    return self;
}

//+(NSArray *)furnitureFromJSON
//{
//    NSData *jsonFileData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"furniture" ofType:@"json"]];
//    NSArray *arrayOfDictionaries = [NSJSONSerialization JSONObjectWithData:jsonFileData options:0 error:nil];
//    
//    NSMutableArray *furnitureObjects = [[NSMutableArray alloc] init];
//    for(NSDictionary *dictionary in arrayOfDictionaries) {
//        ENWFurniture *furniture = [self furnitureWithDictionary:dictionary];
//        [furnitureObjects addObject:furniture];
//    }
//    
//    return furnitureObjects;
//}
//
//+(instancetype)furnitureWithDictionary:(NSDictionary *)dictionary
//{
//    NSString *furnitureType = dictionary[@"type"];
//    Class klass = NSClassFromString(furnitureType);
////    if([furnitureType isEqualToString:@"chair"]) {
////        klass = [ENWChair class];
////    }
//    
//    ENWFurniture *furniture = [[klass alloc] initWithWidth:[dictionary[@"width"] integerValue]  length:[dictionary[@"length"] integerValue] height:[dictionary[@"height"] integerValue] image:[UIImage imageNamed:dictionary[@"image"]]];
//    
//    // have to get the integer values of the strings no the strings themselves
//    
//    return furniture;
//}

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
