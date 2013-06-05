//
//  TestLevelLayer.m
//  PFLS_Isometric
//
//  Created by Ruben Flores on 5/22/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "TestLevelLayer.h"
#import "Player.h"


@implementation TestLevelLayer

@synthesize map, groundLayer, barriers;
@synthesize previousTouchLocation, mapDragged;
@synthesize player;


+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	TestLevelLayer *layer = [TestLevelLayer node];
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	if( (self=[super init]) )
    {
        
        /* Make sure we can register user input */
        self.isTouchEnabled = YES;
        
        /* Flag needed to normalize the map's position against scrolling */
        self.mapDragged = NO;
        
        /* Load map from TMX file and obtain the layers from the map */
        self.map = [CCTMXTiledMap tiledMapWithTMXFile:kTEST_LEVEL_MAP_NAME];
        self.groundLayer = [map layerNamed:@"floor"];
        self.barriers = [map layerNamed:@"edges"];
        
        /* Center the screen on the map */
        [IsometricCoordinateConverter centerTileMapOnTileCoord:CGPointMake(4,4) tileMap:map];
        
        /* Add the map to our view */
        [self addChild:map];
        
        /* PLAYER TEST */
                
        player = [Player createPlayerAtTileCoordinate:ccp(4,4) withOwner:self];
                
        [map addChild:player];
        
        /*---------------------------------*/
                
        /* Get updated everytime a frame is to be rendered */
        //[self scheduleUpdate];
    }
    
    return self;
}

-(void) update:(ccTime) deltaTime
{

}

#pragma mark CCTouchDispatcherDelegate Methods

/* HANDLE USER INTERACTION */

-(void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:kLEVEL_LAYER_PRIORITY
                                                       swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    /* Save the touch's location incase user drags map */
    previousTouchLocation = [touch locationInView:touch.view];
    
    previousTouchLocation = [[CCDirector sharedDirector] convertToGL:previousTouchLocation];
    
	return YES;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    /* Normalize the UI cordinate to the map's current position */
    CGPoint touchlocation = [self convertToMapCoordinate:[touch locationInView:touch.view]];

    /* Make sure that the user tapped inside the board and that scrolling is not happening */
    if ([IsometricCoordinateConverter isPoint:touchlocation outOfBoundsOnMap:map] && !mapDragged)
    {
        /* DEBUG */
        CGPoint tileCoord = [IsometricCoordinateConverter tilePosFromLocation:touchlocation tileMap:map];
        CGPoint pixLoc = [IsometricCoordinateConverter pixelCoordForTile:tileCoord onLayer:groundLayer];
    
        CCLOG(@"Tile coord: < %d , %d >", (int)tileCoord.x, (int)tileCoord.y);
        CCLOG(@"Tile pix coord: < %.2f , %.2f >", pixLoc.x, pixLoc.y);
        /*----------------*/
        
        [player moveToTile:tileCoord];
    }
    
    /* Reset flag for next touch session */
    mapDragged = NO;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    /* Prevents player movement while scrolling is happening */
    mapDragged = YES;
    
    CGPoint desiredMapLocation = [map position];
    
    /* Obtain the touch location in GL coordinates */
    CGPoint touchlocation = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]];
    
    /* The distance dragged since last touch */
    CGPoint delta = ccpSub(touchlocation, previousTouchLocation);
    
    /* desired map location after scrolling */
    desiredMapLocation = ccpAdd(desiredMapLocation, delta);
    
    /* Make sure the map stays within the screen's bounds */
    if(![IsometricCoordinateConverter isMapWithinBounds:map atPosition:desiredMapLocation]) return;
    
    /* If the scrolling is valid update map's position */
    [map setPosition:desiredMapLocation];
    
    previousTouchLocation = touchlocation;
}

-(CGPoint) convertToMapCoordinate:(CGPoint) coordintate
{
    coordintate = [[CCDirector sharedDirector] convertToGL:coordintate];
    
    coordintate = [self convertToNodeSpace:coordintate];
    
    /* Account for map scrolling */
    coordintate = ccpSub(coordintate, map.position);
    
    return coordintate;
}

#pragma mark Memory Management

-(void) dealloc
{
    [map release];
    [groundLayer release];
    [barriers release];
    [super dealloc];
}


@end
