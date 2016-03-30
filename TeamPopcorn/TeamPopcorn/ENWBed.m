//
//  ENWBed.m
//  TeamPopcorn
//
//  Created by Janet Lustgarten on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "ENWBed.h"

@implementation ENWBed

-(instancetype)init {
    self.name=@"basic";
    self=[self initWithWidth:bedWidth length:bedLength height:bedHeight image:[UIImage imageNamed:@"basicBed.png"] weight:bedWeight];
    self.bedSize = Twin;
    return self;
}

-(instancetype)initWithBedSize: (BedSize) bedSize {
    self.bedSize = bedSize;
    if (bedSize == Twin) {
        self.name=@"twin";
        self=[self initWithWidth:38 length:75 height:20 image:[UIImage imageNamed:@"basicBed.png"] weight:bedWeight];
        self.bedSize=bedSize;
        return self;
    }
    if (bedSize==Full) {
        self.name=@"full";
        self=[self initWithWidth:53 length:75 height:20 image:[UIImage imageNamed:@"basicBed.png"] weight:bedWeight];
        self.bedSize=bedSize;
        return self;
    }
    if (bedSize==Queen) {
        self.name=@"queen";
        self=[self initWithWidth:60 length:80 height:20 image:[UIImage imageNamed:@"basicBed.png"] weight:bedWeight];
        self.bedSize=bedSize;
        return self;
    }
    if (bedSize==King) {
        self.name=@"king";
        self=[self initWithWidth:76 length:80 height:20 image:[UIImage imageNamed:@"basicBed.png"]
              weight:bedWeight];
        self.bedSize=bedSize;
        return self;
    }
    if (bedSize==CaliforniaKing) {
        self.name=@"california king";
        self=[self initWithWidth:72 length:84 height:20 image:[UIImage imageNamed:@"basicBed.png"] weight:bedWeight];
        self.bedSize=bedSize;
        return self;
    }
    if (bedSize==Futon) {
        self.name=@"futon";
        self=[self initWithWidth:53 length:75 height:20 image:[UIImage imageNamed:@"basicBed.png"] weight:bedWeight];
        self.bedSize=bedSize;
        return self;
    }
    if (bedSize==Crib) {
        self.name=@"crib";
        self=[self initWithWidth:30 length:50 height:20 image:[UIImage imageNamed:@"basicBed.png"] weight:bedWeight];
        self.bedSize=bedSize;
        return self;
    }
    
    else {
        self=[self initWithWidth:38 length:75 height:20 image:[UIImage imageNamed:@"basicBed.png"] weight:bedWeight];
        self.bedSize=bedSize;
        return self;
    }

}

+(instancetype)twinBed {
    return [[self alloc]initWithBedSize:Twin];
}

+(instancetype)fullBed {
    return [[self alloc]initWithBedSize:Full];
}

+(instancetype)queenBed {
    return [[self alloc]initWithBedSize:Queen];
}

+(instancetype)kingBed {
    return [[self alloc]initWithBedSize:King];
}

+(instancetype)californiaKingBed {
    return [[self alloc]initWithBedSize:CaliforniaKing];
}

+(instancetype)cribBed {
    return [[self alloc]initWithBedSize:Crib];
}

+(instancetype)futonBed {
    return [[self alloc]initWithBedSize:Futon];
}









@end
