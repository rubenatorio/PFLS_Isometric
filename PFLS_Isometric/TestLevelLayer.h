//
//  TestLevelLayer.h
//  PFLS_Isometric
//
//  Created by Ruben Flores on 5/22/13.
//  Copyright 2013 InvariantStudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameLevel.h"
#import "IsometricCoordinateConverter.h"
#import "GameConstants.h"
#import "GameTypes.h"
#import "Player.h"
#import "SneakyButton.h"


@interface TestLevelLayer : GameLevel
{
    TileDirection currentTouchDirection;
    CCTMXLayer * barrierLayer;
    SneakyButton *attackController;
    SneakyButton *movementController;

}

/* Used to test collisions */
@property (nonatomic, assign) Player * player;


/* Returns a scene for the CCDirector to run */
+(CCScene *) sceneWithCustomControls:(BOOL) isTouch;
+(CCScene *) scene;

-(TileDirection) tileDirectionFromTile:(CGPoint) tileCoor;
-(id) initWithCustomControls:(BOOL) isTouch;

@end
