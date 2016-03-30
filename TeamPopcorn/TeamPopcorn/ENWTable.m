//
//  ENWTable.m
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "ENWTable.h"

@implementation ENWTable

-(instancetype)init {
    self.name=@"basic";
    self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"basicTable.png"] weight:tableWeight];
    self.tableStyle=basicTable;
    return self;
    
}

-(instancetype)initWithTableStlye:(tableStyle)tableStyle {
    
    switch (tableStyle) {
        case basicTable:
            self.name=@"basic";
            self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"basicTable.png"] weight:tableWeight];
            self.tableStyle=tableStyle;
            return self;
            
        case bedsideTable:
            self.name=@"bedside";
            self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"bedsideTable.png"] weight:tableWeight];
            self.tableStyle=tableStyle;
            return self;
            
        case coffeeTable:
            self.name=@"coffee";
            self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"coffeeTable.png"] weight:tableWeight];
            self.tableStyle=tableStyle;
            return self;
            
        case deskTable:
            self.name=@"desk";
            self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"deskTable.png"] weight:tableWeight];
            self.tableStyle=tableStyle;
            return self;
            
        case roundTable:
            self.name=@"round";
            self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"roundTable.png"] weight:tableWeight];
            self.tableStyle=tableStyle;
            return self;
            
        default:
            
            self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"basicTable.png"] weight:tableWeight];
            self.tableStyle=tableStyle;
            return self;
            
            
    }
    
}


+(instancetype)basicTable {
    return [[self alloc]initWithTableStlye:basicTable];
}

+(instancetype)bedsideTable {
    return [[self alloc]initWithTableStlye:bedsideTable];
}

+(instancetype)coffeeTable {
    return [[self alloc]initWithTableStlye:coffeeTable];
}

+(instancetype)deskTable {
    return [[self alloc]initWithTableStlye:deskTable];
}

+(instancetype)roundTable {
    return [[self alloc]initWithTableStlye:roundTable];
}






@end
