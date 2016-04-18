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
//<<<<<<< HEAD
//@property (strong, nonatomic, readwrite) TPCRoom *room;
//@property (strong, nonatomic, readwrite) NSMutableArray<TPCFurniture *> *arrangedFurniture;
//=======
//@property (strong, nonatomic, readwrite) TPCRoom *room;
//@property (strong, nonatomic) NSMutableArray<TPCFurniture *> *arrangedFurniture;
//>>>>>>> master
@property (nonatomic) NSUInteger originalRoomW;
@property (nonatomic) NSUInteger originalRoomL;


@end


@implementation TPCStateManager

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
//<<<<<<< HEAD
//    if (!self.room) {
//        self.room = [TPCRoom roomOfWidth:w*12 height:h*12 length:l*12];
//    }
//    else {
//        self.room.width = w;
//        self.room.height = h;
//        self.room.length = l;
//    }
//    
//    self.originalRoomL = self.room.length;
//    self.originalRoomW = self.room.width;
//    self.roomHasChanged = NO;
//=======
    
        TPCRoom *newRoom = [TPCRoom roomOfWidth:w*12 height:h*12 length:l*12];
        self.originalRoomL=newRoom.length;
        self.originalRoomW=newRoom.width;
        self.roomHasChanged=NO;

    return newRoom;
//>>>>>>> master
}



-(void)placeFuriniture:(TPCFurniture *)furniturePiece {
//<<<<<<< HEAD
    if (!self.room.savedFurniture) {
        self.room.savedFurniture = [NSArray<TPCFurniture *> new];
//=======
//
//    if (!self.room.savedFurniture) {
//        self.room.savedFurniture = [NSMutableArray<TPCFurniture *> new];
//>>>>>>> master
    }
    
    furniturePiece.scale = [self scaleFurniture:furniturePiece inRoom:self.room];
    furniturePiece.horizontalDistanceFromOrigin = self.room.width / 2;
    furniturePiece.verticalDistanceFromOrigin = self.room.length / 2;
    furniturePiece.hasScaled=NO;
    furniturePiece.hasMoved=NO;
//<<<<<<< HEAD
    NSMutableArray *arrangedFurniture = [self.room.savedFurniture mutableCopy];
    [arrangedFurniture addObject:furniturePiece];
    self.room.savedFurniture = arrangedFurniture;
    
}
    

-(CGFloat)scaleFurniture:(TPCFurniture *)furniturePiece inRoom:(TPCRoom *)room {
    furniturePiece.widthScale = room.width*12 / furniturePiece.width;
    furniturePiece.lengthScale = room.length*12 / furniturePiece.length;
    //    CGFloat heightScale = room.h / furniturePiece.height;
    
    return MIN(furniturePiece.widthScale,furniturePiece.lengthScale);
}

    
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
//=======
//    [self.room.savedFurniture addObject:furniturePiece];
//}
//>>>>>>> master

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
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

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)doSomethingWithRoom:(TPCRoom *)room {
    [self saveContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TPCRoom"];
    self.savedRooms = [[self.managedObjectContext executeFetchRequest:request
                                                                error:nil] mutableCopy];
    
    
}

@end
