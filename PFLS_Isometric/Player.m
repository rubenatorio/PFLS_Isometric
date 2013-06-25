//
//  Player.m
//  PFLS_Isometric
//
//  Created by Ruben Flores on 5/23/13.
//  Copyright 2013 InvariantStudios. All rights reserved.

#import "Player.h"
#import "TestLevelLayer.h"
#import "GameConstants.h"


@implementation Player

@synthesize  owner;
//@synthesize currentTile;

+(Player *) createPlayerAtTileCoordinate:(CGPoint) tileCoordinate withOwner:(CCLayer *) theOwner
{
    Player * player = [[self alloc] initWithFile:@"Invader2.png"];
    
    [player setOwner:theOwner];
    
//    player.currentTile = tileCoordinate;
    
    TestLevelLayer * layer = (TestLevelLayer *) theOwner;
    
    CGPoint playerPosition = [IsometricCoordinateConverter pixelCoordForTile:tileCoordinate onLayer:layer.groundLayer];
    
    [player setPosition:playerPosition];
    
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:player
                                                              priority:kPLAYER_PRIORITY
                                                       swallowsTouches:YES];
    return player;
}


-(void) moveToTile:(CGPoint) tileCoordinate
{
    TestLevelLayer * layer = (TestLevelLayer *) owner;
    
    CGSize size = [layer.groundLayer layerSize];
    
    if(tileCoordinate.x < 0 || tileCoordinate.y < 0 || tileCoordinate.x >= size.width || tileCoordinate.y >= size.height) return;
    
    [self stopAllActions];

    CGPoint currentTile = [IsometricCoordinateConverter tilePosFromLocation:self.position tileMap:layer.map];
    CGPoint tiles = ccpSub(tileCoordinate , currentTile);
    
    float duration = (fabsf(tiles.x) + fabsf(tiles.y)) * kTILE_MOVEMENT_SPEED;
        
    if((tiles.x == 0 || tiles.y == 0) && [layer.groundLayer tileGIDAt:tileCoordinate] != 0)
    {
        CGPoint currentPos = [self position];
        CGPoint nextPos = [IsometricCoordinateConverter pixelCoordForTile:tileCoordinate onLayer:layer.groundLayer];
        CGPoint delta = ccpSub(nextPos, currentPos);
        id moveBy = [CCMoveBy actionWithDuration:duration position:delta];
        [self runAction:moveBy];
//        self.currentTile = tileCoordinate;
    }
}

#pragma  mark CCTargetedTouchDelegate Methods

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{    
        TestLevelLayer * layer = (TestLevelLayer *) owner;
    
        CGPoint touchLocationInView = [touch locationInView:touch.view];
    
        CGPoint touchLocation = [layer convertToMapCoordinate:touchLocationInView];
    
        if(CGRectContainsPoint(self.boundingBox, touchLocation))
        {
//            CGPoint tileCoord = [IsometricCoordinateConverter tilePosFromLocation:touchLocation tileMap:layer.map];
//            CGPoint pixLoc = [IsometricCoordinateConverter pixelCoordForTile:tileCoord onLayer:layer.groundLayer];
//            CGPoint playerTile = [IsometricCoordinateConverter tilePosFromLocation:self.position tileMap:layer.map];
//            
//            CCLOG(@"-----------PLAYER-----------");
//            CCLOG(@"Tile coord: < %d , %d >", (int)tileCoord.x, (int)tileCoord.y);
//            CCLOG(@"Tile pix coord: < %.2f , %.2f >", pixLoc.x, pixLoc.y);
//            CCLOG(@"Player Pos: <%.2f , %.2f>", self.position.x, self.position.y);
//            CCLOG(@"Player Tile coord: < %d , %d >", (int)playerTile.x, (int)playerTile.y);
            CCLOG(@"Player Tapped!");
 //           CCLOG(@"Tile coord: < %d , %d >", (int)currentTile.x, (int)currentTile.y);
            return YES;
        }
    
    return NO;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{

}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{

}


@end
