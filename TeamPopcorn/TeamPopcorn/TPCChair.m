//
//  TPCChair.m
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCChair.h"

@implementation TPCChair

// Insert code here to add functionality to your managed object subclass

-(instancetype)init {
    self=[self initWithWidth:chairWidth length:chairLength height:chairHeight image:[UIImage imageNamed:@"basicChair.png"] weight:chairWeight];
    self.name=@"basic";
    self.chairStyle=basicChair;
    return self;
    
}

-(instancetype)initWithChairstlye:(TPCChairStyle)chairStyle {
    
    switch (chairStyle) {
        case basicChair:
            self=[self initWithWidth:chairWidth length:chairLength height:chairHeight image:[UIImage imageNamed:@"basicChair.png"] weight:chairWeight];
            self.name=@"basic";
            self.chairStyle=chairStyle;
            return self;
            
        case campingChair:
            self=[self initWithWidth:chairWidth length:chairLength height:chairHeight image:[UIImage imageNamed:@"campingChair.png"] weight:chairWeight];
            self.name=@"camping";
            self.chairStyle=chairStyle;
            return self;
            
        case lazyboyChair:
            self=[self initWithWidth:chairWidth length:chairLength height:chairHeight image:[UIImage imageNamed:@"lazyboyChair.png"] weight:chairWeight];
            self.name=@"lazyboy";
            self.chairStyle=chairStyle;
            return self;
            
        case officeChair:
            self=[self initWithWidth:chairWidth length:chairLength height:chairHeight image:[UIImage imageNamed:@"officeChair.png"] weight:chairWeight];
            self.name=@"office";
            self.chairStyle=chairStyle;
            return self;
            
        case rockingChair:
            self=[self initWithWidth:chairWidth length:chairLength height:chairHeight image:[UIImage imageNamed:@"rockingChair.png"] weight:chairWeight];
            self.name=@"rocking";
            self.chairStyle=chairStyle;
            return self;
            
        default:
            
            self=[self initWithWidth:chairWidth length:chairLength height:chairHeight image:[UIImage imageNamed:@"basicChair.png"] weight:chairWeight];
            self.name = @"default cair";
            self.chairStyle=chairStyle;
            return self;
            
    }
    
}

+(instancetype)basicChair{
    return [[self alloc]initWithChairstlye:basicChair];
}

+(instancetype)campingChair{
    return [[self alloc]initWithChairstlye:campingChair];
}

+(instancetype)lazyboyChair{
    return [[self alloc]initWithChairstlye:lazyboyChair];
}

+(instancetype)officeChair{
    return [[self alloc]initWithChairstlye:officeChair];
}

+(instancetype)rockingChair{
    return [[self alloc]initWithChairstlye:rockingChair];
}


@end
