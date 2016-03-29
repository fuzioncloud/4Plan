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
    self=[self initWithWidth:38 length:75 height:20 image:[UIImage imageNamed:@"basicBed.png"]];
    self.bedSize = Twin;
    return self;
}

-(instancetype)initWithBedSize: (BedSize) bedSize {
    self.bedSize = bedSize;
    if (bedSize == Twin) {
        self=[self initWithWidth:38 length:75 height:20 image:[UIImage imageNamed:@"basicBed.png"]];
        self.bedSize=bedSize;
        return self;
    }
    if (bedSize==Full) {
        self=[self initWithWidth:53 length:75 height:20 image:[UIImage imageNamed:@"basicBed.png"]];
        self.bedSize=bedSize;
        return self;
    }
    if (bedSize==Queen) {
        self=[self initWithWidth:60 length:80 height:20 image:[UIImage imageNamed:@"basicBed.png"]];
        self.bedSize=bedSize;
        return self;
    }
    if (bedSize==King) {
        self=[self initWithWidth:76 length:80 height:20 image:[UIImage imageNamed:@"basicBed.png"]];
        self.bedSize=bedSize;
        return self;
    }
    if (bedSize==CaliforniaKing) {
        self=[self initWithWidth:72 length:84 height:20 image:[UIImage imageNamed:@"basicBed.png"]];
        self.bedSize=bedSize;
        return self;
    }
    if (bedSize==Futon) {
        self=[self initWithWidth:53 length:75 height:20 image:[UIImage imageNamed:@"basicBed.png"]];
        self.bedSize=bedSize;
        return self;
    }
    if (bedSize==Crib) {
        self=[self initWithWidth:30 length:50 height:20 image:[UIImage imageNamed:@"basicBed.png"]];
        self.bedSize=bedSize;
        return self;
    }
    
    else {
        return self;
    }

}




@end
