//
//  GameLevel.m
//  PFLS_Isometric
//
//  Created by Ruben Flores on 6/7/13.
//  Copyright 2013 Invariant Studios. All rights reserved.


#import "GameLevel.h"
#import "GameConstants.h"
#import "IsometricCoordinateConverter.h"

@implementation GameLevel

@synthesize mapName;
@synthesize map;
@synthesize groundLayer;
@synthesize mapDragged;
@synthesize previousTouchLocation;

-(id) initWithMapFile:(NSString *)mapFile
{
    if((self = [super init]))
    {
        mapName = mapFile;
        
        /* Flag needed to normalize the map's position against scrolling */
        mapDragged = NO;
        
        /* Load map from TMX file and obtain the layers from the map */
        map = [CCTMXTiledMap tiledMapWithTMXFile:mapName];
        groundLayer = [map layerNamed:kGROUND_LAYER];
        
        /* Make sure we can register user input */
        self.isTouchEnabled = YES;
        
        /* Center the screen on the map */
        
        [IsometricCoordinateConverter centerTileMapOnTileCoord:ccp(4,4) tileMap:self.map];
        
        /* Add the map to our view */
        [self addChild:self.map];
    }
    return self;
}

-(CGPoint) convertToMapCoordinate:(CGPoint) coordintate
{
    coordintate = [[CCDirector sharedDirector] convertToGL:coordintate];
    
    coordintate = [self convertToNodeSpace:coordintate];
    
    /* Account for map scrolling */
    coordintate = ccpSub(coordintate, map.position);
    
    return coordintate;
}


-(void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:kLEVEL_LAYER_PRIORITY
                                                       swallowsTouches:YES];
}

#pragma mark CCTouchDispatcherDelegate Methods

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    /* Save the touch's location incase user drags map */
    self.previousTouchLocation = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]];
    
	return YES;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    /* Normalize the UI cordinate to the map's current position */
    CGPoint touchlocation = [self convertToMapCoordinate:[touch locationInView:touch.view]];
    
    /* Make sure that the user tapped inside the board and that scrolling is not happening */
    if ([IsometricCoordinateConverter isPoint:touchlocation outOfBoundsOnMap:self.map] && !self.mapDragged)
    {
        /* DEBUG */
        CGPoint tileCoord = [IsometricCoordinateConverter tilePosFromLocation:touchlocation tileMap:self.map];
        CGPoint pixLoc = [IsometricCoordinateConverter pixelCoordForTile:tileCoord onLayer:self.groundLayer];
        
        CCLOG(@"Tile coord: < %d , %d >", (int)tileCoord.x, (int)tileCoord.y);
        CCLOG(@"Tile pix coord: < %.2f , %.2f >", pixLoc.x, pixLoc.y);    
    }
    
    /* Reset flag for next touch session */
    self.mapDragged = NO;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    /* Prevents player movement while scrolling is happening */
    self.mapDragged = YES;
    
    CGPoint desiredMapLocation = [self.map position];
    
    /* Obtain the touch location in GL coordinates */
    CGPoint touchlocation = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]];
    
    /* The distance dragged since last touch */
    CGPoint delta = ccpSub(touchlocation, self.previousTouchLocation);
    
    /* desired map location after scrolling */
    desiredMapLocation = ccpAdd(desiredMapLocation, delta);
    
    /* Make sure the map stays within the screen's bounds */
    if(![IsometricCoordinateConverter isMapWithinBounds:self.map atPosition:desiredMapLocation]) return;
    
    /* If the scrolling is valid update map's position */
    [self.map setPosition:desiredMapLocation];
    
    self.previousTouchLocation = touchlocation;
}

#pragma mark Memory Management

-(void) dealloc
{
    [mapName release];
    [map release];
    [groundLayer release];
    [super dealloc];
}


@end
