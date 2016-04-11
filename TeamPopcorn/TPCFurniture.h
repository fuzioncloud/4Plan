//
//  TPCFurniture.h
//  
//
//  Created by michelle vargas on 4/11/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPCFurniture : NSManagedObject

// Insert code here to declare functionality of your managed object subclass


-(instancetype) init;

-(instancetype)initWithWidth:(NSUInteger)width
                      length:(NSUInteger)length
                      height:(NSUInteger)height
                       image:(UIImage*)image
                      weight:(NSUInteger)weight;


@end

NS_ASSUME_NONNULL_END

#import "TPCFurniture+CoreDataProperties.h"
