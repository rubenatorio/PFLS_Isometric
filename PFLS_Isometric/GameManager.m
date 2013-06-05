//
//  GameManager.m
//  PFLS_Isometric
//
//  Created by Ruben Flores on 6/5/13.
//
//

#import "GameManager.h"
#import "GameManagerViewController.h"

@implementation GameManager

@synthesize viewController = _viewController;

static GameManager * _gameManager = nil;

+(GameManager *)sharedManager
{
    if (!_gameManager) _gameManager = [[self alloc] init];
    
    return _gameManager;
}

-(UIViewController *) startCocos2d
{
    NSAssert(_viewController == nil, @"Cocos2d already set up!");
    
    NSLog(@"Initializing Cocos2d Director and GL View");
    
    _viewController = [[GameManagerViewController alloc] initWithNibName:nil bundle:nil];
    
    [_viewController startCocos2d];
    
    return _viewController;
}

#pragma mark Memory Management

+(id)alloc
{
    NSAssert(_gameManager == nil, @"Cannot instantiate game manager twice!");
    NSLog(@"Game Manager Instantiated"); 
    return [super alloc];
}

-(void) dealloc
{
    [_viewController release];
    [super dealloc];
}
@end
