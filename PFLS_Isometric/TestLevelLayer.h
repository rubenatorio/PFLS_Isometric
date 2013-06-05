//
//  TestLevelLayer.h
//  PFLS_Isometric
//
//  Created by Ruben Flores on 5/22/13.
//  Copyright 2013 InvariantStudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "IsometricCoordinateConverter.h"
#import "GameConstants.h"
#import "Player.h"

@interface TestLevelLayer : CCLayer

/* Object that contains all of the TXM tile and data */
@property (nonatomic, retain) CCTMXTiledMap * map;
/* Points to the main layer of the map, consists of only floor tiles */
@property (nonatomic, retain) CCTMXLayer * groundLayer;
/* This layer constains only collidable tiles */
@property (nonatomic, retain) CCTMXLayer * barriers;

/* Used to test collisions */
@property (nonatomic, assign) Player * player;
/* Flag to let layer know if the map was dragged during a touch */
@property (nonatomic, assign) BOOL mapDragged;
/* stores the previous location where user touched to account for when scrolling the map */
@property (nonatomic, assign) CGPoint previousTouchLocation;

/* Returns a scene for the CCDirector to run */
+(CCScene *) scene;

/* Takes in a UI point and converts it to map coordinates with the scrolling of the map */
-(CGPoint) convertToMapCoordinate:(CGPoint) coordintate;

@end
