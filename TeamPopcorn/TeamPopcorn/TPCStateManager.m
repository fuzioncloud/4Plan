//
//  TPCStateManager.m
//  TeamPopcorn
//
//  Created by Flatiron School on 3/31/16.
//  Copyright © 2016 Popcorn. All rights reserved.
//

#import "TPCStateManager.h"
#import "TPCModels.h"

@interface TPCStateManager ()

@property (nonatomic) NSInteger originalRoomW;
@property (nonatomic) NSInteger originalRoomL;


@end


@implementation TPCStateManager

@synthesize savedRooms = _savedRooms;

+(instancetype)currentState {
    static TPCStateManager *staticState = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        staticState = [[self alloc]init];
    });
    
    return staticState;
    
}

-(void)checkIfRoomHasChanged:(TPCRoom *)originalRoom {
    if (!(self.room.width == self.originalRoomW)||!(self.room.length == self.originalRoomL)){
        self.roomHasChanged = YES;
        self.originalRoomW = self.room.width;
        self.originalRoomL = self.room.length;
    }
    else {
        self.roomHasChanged = NO;
    }
    
}

-(TPCRoom *)setRoomOfWidth:(NSUInteger)w
               height:(NSUInteger)h
               length:(NSUInteger)l; {
    
        TPCRoom *newRoom = [TPCRoom roomOfWidth:w*12 height:h*12 length:l*12];
        self.originalRoomL=newRoom.length;
        self.originalRoomW=newRoom.width;
        self.roomHasChanged=NO;

    return newRoom;

}



-(void)placeFuriniture:(TPCFurniture *)furniturePiece {

    if (!self.room.savedFurniture) {
        self.room.savedFurniture = [NSArray<TPCFurniture *> new];

    }
    
    furniturePiece.scale = [self scaleFurniture:furniturePiece inRoom:self.room];
    furniturePiece.horizontalDistanceFromOrigin = self.room.width / 2;
    furniturePiece.verticalDistanceFromOrigin = self.room.length / 2;
    furniturePiece.hasScaled=NO;
    furniturePiece.hasMoved=NO;

    NSMutableArray *arrangedFurniture = [self.room.savedFurniture mutableCopy];
    [arrangedFurniture addObject:furniturePiece];
    self.room.savedFurniture = arrangedFurniture;
    
}
    

-(CGFloat)scaleFurniture:(TPCFurniture *)furniturePiece inRoom:(TPCRoom *)room {
    furniturePiece.widthScale = room.width*12 / furniturePiece.width;
    furniturePiece.lengthScale = room.length*12 / furniturePiece.length;

    
    return MIN(furniturePiece.widthScale,furniturePiece.lengthScale);
}

    
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {

            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - Core Data stack


- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.sqlite"];
    
    NSError *error = nil;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

#pragma mark - Application's Documents directory


- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(NSArray<TPCRoom *> *)savedRooms {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TPCRoom"];
    
    request.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES] ];
    
    _savedRooms = [self.managedObjectContext executeFetchRequest:request
                                                                error:nil];
    

    return _savedRooms;
}

-(void)setSavedRooms:(NSArray<TPCRoom *> *)savedRooms {
    _savedRooms = savedRooms;
    [self saveContext];
}

@end
