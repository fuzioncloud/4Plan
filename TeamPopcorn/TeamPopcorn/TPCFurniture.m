//
//  TPCFurniture.m
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCFurniture.h"
#import "TPCFurnitureButton.h"
#import "TPCStateManager.h"

@implementation TPCFurniture

// Insert code here to add functionality to your managed object subclass

//@synthesize name = _name;
@synthesize image = _image;
@synthesize centerValues = _centerValues;
//@synthesize placedFurniture;

//-(NSString*)name {
//    return _name;
//}
//
//-(void)setName:(NSString *)name {
//    _name = name;
//}

-(UIImage *)image {
    if(!_image) {
        _image = [UIImage imageWithData:self.imageData];
    }
    
    return _image;
}

-(void)setImage:(UIImage *)image {
    self.imageData = UIImageJPEGRepresentation(image, 1);
    _image = image;
}

-(CGPoint)centerValues {
    _centerValues = CGPointMake(self.centerValuesX, self.centerValuesY);
    return _centerValues;
}

-(void)setCenterValues:(CGPoint)centerValues{
    _centerValues = centerValues;
    self.centerValuesX = _centerValues.x;
    self.centerValuesY = _centerValues.y;
}

-(instancetype)init {
    self=[self initWithWidth:0 length:0 height:0 image:[UIImage new] weight:0];
    
    
    return self;
}


-(instancetype)initWithWidth:(NSUInteger)width length:(NSUInteger)length height:(NSUInteger)height image:(UIImage *)image weight:(NSUInteger)weight{
   
    NSManagedObjectContext *context = [TPCStateManager currentState].managedObjectContext;
    
    self = [NSEntityDescription
                               insertNewObjectForEntityForName:NSStringFromClass([self class])
                               inManagedObjectContext:context];
    
    if (self) {
        self.width = width;
        self.length = length;
        self.height = height;
        self.image = image;
        self.weight = weight;
    }
    
    return self;
}

@end
