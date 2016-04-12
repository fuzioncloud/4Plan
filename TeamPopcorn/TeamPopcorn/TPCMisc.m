//
//  TPCMisc.m
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCMisc.h"

@implementation TPCMisc

-(instancetype)init {
    self.name=@"lamp";
    self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"basicMisc.png"] weight:miscWeight];
    return self;
}

-(instancetype)initWithMiscStlye:(TPCMiscStyle)miscStyle {
    
    switch (miscStyle) {
        case basicMisc:
            self.name=@"lamp";
            self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"basicMisc.png"] weight:miscWeight];
            self.miscStyle=miscStyle;
            return self;
            
        case bicycleMisc:
            self.name=@"bicycle";
            self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"bicycleMisc.png"] weight:miscWeight];
            self.miscStyle=miscStyle;
            return self;
            
        case boxMisc:
            self.name=@"box";
            self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"boxMisc.png"] weight:miscWeight];
            self.miscStyle=miscStyle;
            return self;
            
        case randomMisc:
            self.name=@"random";
            self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"randomMisc.png"] weight:miscWeight];
            self.miscStyle=miscStyle;
            return self;
            
        case wardrobeMisc:
            self.name=@"wardrobe";
            self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"wardrobeMisc.png"] weight:miscWeight];
            self.miscStyle=miscStyle;
            return self;
            
        case doorMisc:
            self.name=@"door";
            self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"doorMisc"] weight:miscWeight];
            self.miscStyle=miscStyle;
            return self;
            
        case visibleDoorMisc:
            self.name=@"visibleDoor";
            self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"visibleDoorMisc"] weight:miscWeight];
            self.miscStyle=miscStyle;
            return self;
            
        case skateboardMisc:
            self.name=@"skateboard";
            self=[self initWithWidth:10 length:36 height:8 image:[UIImage imageNamed:@"skateboardMisc.png"] weight:miscWeight];
            self.miscStyle=miscStyle;
            return self;
            
        case smallboxMisc:
            self.name=@"smallbox";
            self=[self initWithWidth:10 length:10 height:10 image:[UIImage imageNamed:@"smallboxMisc.png"] weight:miscWeight];
            self.miscStyle=miscStyle;
            return self;
            
        case binderMisc:
            self.name=@"binder";
            self=[self initWithWidth:9 length:11 height:5 image:[UIImage imageNamed:@"binderMisc.png"] weight:miscWeight];
            self.miscStyle=miscStyle;
            return self;
            
        case cameraMisc:
            self.name=@"camera";
            self=[self initWithWidth:7 length:6 height:5 image:[UIImage imageNamed:@"cameraMisc.png"] weight:miscWeight];
            self.miscStyle=miscStyle;
            return self;
            
            
        default:
            
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

+(instancetype)doorMisc {
    return [[self alloc]initWithMiscStlye:doorMisc];
}

+(instancetype)visibleDoorMisc {
    return [[self alloc]initWithMiscStlye:visibleDoorMisc];
}

+(instancetype)skateboardMisc {
    return [[self alloc]initWithMiscStlye:skateboardMisc];
}

+(instancetype)smallboxMisc {
    return [[self alloc]initWithMiscStlye:smallboxMisc];
}

+(instancetype)binderMisc {
    return [[self alloc] initWithMiscStlye:binderMisc];
}

+(instancetype)cameraMisc {
    return [[self alloc] initWithMiscStlye:cameraMisc];
}

@end
