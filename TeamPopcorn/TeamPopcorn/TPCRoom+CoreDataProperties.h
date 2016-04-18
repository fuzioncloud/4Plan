//
//  TPCRoom+CoreDataProperties.h
//  TeamPopcorn
//
//  Created by Flatiron School on 4/14/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TPCRoom.h"
#import "TPCFurniture.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPCRoom (CoreDataProperties)

@property (strong, nonatomic) NSString *name;

@property (nonatomic) int64_t width;
@property (nonatomic) int64_t height;
@property (nonatomic) int64_t length;

@property (nullable, nonatomic, retain) NSString *shape;

@property (nullable, nonatomic, retain) NSOrderedSet<TPCFurniture *> *placedFurniturePieces;

@end


@interface TPCRoom (CoreDataGeneratedAccessors)


- (void)insertObject:(TPCFurniture *)value inPlacedFurniturePiecesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPlacedFurniturePiecesAtIndex:(NSUInteger)idx;
- (void)insertPlacedFurniturePieces:(NSArray<TPCFurniture *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePlacedFurniturePiecesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPlacedFurniturePiecesAtIndex:(NSUInteger)idx withObject:(TPCFurniture *)value;
- (void)replacePlacedFurniturePiecesAtIndexes:(NSIndexSet *)indexes withPlacedFurniturePieces:(NSArray<TPCFurniture *> *)values;
- (void)addPlacedFurniturePiecesObject:(TPCFurniture *)value;
- (void)removePlacedFurniturePiecesObject:(TPCFurniture *)value;
- (void)addPlacedFurniturePieces:(NSOrderedSet<TPCFurniture *> *)values;
- (void)removePlacedFurniturePieces:(NSOrderedSet<TPCFurniture *> *)values;


@end

NS_ASSUME_NONNULL_END
