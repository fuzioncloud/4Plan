//
//  ENWSofa.m
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "ENWSofa.h"

@implementation ENWSofa

-(instancetype)init {
    self.name=@"basic";
    self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"basicSofa.png"] weight:sofaWeight];
    self.sofaStyle=basicSofa;
    return self;
    
}

-(instancetype)initWithSofaStlye:(sofaStyle)sofaStyle {
    self.sofaStyle=sofaStyle;
    if (sofaStyle==basicSofa) {
        self.name=@"basic";
        self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"basicSofa.png"] weight:sofaWeight];
        self.sofaStyle=sofaStyle;
        return self;
    }
    if (sofaStyle==cornerSofa) {
        self.name=@"corner";
        self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"cornerSofa.png"] weight:sofaWeight];
        self.sofaStyle=sofaStyle;
        return self;
    }
    if (sofaStyle==highSofa) {
        self.name=@"high";
        self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"highSofa.png"] weight:sofaWeight];
        self.sofaStyle=sofaStyle;
        return self;
    }
    if (sofaStyle==loveseatSofa) {
        self.name=@"loveseat";
        self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"loveseatSofa.png"] weight:sofaWeight];
        self.sofaStyle=sofaStyle;
        return self;
    }
    if (sofaStyle==lowSofa) {
        self.name=@"low";
        self=[self initWithWidth:sofaWidth length:sofaLength height:sofaHeight image:[UIImage imageNamed:@"lowSofa.png"] weight:sofaWeight];
        self.sofaStyle=sofaStyle;
        return self;
    }
    else {
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
