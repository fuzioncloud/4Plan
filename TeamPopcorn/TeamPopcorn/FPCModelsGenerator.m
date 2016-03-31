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
    
    NSArray<ENWBed *> *beds = @[[ENWBed twinBed],
                                [ENWBed fullBed],
                                [ENWBed queenBed],
                                [ENWBed kingBed],
                                [ENWBed californiaKingBed],
                                [ENWBed futonBed],
                                [ENWBed cribBed]
                                ];
    
    NSArray<ENWChair*> *chairs = @[[ENWChair basicChair],
                                   [ENWChair campingChair],
                                   [ENWChair lazyboyChair],
                                   [ENWChair officeChair],
                                   [ENWChair rockingChair]
                                   ];
    
    NSArray<ENWMisc*> *misc = @[[ENWMisc basicMisc],
                                [ENWMisc bicycleMisc],
                                [ENWMisc boxMisc],
                                [ENWMisc randomMisc],
                                [ENWMisc wardrobeMisc],
                                [ENWMisc doorMisc],
                                [ENWMisc visibleDoorMisc]
                                ];
    
    NSArray<ENWSofa *> *sofas = @[[ENWSofa basicSofa],
                                  [ENWSofa cornerSofa],
                                  [ENWSofa highSofa],
                                  [ENWSofa loveseatSofa],
                                  [ENWSofa lowSofa]
                                  ];

    NSArray<ENWTable*> *tables = @[[ENWTable basicTable],
                                   [ENWTable bedsideTable],
                                   [ENWTable coffeeTable],
                                   [ENWTable deskTable],
                                   [ENWTable roundTable]
                                   ];
    
    
    
    return @{bedKey:beds,
             chairKey:chairs,
             miscKey:misc,
             sofaKey:sofas,
             tableKey:tables
             };
}

@end
