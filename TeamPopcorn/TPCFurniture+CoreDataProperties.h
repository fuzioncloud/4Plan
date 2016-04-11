//
//  TPCFurniture+CoreDataProperties.h
//  
//
//  Created by michelle vargas on 4/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TPCFurniture.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPCFurniture (CoreDataProperties)

@property (nonatomic) int64_t height;
@property (nonatomic) int64_t horizontalDistanceFromOrigin;
@property (nullable, nonatomic, retain) NSData *image;
@property (nonatomic) int64_t length;
@property (nonatomic) float lengthScale;
@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) float scale;
@property (nonatomic) int64_t verticalDistanceFromOrigin;
@property (nonatomic) int64_t weight;
@property (nonatomic) int64_t width;
@property (nonatomic) float widthScale;

@end

NS_ASSUME_NONNULL_END
