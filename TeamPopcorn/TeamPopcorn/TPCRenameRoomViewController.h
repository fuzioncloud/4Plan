//
//  RenameRoomViewController.h
//  TeamPopcorn
//
//  Created by Flatiron School on 4/19/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPCRoom.h"

@class TPCRenameRoomViewController;

@protocol TPCRenameRoomViewControllerDelegate <NSObject>

@required
-(void)renameRoomViewControllerDidFinish:(TPCRenameRoomViewController *)renameRoomViewController;

@end


@interface TPCRenameRoomViewController : UIViewController

@property (nonatomic, weak) id<TPCRenameRoomViewControllerDelegate> delegate;
@property (strong, nonatomic) TPCRoom *room;

@end
