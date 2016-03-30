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
    self.tableStyle=tableStyle;
    if (tableStyle==basicTable) {
        self.name=@"basic";
        self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"basicTable.png"] weight:tableWeight];
        self.tableStyle=tableStyle;
        return self;
    }
    if (tableStyle==bedsideTable) {
         self.name=@"bedside";
        self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"bedsideTable.png"] weight:tableWeight];
        self.tableStyle=tableStyle;
        return self;
    }
    if (tableStyle==coffeeTable) {
        self.name=@"coffee";
        self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"coffeeTable.png"] weight:tableWeight];
        self.tableStyle=tableStyle;
        return self;
    }
    if (tableStyle==deskTable) {
        self.name=@"desk";
        self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"deskTable.png"] weight:tableWeight];
        self.tableStyle=tableStyle;
        return self;
    }
    if (tableStyle==roundTable) {
        self.name=@"round";
        self=[self initWithWidth:tableWidth length:tableLength height:tableHeight image:[UIImage imageNamed:@"roundTable.png"] weight:tableWeight];
        self.tableStyle=tableStyle;
        return self;
    }
    else {
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
