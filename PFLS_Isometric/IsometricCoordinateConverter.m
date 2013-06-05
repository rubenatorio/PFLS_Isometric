//
//  IsometricCoordinateConverter.m
//  PFLS_Isometric
//
//  Created by Ruben Flores on 5/22/13.


#import "IsometricCoordinateConverter.h"

@implementation IsometricCoordinateConverter

/* Given a point on the screen, this method returns the tile containing the point
 * in the given map. This mathod will return coordinates that are outside the map. */
+(CGPoint) tilePosFromLocation:(CGPoint)location tileMap:(CCTMXTiledMap*)tileMap
{
    // Tilemap position must be subtracted, in case the tilemap position is scrolling
    //CGPoint pos = ccpSub(location, tileMap.position); moved to layer converttomapcoordinate
    
    float halfMapWidth = tileMap.mapSize.width * 0.5f;
    float mapHeight = tileMap.mapSize.height;
    float tileWidth = tileMap.tileSize.width;
    float tileHeight = tileMap.tileSize.height;
    
    CGPoint tilePosDiv = CGPointMake(location.x / tileWidth, location.y / tileHeight);
    
    float inverseTileY = mapHeight - tilePosDiv.y;
    
    // Cast to int makes sure that result is in whole numbers
    float posX = (int)(inverseTileY + tilePosDiv.x - halfMapWidth);
    float posY = (int)(inverseTileY - tilePosDiv.x + halfMapWidth);
    
    return CGPointMake(posX, posY);
}

/* Given a tile coordinate from the given layer on the map, this method returns the location on the screen
 * of that coordinate */
+(CGPoint) pixelCoordForTile:(CGPoint) tileCoord onLayer:(CCTMXLayer *) layer
{
    
    CGPoint offset = ccp(layer.mapTileSize.width * 0.5f, layer.mapTileSize.height * 0.5f);
        
    return ccpAdd([layer positionAt:tileCoord], offset);
}

+(void) centerTileMapOnTileCoord:(CGPoint)tilePos tileMap:(CCTMXTiledMap*)tileMap
{
    // center tilemap on the given tile pos
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGPoint screenCenter = CGPointMake(screenSize.width * 0.5f,
                                       screenSize.height * 0.5f);
    
    // get the ground layer
    CCTMXLayer* layer = [tileMap layerNamed:@"floor"];
    NSAssert(layer != nil, @"Ground layer not found!");
    
    // internally tile Y coordinates are off by 1
    tilePos.y -= 1;
    
    // get the pixel coordinates for a tile at these coordinates
    CGPoint scrollPosition = [layer positionAt:tilePos];
    
    // negate the position to account for scrolling
    scrollPosition = ccpMult(scrollPosition, -1);
    
    // add offset to screen center
    scrollPosition = ccpAdd(scrollPosition, screenCenter);
    
//    // move the tilemap
//    CCAction* move = [CCMoveTo actionWithDuration:0.2f position:scrollPosition];
//    [tileMap stopAllActions];
//    [tileMap runAction:move];
    [tileMap setPosition:scrollPosition];
}

+(void) updateMapCoord:(CGPoint)tilePos tileMap:(CCTMXTiledMap*)tileMap
{
    // center tilemap on the given tile pos
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGPoint screenCenter = CGPointMake(screenSize.width * 0.5f,
                                       screenSize.height * 0.5f);
    
    // get the ground layer
    CCTMXLayer* layer = [tileMap layerNamed:@"floor"];
    NSAssert(layer != nil, @"Ground layer not found!");
    
    // internally tile Y coordinates are off by 1
    tilePos.y -= 1;
    
    // get the pixel coordinates for a tile at these coordinates
    CGPoint scrollPosition = [layer positionAt:tilePos];
    
    // negate the position to account for scrolling
    scrollPosition = ccpMult(scrollPosition, -1);
    
    // add offset to screen center
    scrollPosition = ccpAdd(scrollPosition, screenCenter);
    
    // move the tilemap
    [tileMap setPosition:scrollPosition];
}

+(BOOL) isPoint:(CGPoint) point outOfBoundsOnMap:(CCTMXTiledMap *) tileMap;
{
    CGPoint currentTile = [IsometricCoordinateConverter tilePosFromLocation:point tileMap:tileMap];
    
    return (currentTile.x < 0 ||
            currentTile.x > tileMap.mapSize.width ||
            currentTile.y < 0 ||
            currentTile.y > tileMap.mapSize.height) ? NO : YES;
}

+(BOOL) isMapWithinBounds:(CCTMXTiledMap *) tileMap atPosition:(CGPoint) nextPosition
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    float mapWidth = tileMap.mapSize.width * tileMap.tileSize.width;
    float mapHeight = tileMap.mapSize.height * tileMap.tileSize.height;
    
    float xOffset = (mapWidth - screenSize.width) * -1.0;
    float yOffset = fabsf(mapHeight - screenSize.height);
    
    /* There are 2 cases, if the map is bigger in height than the screen and if its not */
    BOOL yOK;
    
    if (mapHeight > screenSize.height)
        yOK = (nextPosition.y <= (yOffset * -1.0f) || nextPosition.y > 0) ? YES : NO;
    else
        yOK = (nextPosition.y < 0 || nextPosition.y > yOffset) ? YES : NO;
    
    
    return  (nextPosition.x <= xOffset || nextPosition.x > 0 || yOK) ? NO : YES;
}

@end
