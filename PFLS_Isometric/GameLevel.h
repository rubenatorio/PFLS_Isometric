//
//  GameLevel.h
//  PFLS_Isometric
//
//  Created by Ruben Flores on 6/7/13.
//  Copyright 2013 Invariant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameLevelDelegate.h"


/* Main Abstract class that all game levels should inherit from
   The custom initializer in this class sets up all the inherited instance variables
   NOTE: this class requires the mapName string to have the .TMX extension and the custom
         initializer assumes that the ground layer inside the tmx map will be called "floor" 
 
   This class also handles basic user input, allowing the register touches only if they are inside
   the board, and allows the map to be dragged while staying inside the bounds of the screen.
   The ccTouches began, moved and ended methods should be overriden if a different control scheme is desired
 */

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

@property (nonatomic, retain) id<GameLevelDelegate> delegate;


/* Initialize all instance properties with the given map file */
-(id) initWithMapFile:(NSString *) mapFile;

/* Takes in a UI point and converts it to map coordinates with the scrolling of the map */
-(CGPoint) convertToMapCoordinate:(CGPoint) coordintate;

@end
