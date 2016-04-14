//
//  TPCTable.m
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCTable.h"

@implementation TPCTable

// Insert code here to add functionality to your managed object subclass

-(instancetype)init {
    self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"basicTable.png"] weight:tableWeight];
    self.name=@"basic";
    self.tableStyle=basicTable;
    return self;
    
}

-(instancetype)initWithTableStlye:(TPCTableStyle)tableStyle {
    
    switch (tableStyle) {
        case basicTable:
            self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"basicTable.png"] weight:tableWeight];
            self.name=@"basic";
            self.tableStyle=tableStyle;
            return self;
            
        case bedsideTable:
            self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"bedsideTable.png"] weight:tableWeight];
            self.name=@"bedside";
            self.tableStyle=tableStyle;
            return self;
            
        case coffeeTable:
            self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"coffeeTable.png"] weight:tableWeight];
            self.name=@"coffee";
            self.tableStyle=tableStyle;
            return self;
            
        case deskTable:
            self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"deskTable.png"] weight:tableWeight];
            self.name=@"desk";
            self.tableStyle=tableStyle;
            return self;
            
        case roundTable:
            self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"roundTable.png"] weight:tableWeight];
            self.name=@"round";
            self.tableStyle=tableStyle;
            return self;
            
        default:
            
            self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"basicTable.png"] weight:tableWeight];
            self.name = @"default table";
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
