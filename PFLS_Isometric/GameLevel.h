//
//  GameLevel.h
//  PFLS_Isometric
//
//  Created by Ruben Flores on 6/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameLevel : CCLayer

/* Holds the name of the TMX file containing the map data */
@property (nonatomic, retain) NSString * mapName;
/* Object that contains all of the TXM tile and data */
@property (nonatomic, retain) CCTMXTiledMap * map;
/* Points to the main layer of the map, consists of only floor tiles */
@property (nonatomic, retain) CCTMXLayer * groundLayer;
/* Flag to let layer know if the map was dragged during a touch */
@property (nonatomic, assign) BOOL mapDragged;
/* stores the previous location where user touched to account for when scrolling the map */
@property (nonatomic, assign) CGPoint previousTouchLocation;

-(CGPoint) convertToMapCoordinate:(CGPoint) coordintate;

@end
