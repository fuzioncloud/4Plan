//
//  ENWChair.m
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "ENWChair.h"

@implementation ENWChair


-(instancetype)init {
    self.name=@"basic";
    self=[self initWithWidth:chairWidth length:chairLength height:chairHeight image:[UIImage imageNamed:@"basicChair.png"] weight:chairWeight];
    self.chairStyle=basicChair;
    return self;
    
}

-(instancetype)initWithChairstlye:(chairStyle)chairStyle {
    
    switch (chairStyle) {
        case basicChair:
            self.name=@"basic";
            self=[self initWithWidth:chairWidth length:chairLength height:chairHeight image:[UIImage imageNamed:@"basicChair.png"] weight:chairWeight];
            self.chairStyle=chairStyle;
            return self;
            
        case campingChair:
            self.name=@"camping";
            self=[self initWithWidth:chairWidth length:chairLength height:chairHeight image:[UIImage imageNamed:@"campingChair.png"] weight:chairWeight];
            self.chairStyle=chairStyle;
            return self;
            
        case lazyboyChair:
            self.name=@"lazyboy";
            self=[self initWithWidth:chairWidth length:chairLength height:chairHeight image:[UIImage imageNamed:@"lazyboyChair.png"] weight:chairWeight];
            self.chairStyle=chairStyle;
            return self;
            
        case officeChair:
            self.name=@"office";
            self=[self initWithWidth:chairWidth length:chairLength height:chairHeight image:[UIImage imageNamed:@"officeChair.png"] weight:chairWeight];
            self.chairStyle=chairStyle;
            return self;
            
        case rockingChair:
            self.name=@"rocking";
            self=[self initWithWidth:chairWidth length:chairLength height:chairHeight image:[UIImage imageNamed:@"rockingChair.png"] weight:chairWeight];
            self.chairStyle=chairStyle;
            return self;
            
        default:
        
            self=[self initWithWidth:chairWidth length:chairLength height:chairHeight image:[UIImage imageNamed:@"basicChair.png"] weight:chairWeight];
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
