//
//  TPCRoom+CoreDataProperties.h
//  
//
//  Created by michelle vargas on 4/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TPCRoom.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPCRoom (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *shape;
@property (nonatomic) int64_t w;
@property (nonatomic) int64_t h;
@property (nonatomic) int64_t l;

@end

NS_ASSUME_NONNULL_END
