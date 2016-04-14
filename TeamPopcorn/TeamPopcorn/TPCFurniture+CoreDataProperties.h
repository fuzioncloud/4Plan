//
//  TPCFurniture+CoreDataProperties.h
//  TeamPopcorn
//
//  Created by Flatiron School on 4/14/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TPCFurniture.h"
#import "TPCRoom.h"


NS_ASSUME_NONNULL_BEGIN

@interface TPCFurniture (CoreDataProperties)

@property (nonatomic) float centerValuesX;
@property (nonatomic) float centerValuesY;
@property (nonatomic) BOOL hasMoved;
@property (nonatomic) BOOL hasScaled;
@property (nonatomic) int64_t height;
@property (nonatomic) int64_t horizontalDistanceFromOrigin;
@property (nullable, nonatomic, retain) NSData *imageData;
@property (nonatomic) int64_t length;
@property (nonatomic) float lengthScale;
@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) float scale;
@property (nonatomic) int64_t verticalDistanceFromOrigin;
@property (nonatomic) int64_t weight;
@property (nonatomic) int64_t width;
@property (nonatomic) float widthScale;
@property (nullable, nonatomic, retain) TPCRoom *room;

@end

NS_ASSUME_NONNULL_END
