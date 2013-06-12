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
        barrierLayer = [self.map layerNamed:kBARRIERS_LAYER];
        
        /* PLAYER TEST */
        
//        CCTMXObjectGroup *positions = [self.map objectGroupNamed:@"StartingPosition"];
//        NSAssert(positions, @"No initial position set");
//        
//        NSDictionary * startPoint = [positions objectNamed:@"Start"];
//        
//        CCLOG(@"Start Tile <%@,%@>",startPoint[@"TileX"], startPoint[@"TileY"]);
//        
//        CGPoint startTile = ccp([startPoint[@"TileX"] integerValue], [startPoint[@"TileY"] integerValue]);
        
        player = [Player createPlayerAtTileCoordinate:ccp(5,5) withOwner:self];
                
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
    return  [super ccTouchBegan:touch withEvent:event];
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
                
        currentTouchDirection = [self tileDirectionFromTile:tileCoord];
        
        //[player moveToTile:tileCoord];
        [self processTileMovement:tileCoord];
    }
    
    /* Reset flag for next touch session */
    self.mapDragged = NO;
}

-(TileDirection) tileDirectionFromTile:(CGPoint) tileCoor
{
    CGPoint playerTile = [IsometricCoordinateConverter tilePosFromLocation:[player position] tileMap:self.map];
    
    CGPoint delta = ccpSub(tileCoor, playerTile);
    
    if(delta.x == 0) return (delta.y > 0) ? southWest : northEast;
    
    else if (delta.y == 0) return (delta.x > 0) ? southEast : northWest;
    
    return noDirection;
}

-(void) processTileMovement:(CGPoint) tileDestinaton
{
    NSAssert(barrierLayer, @"No barriers specified");
    
    CGPoint startingPosition = [IsometricCoordinateConverter tilePosFromLocation:[player position] tileMap:self.map];
    CGPoint currentPosition;
    
    switch (currentTouchDirection) {
        case northWest:
        {
            CCLOG(@"NW");
            currentPosition = startingPosition;
            for(int i = startingPosition.x - 1; i >= tileDestinaton.x; --i)
            {
                CGPoint nextTile = ccp(i, startingPosition.y);
                
                int groundGID = [self.groundLayer tileGIDAt:nextTile];
                int barrierGID = [barrierLayer tileGIDAt:nextTile];
                if(groundGID == 0 || barrierGID != 0) //cannot move there
                {
                    //can only move to the current position
                    [player moveToTile:currentPosition];
                    return;
                }
                currentPosition = nextTile;
            }
            [player moveToTile:currentPosition];
            break;
        }
        case northEast:
        {
            CCLOG(@"NE");
            currentPosition = startingPosition;
            for(int i = startingPosition.y - 1; i >= tileDestinaton.y; --i)
            {
                CGPoint nextTile = ccp(startingPosition.x, i);
                
                int groundGID = [self.groundLayer tileGIDAt:nextTile];
                int barrierGID = [barrierLayer tileGIDAt:nextTile];
                if(groundGID == 0 || barrierGID != 0) //cannot move there
                {
                    //can only move to the current position
                    [player moveToTile:currentPosition];
                    return;
                }
                currentPosition = nextTile;
            }
            [player moveToTile:currentPosition];
            break;
        }
        case southWest:
        {
            CCLOG(@"SW");
            currentPosition = startingPosition;
            for(int i = startingPosition.y + 1; i <= tileDestinaton.y; ++i)
            {
                CGPoint nextTile = ccp(startingPosition.x, i);
                
                int groundGID = [self.groundLayer tileGIDAt:nextTile];
                int barrierGID = [barrierLayer tileGIDAt:nextTile];
                if(groundGID == 0 || barrierGID != 0) //cannot move there
                {
                    //can only move to the current position
                    [player moveToTile:currentPosition];
                    return;
                }
                currentPosition = nextTile;
            }
            [player moveToTile:currentPosition];
            break;
        }
        case southEast:
        {
            CCLOG(@"SE");
            currentPosition = startingPosition;
            for(int i = startingPosition.x + 1; i <= tileDestinaton.x; ++i)
            {
                CGPoint nextTile = ccp(i, startingPosition.y);
                
                int groundGID = [self.groundLayer tileGIDAt:nextTile];
                int barrierGID = [barrierLayer tileGIDAt:nextTile];
                if(groundGID == 0 || barrierGID != 0) //cannot move there
                {
                    //can only move to the current position
                    [player moveToTile:currentPosition];
                    return;
                }
                currentPosition = nextTile;
            }
            [player moveToTile:currentPosition];
            break;
        }
        default:
            break;
    }
}

#pragma mark Memory Management

-(void) dealloc
{
    [super dealloc];
}


@end
