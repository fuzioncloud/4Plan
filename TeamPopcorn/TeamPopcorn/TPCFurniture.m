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

-(UIImage *)image {
    return [UIImage imageWithData:self.imageData];
}

-(void)setImage:(UIImage *)image {
    self.imageData = UIImageJPEGRepresentation(image, 1);
    self.image = image;
}


-(instancetype)init {
    self=[self initWithWidth:0 length:0 height:0 image:[UIImage new] weight:0];
    
    
    return self;
}


-(instancetype)initWithWidth:(NSUInteger)width length:(NSUInteger)length height:(NSUInteger)height image:(UIImage *)image weight:(NSUInteger)weight{
   
    NSManagedObjectContext *context = [TPCStateManager currentState].context;
    
    TPCFurniture *furniture = [NSEntityDescription
                               insertNewObjectForEntityForName:@"TPCFurniture"
                               inManagedObjectContext:context];
    
    if (furniture) {
        furniture.width = width;
        furniture.length = length;
        furniture.height = height;
        furniture.image = image;
        furniture.weight = weight;
    }
    
    return self;
}

@end
