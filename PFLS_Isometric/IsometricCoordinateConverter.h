//
//  IsometricCoordinateConverter.h
//  PFLS_Isometric
//
//  Created by Ruben Flores on 5/22/13.

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface IsometricCoordinateConverter : NSObject

+(CGPoint) tilePosFromLocation:(CGPoint)location tileMap:(CCTMXTiledMap*)tileMap;
+(CGPoint) pixelCoordForTile:(CGPoint) tileCoord onLayer:(CCTMXLayer *) layer;

+(void) updateMapCoord:(CGPoint)tilePos tileMap:(CCTMXTiledMap*)tileMap;
+(void) centerTileMapOnTileCoord:(CGPoint)tilePos tileMap:(CCTMXTiledMap*)tileMap;

+(BOOL) isPoint:(CGPoint) point outOfBoundsOnMap:(CCTMXTiledMap *) tileMap;
+(BOOL) isMapWithinBounds:(CCTMXTiledMap *) tileMap atPosition:(CGPoint) nextPosition;

@end
