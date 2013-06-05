//
//  Player.h
//  PFLS_Isometric
//
//  Created by Ruben Flores on 5/23/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Player : CCSprite <CCTargetedTouchDelegate>

/* Points to the layer containing this object, used for coordinate translation */
@property (nonatomic, assign) CCLayer * owner;

/* Create a player at the given tile coordinate, owner is needed to access map layers to translate coordinates */
+(Player *) createPlayerAtTileCoordinate:(CGPoint) tileCoordinate withOwner:(CCLayer *) theOwner;

/* Move the player to the selected tile, the velocity is set in the GameConstants.h
   NOTE: This method needs an isometric coordinate as its parameter */
-(void) moveToTile:(CGPoint) tileCoordinate;

@end
