//
//  ENWMisc.m
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "ENWMisc.h"

@implementation ENWMisc

-(instancetype)init {
    self.name=@"lamp";
    self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"basicMisc.png"] weight:miscWeight];
    return self;
}


-(instancetype)initWithMiscStlye:(miscStyle)miscStyle {
    self.miscStyle=miscStyle;
    if (miscStyle==basicMisc) {
        self.name=@"lamp";
        self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"basicMisc.png"] weight:miscWeight];
        self.miscStyle=miscStyle;
        return self;
    }
    if (miscStyle==bicycleMisc) {
        self.name=@"bicycle";
        self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"bicycleMisc.png"] weight:miscWeight];
        self.miscStyle=miscStyle;
        return self;
    }
    if (miscStyle==boxMisc) {
        self.name=@"box";
        self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"boxMisc.png"] weight:miscWeight];
        self.miscStyle=miscStyle;
        return self;
    }
    if (miscStyle==randomMisc) {
        self.name=@"random";
        self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"randomMisc.png"] weight:miscWeight];
        self.miscStyle=miscStyle;
        return self;
    }
    if (miscStyle==wardrobeMisc) {
        self.name=@"wardrobe";
        self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"wardrobeMisc.png"] weight:miscWeight];
        self.miscStyle=miscStyle;
        return self;
    }
    else {
        self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"basicMisc.png"] weight:miscWeight];
        self.miscStyle=miscStyle;
        return self;
    }
    
}

+(instancetype)basicMisc {
    return [[self alloc]initWithMiscStlye:basicMisc];
}

+(instancetype)bicycleMisc {
    return [[self alloc]initWithMiscStlye:bicycleMisc];
}

+(instancetype)boxMisc {
    return [[self alloc]initWithMiscStlye:boxMisc];
}

+(instancetype)randomMisc {
    return [[self alloc]initWithMiscStlye:randomMisc];
}

+(instancetype)wardrobeMisc {
    return [[self alloc]initWithMiscStlye:wardrobeMisc];
}

@end
