//
//  GameManager.m
//  PFLS_Isometric
//
//  Created by Ruben Flores on 6/5/13.

#import "GameManager.h"
#import "GameManagerViewController.h"
#import "GameConstants.h"
#import "TestLevelLayer.h"
#import "IntroLayer.h"

@implementation GameManager

@synthesize viewController = _viewController;
@synthesize currentLevel;

static GameManager * _gameManager = nil;

+(GameManager *) sharedManager
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

-(void) startGame
{
    _currentLevelIndex = 0;
    
    [self runLevel];
}

-(void) loadLevels
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"GameLevels" ofType:@"plist"];
    
    _gameLevels = [NSArray arrayWithContentsOfFile:path];
    
    NSLog(@"%@", _gameLevels);
}

-(void) runLevel
{
    NSAssert(_currentLevelIndex < [_gameLevels count], @"level index out of bouds");
    
    NSDictionary * levelConfig = [_gameLevels objectAtIndex:_currentLevelIndex];
    
    NSString * mapName = [levelConfig objectForKey:@"MapName"];
    
    NSAssert(mapName != nil, @"Done goofed the plist key");
    
    _currentLevel = [[[TestLevelLayer alloc] initWithMapFile:mapName] autorelease];
    
    CCScene * levelScene = [CCScene node];
    
    [levelScene addChild:_currentLevel];
    
    [[CCDirector sharedDirector] runWithScene:levelScene]; //display the load screen
}

-(UIViewController *) setUpGame
{
   [self loadLevels];
    
   UIViewController * gameView =  [self startCocos2d];
    
   [self startGame];
    
   return gameView;
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
