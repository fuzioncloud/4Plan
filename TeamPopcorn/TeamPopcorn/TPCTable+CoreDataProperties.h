//
//  TPCTable+CoreDataProperties.h
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TPCTable.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPCTable (CoreDataProperties)

@property (nonatomic) int64_t tableStyle;

@end

NS_ASSUME_NONNULL_END