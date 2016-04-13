//
//  TPCRoom+CoreDataProperties.h
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TPCRoom.h"

NS_ASSUME_NONNULL_BEGIN

@class TPCFurnitureButton;
@interface TPCRoom (CoreDataProperties)

@property (nonatomic) int64_t height;
@property (nonatomic) int64_t length;
@property (nullable, nonatomic, retain) NSString *shape;
@property (nonatomic) int64_t width;
@property (nullable, nonatomic, retain) NSOrderedSet<TPCFurnitureButton *> *placedFurniturePieces;

@end

@interface TPCRoom (CoreDataGeneratedAccessors)

- (void)insertObject:(TPCFurnitureButton *)value inPlacedFurniturePiecesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPlacedFurniturePiecesAtIndex:(NSUInteger)idx;
- (void)insertPlacedFurniturePieces:(NSArray<TPCFurnitureButton *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePlacedFurniturePiecesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPlacedFurniturePiecesAtIndex:(NSUInteger)idx withObject:(TPCFurnitureButton *)value;
- (void)replacePlacedFurniturePiecesAtIndexes:(NSIndexSet *)indexes withPlacedFurniturePieces:(NSArray<TPCFurnitureButton *> *)values;
- (void)addPlacedFurniturePiecesObject:(TPCFurnitureButton *)value;
- (void)removePlacedFurniturePiecesObject:(TPCFurnitureButton *)value;
- (void)addPlacedFurniturePieces:(NSOrderedSet<TPCFurnitureButton *> *)values;
- (void)removePlacedFurniturePieces:(NSOrderedSet<TPCFurnitureButton *> *)values;

@end

NS_ASSUME_NONNULL_END
