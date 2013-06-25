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
#import "AppDelegate.h"

@implementation GameManager 

@synthesize viewController = _viewController;
@synthesize currentLevel = _currentLevel;

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

-(void) advanceLevel
{
    int nextIndex = _currentLevelIndex + 1;
    
    NSLog(@"%@", _gameLevels);
    
    int levelCount = [_gameLevels count];
    
    if (nextIndex >= levelCount)
    {
        [self gameOver];
        return;
    }
    
    _currentLevelIndex = nextIndex;
    
    [self runLevel];
}

-(void) gameOver
{
    CCLOG(@"********************** GAME OVER ********************************");
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(popToMainMenu) userInfo:nil repeats:NO];
}

-(void) popToMainMenu
{
    AppController * appDelegate = (AppController *) [[UIApplication sharedApplication] delegate];
    
    [appDelegate.navController popToRootViewControllerAnimated:YES];
}

-(void) loadLevels
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"GameLevels" ofType:@"plist"];
    
  //  _gameLevels = [NSArray arrayWithContentsOfFile:path];
    
    _gameLevels = [[NSArray alloc] initWithContentsOfFile:path];
    
    NSLog(@"%@", _gameLevels);
}

-(void) runLevel
{
    NSAssert(_currentLevelIndex < [_gameLevels count] || _currentLevelIndex < 0, @"level index out of bouds");
    
    NSDictionary * levelConfig = [_gameLevels objectAtIndex:_currentLevelIndex];
    
    NSString * mapName = [levelConfig objectForKey:@"MapName"];
    
    NSAssert(mapName != nil, @"Done goofed the plist key");
    
    _currentLevel = [[[TestLevelLayer alloc] initWithMapFile:mapName] autorelease];
    
    [_currentLevel setDelegate:self];
    
    CCScene * levelScene = [CCScene node];
    
    [levelScene addChild:_currentLevel];
    
    if (_currentLevelIndex == 0)
        [[CCDirector sharedDirector] runWithScene:levelScene]; //display the load screen
    else
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:levelScene withColor:ccWHITE]];
}

-(UIViewController *) setUpGame
{
    static BOOL _setUp = NO;
    
   if (_setUp)
       return _viewController;
       
   [self loadLevels];
    
   UIViewController * gameView =  [self startCocos2d];
    
   [self startGame];
    
    _setUp = YES;
    
   return gameView;
}

#pragma mark GameLevelDelegat

-(void) levelDidfinish
{
    CCLOG(@"************************* Level Did Finish ********************");
    [self advanceLevel];
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
