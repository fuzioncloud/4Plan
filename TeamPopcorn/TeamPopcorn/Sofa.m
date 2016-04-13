//
//  TPCSofa.m
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCSofa.h"

@implementation TPCSofa

-(instancetype)init {
    self.name=@"basic";
    self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"basicSofa.png"] weight:sofaWeight];
    self.sofaStyle=basicSofa;
    return self;
    
}

-(instancetype)initWithSofaStlye:(TPCSofaStyle)sofaStyle {
    
    switch (sofaStyle) {
        case basicSofa:
            self.name=@"basic";
            self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"basicSofa.png"] weight:sofaWeight];
            self.sofaStyle=sofaStyle;
            return self;
            
        case cornerSofa:
            self.name=@"corner";
            self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"cornerSofa.png"] weight:sofaWeight];
            self.sofaStyle=sofaStyle;
            return self;
            
        case highSofa:
            self.name=@"high";
            self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"highSofa.png"] weight:sofaWeight];
            self.sofaStyle=sofaStyle;
            return self;
            
        case loveseatSofa:
            self.name=@"loveseat";
            self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"loveseatSofa.png"] weight:sofaWeight];
            self.sofaStyle=sofaStyle;
            return self;
            
        case lowSofa:
            self.name=@"low";
            self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"lowSofa.png"] weight:sofaWeight];
            self.sofaStyle=sofaStyle;
            return self;
            
        default:
            
            self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"basicSofa.png"] weight:sofaWeight];
            self.sofaStyle=sofaStyle;
            return self;
            
            
    }
    
}



+(instancetype)basicSofa{
    return [[self alloc]initWithSofaStlye:basicSofa];
}

+(instancetype)cornerSofa{
    return [[self alloc]initWithSofaStlye:cornerSofa];
}

+(instancetype)highSofa{
    return [[self alloc]initWithSofaStlye:highSofa];
}

+(instancetype)loveseatSofa{
    return [[self alloc]initWithSofaStlye:loveseatSofa];
}

+(instancetype)lowSofa{
    return [[self alloc]initWithSofaStlye:lowSofa];
}

@end
