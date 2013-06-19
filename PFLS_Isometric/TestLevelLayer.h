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

@interface TestLevelLayer : GameLevel
{
    TileDirection currentTouchDirection;
    CCTMXLayer * barrierLayer;
}

/* Used to test collisions */
@property (nonatomic, assign) Player * player;

+(CCScene *) sceneWithMapFile:(NSString *) mapName;

-(TileDirection) tileDirectionFromTile:(CGPoint) tileCoor;

-(id) initWithMapFile:(NSString *)mapFile;

@end
