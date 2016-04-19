//
//  RenameRoomViewController.h
//  TeamPopcorn
//
//  Created by Flatiron School on 4/19/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPCRenameRoomViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) NSString *nameStr;

@end
