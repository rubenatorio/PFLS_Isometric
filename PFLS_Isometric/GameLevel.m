//
//  GameLevel.m
//  PFLS_Isometric
//
//  Created by Ruben Flores on 6/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameLevel.h"

@implementation GameLevel

@synthesize mapName;
@synthesize map;
@synthesize groundLayer;
@synthesize mapDragged;
@synthesize previousTouchLocation;

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
    [super dealloc];
}


@end
