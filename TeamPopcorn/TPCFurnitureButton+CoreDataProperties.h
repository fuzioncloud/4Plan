//
//  TPCFurnitureButton+CoreDataProperties.h
//  
//
//  Created by michelle vargas on 4/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TPCFurnitureButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPCFurnitureButton (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *leftConstraint;
@property (nullable, nonatomic, retain) NSData *topConstraint;
@property (nullable, nonatomic, retain) NSData *widthConstraint;
@property (nullable, nonatomic, retain) NSData *lengthConstraint;
@property (nullable, nonatomic, retain) TPCFurniture *furnitureItem;

@end

NS_ASSUME_NONNULL_END
