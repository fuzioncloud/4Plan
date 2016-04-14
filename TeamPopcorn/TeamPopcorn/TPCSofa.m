//
//  TPCSofa.m
//  TeamPopcorn
//
//  Created by Flatiron School on 4/12/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCSofa.h"

@implementation TPCSofa

// Insert code here to add functionality to your managed object subclass
-(instancetype)init {
    self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"basicSofa.png"] weight:sofaWeight];
    self.name=@"basic";
    self.sofaStyle=basicSofa;
    return self;
    
}

-(instancetype)initWithSofaStlye:(TPCSofaStyle)sofaStyle {
    
    switch (sofaStyle) {
        case basicSofa:
            self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"basicSofa.png"] weight:sofaWeight];
            self.name=@"basic";
            self.sofaStyle=sofaStyle;
            return self;
            
        case cornerSofa:
            self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"cornerSofa.png"] weight:sofaWeight];
            self.name=@"corner";
            self.sofaStyle=sofaStyle;
            return self;
            
        case highSofa:
            self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"highSofa.png"] weight:sofaWeight];
            self.name=@"high";
            self.sofaStyle=sofaStyle;
            return self;
            
        case loveseatSofa:
            self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"loveseatSofa.png"] weight:sofaWeight];
            self.name=@"loveseat";
            self.sofaStyle=sofaStyle;
            return self;
            
        case lowSofa:
            self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"lowSofa.png"] weight:sofaWeight];
            self.name=@"low";
            self.sofaStyle=sofaStyle;
            return self;
            
        default:
            
            self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"basicSofa.png"] weight:sofaWeight];
            self.name = @"default sofa";
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
