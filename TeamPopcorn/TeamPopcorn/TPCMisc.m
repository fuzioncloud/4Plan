//
//  TPCMisc.m
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCMisc.h"

@implementation TPCMisc

// Insert code here to add functionality to your managed object subclass
-(instancetype)init {
    self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"basicMisc.png"] weight:miscWeight];
    self.name=@"lamp";
    return self;
}

-(instancetype)initWithMiscStlye:(TPCMiscStyle)miscStyle {
    
    switch (miscStyle) {
        case basicMisc:
            self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"basicMisc.png"] weight:miscWeight];
            self.name=@"lamp";
            self.miscStyle=miscStyle;
            return self;
            
        case bicycleMisc:
            self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"bicycleMisc.png"] weight:miscWeight];
            self.name=@"bicycle";
            self.miscStyle=miscStyle;
            return self;
            
        case boxMisc:
            self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"boxMisc.png"] weight:miscWeight];
            self.name=@"box";
            self.miscStyle=miscStyle;
            return self;
            
        case randomMisc:
            self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"randomMisc.png"] weight:miscWeight];
            self.name=@"random";
            self.miscStyle=miscStyle;
            return self;
            
        case wardrobeMisc:
            self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"wardrobeMisc.png"] weight:miscWeight];
            self.name=@"wardrobe";
            self.miscStyle=miscStyle;
            return self;
            
        case doorMisc:
            self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"doorMisc"] weight:miscWeight];
            self.name=@"door";
            self.miscStyle=miscStyle;
            return self;
            
        case visibleDoorMisc:
            self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"visibleDoorMisc"] weight:miscWeight];
            self.name=@"visibleDoor";
            self.miscStyle=miscStyle;
            return self;
            
        case skateboardMisc:
            self=[self initWithWidth:10 length:36 height:8 image:[UIImage imageNamed:@"skateboardMisc.png"] weight:miscWeight];
            self.name=@"skateboard";
            self.miscStyle=miscStyle;
            return self;
            
        case smallboxMisc:
            self=[self initWithWidth:10 length:10 height:10 image:[UIImage imageNamed:@"smallboxMisc.png"] weight:miscWeight];
            self.name=@"smallbox";
            self.miscStyle=miscStyle;
            return self;
            
        case binderMisc:
            self=[self initWithWidth:9 length:11 height:5 image:[UIImage imageNamed:@"binderMisc.png"] weight:miscWeight];
            self.name=@"binder";
            self.miscStyle=miscStyle;
            return self;
            
        case cameraMisc:
            self=[self initWithWidth:7 length:6 height:5 image:[UIImage imageNamed:@"cameraMisc.png"] weight:miscWeight];
            self.name=@"camera";
            self.miscStyle=miscStyle;
            return self;
            
            
        default:
            
            self=[self initWithWidth:miscWidth length:miscLength height:miscHeight image:[UIImage imageNamed:@"basicMisc.png"] weight:miscWeight];
            self.name = @"default misc";
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
