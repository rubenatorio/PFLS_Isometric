//
//  TestLevelLayer.m
//  PFLS_Isometric
//
//  Created by Ruben Flores on 5/22/13.
//  Copyright 2013 InvariantStudios. All rights reserved.
//

#import "TestLevelLayer.h"
#import "Player.h"


@implementation TestLevelLayer


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
	if( (self = [super initWithMapFile:kTEST_LEVEL_MAP_NAME]) )
    {
        /* PLAYER TEST */
                
        player = [Player createPlayerAtTileCoordinate:ccp(4,4) withOwner:self];
                
        [self.map addChild:player];
                
        /* Get updated everytime a frame is to be rendered */
        [self scheduleUpdate];
    }
    
    return self;
}

-(void) update:(ccTime) deltaTime
{

}

#pragma mark CCTouchDispatcherDelegate Methods


-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    /* Override for custom behavior */
    return [super ccTouchBegan:touch withEvent:event];
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    /* Override for custom behavior */
    [super ccTouchMoved:touch withEvent:event];
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
        
        [player moveToTile:tileCoord];
    }
    
    /* Reset flag for next touch session */
    self.mapDragged = NO;
}

#pragma mark Memory Management

-(void) dealloc
{
    [super dealloc];
}


@end
