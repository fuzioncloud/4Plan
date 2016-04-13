//
//  ViewController.h
//  TeamPopcorn
//
//  Created by susan lovaglio on 3/30/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPCFurniture.h"

@protocol TPCMainViewControllerDelegate

@end

@interface TPCMainViewController : UIViewController

@property (nonatomic) id<TPCMainViewControllerDelegate> delegate;
@property (strong, nonatomic) UIView *roomLayoutView;


-(void)showDismissMenu;


@end
