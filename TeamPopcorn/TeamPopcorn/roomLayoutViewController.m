//
//  roomLayoutViewController.m
//  TeamPopcorn
//
//  Created by michelle vargas on 3/29/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "roomLayoutViewController.h"
#import <UIKit/UIKit.h>

@interface roomLayoutViewController ()
@property (weak, nonatomic) IBOutlet UIView *roomLayoutView;
@property (assign) CGFloat size;



@end

@implementation roomLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    NSLog(@"width entered %@", self.widthField);
    NSLog(@"length entered %@", self.lengthField);
    
    float percentage = .50;
    int xPosition = _roomLayoutView.superview.frame.size.width * ((1 - percentage) / 8);
    int yPosition = _roomLayoutView.superview.frame.size.height * ((1 - percentage) / 3.0);
    NSInteger width = self.widthField.integerValue*35;
    NSInteger height = self.lengthField.integerValue*33;
    // aspect ratio = width / height
    // for our example of 30 x 40, aspectRatio = 0.795454561;
    
    // check for overflow
    NSInteger widthPositionAndPadding = (width + xPosition + 16);
    NSInteger heightPositionAndPadding = (height + yPosition + 16);
    
    BOOL overflowsHorizontally = widthPositionAndPadding > self.view.bounds.size.width;
    BOOL overflowsVertically = heightPositionAndPadding > self.view.bounds.size.height;
    
    if (overflowsHorizontally || overflowsVertically) {
        CGFloat horizontalDifference = widthPositionAndPadding - self.view.bounds.size.width;
        CGFloat verticalDifference = heightPositionAndPadding - self.view.bounds.size.height;
        width -= horizontalDifference;
        height -= verticalDifference;
        // ^BAD aspect ratio is now 0.561051011
    }

    
    _roomLayoutView.frame = CGRectMake(xPosition, yPosition, width, height);

    
    [_roomLayoutView sizeToFit];
    
    
    
    
//    [self constrainForFloorPlan];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

-(void) viewWillAppear:(BOOL)animated {
    
    self.view.backgroundColor = [UIColor colorWithHue:0.256 saturation:0.35 brightness:1.0 alpha:2.0];
    
    self.roomLayoutView.layer.borderColor = [UIColor blackColor].CGColor;
    self.roomLayoutView.layer.borderWidth = 1.0;
    
    self.roomLayoutView.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    
}


-(void) constrainForFloorPlan {


    
    [self.view removeConstraints:self.view.constraints];
    [self.roomLayoutView removeConstraints:self.view.constraints];
    self.roomLayoutView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.roomLayoutView.widthAnchor constraintLessThanOrEqualToAnchor:self.view.widthAnchor multiplier:0.8].active = YES;
    [self.roomLayoutView.heightAnchor constraintLessThanOrEqualToAnchor:self.view.heightAnchor multiplier:0.8].active = YES;

    

  
}


-(void) resizeToFitSubviews: (UIView *) view {
    
    float w = 0.0,h = 0.0;
    for (UIView *view in view.subviews) {
        float fw = view.frame.origin.x + view.frame.size.width;
        float fh = view.frame.origin.y + view.frame.size.height;
        w = MAX(fw, w);
        h = MAX(fh, h);
        
    }
    
    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y , w , h)];
    
}






@end
