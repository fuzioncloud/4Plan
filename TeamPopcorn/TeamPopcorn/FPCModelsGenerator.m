//
//  FPCModelsGenerator.m
//  TeamPopcorn
//
//  Created by Flatiron School on 3/30/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "FPCModelsGenerator.h"

@implementation FPCModelsGenerator

+(NSDictionary<FPCCatalogDescriber *,NSArray<ENWFurniture *> *> *)generateModels{
    FPCCatalogDescriber *bedKey = [FPCCatalogDescriber withName:@"Beds" index:BedIndex];
    FPCCatalogDescriber *chairKey = [FPCCatalogDescriber withName:@"Chairs" index:ChairIndex];
    FPCCatalogDescriber *miscKey = [FPCCatalogDescriber withName:@"Misc" index:MiscIndex];
    FPCCatalogDescriber *sofaKey = [FPCCatalogDescriber withName:@"Sofas" index:SofaIndex];
    FPCCatalogDescriber *tableKey = [FPCCatalogDescriber withName:@"Tables" index:TableIndex];
    
    NSArray<ENWBed *> *beds = @[[[ENWBed alloc]initWithBedSize:Twin],
                                [[ENWBed alloc]initWithBedSize:Full],
                                [[ENWBed alloc]initWithBedSize:Queen],
                                [[ENWBed alloc]initWithBedSize:King],
                                [[ENWBed alloc]initWithBedSize:CaliforniaKing],
                                [[ENWBed alloc]initWithBedSize:Futon],
                                [[ENWBed alloc]initWithBedSize:Crib]
                                ];
    NSArray<ENWChair*> *chairs = @[[[ENWChair alloc]init]
                                   ];
    
    NSArray<ENWMisc*> *misc = @[[[ENWMisc alloc]init]
                                ];
    
    NSArray<ENWSofa *> *sofas = @[[[ENWSofa alloc]init]
                                  ];

    NSArray<ENWTable*> *tables = @[[[ENWTable alloc]init]
                                   ];
    
    
    
    return @{bedKey:beds,
             chairKey:chairs,
             miscKey:misc,
             sofaKey:sofas,
             tableKey:tables
             };
}

@end
