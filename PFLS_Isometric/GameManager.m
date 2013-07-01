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
@synthesize isControllerEnabled;
@synthesize isTouchEnabled;

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

-(void) startGameWithControlOptions:(BOOL) isTouchOn{

    [[CCDirector sharedDirector] runWithScene:[IntroLayer scene]];
    if (isTouchOn) {
        self.isTouchEnabled = YES;
        NSLog(@"Touch is on.");
    }
    else{
        self.isControllerEnabled = YES;
        NSLog(@"Controllers are on.");
    }
}

-(void) runLevelWithID:(unsigned) theID
{
    CCScene * gameLevel;
    
    switch (theID)
    {
        case kTEST_LEVEL_ID:
            gameLevel = [TestLevelLayer sceneWithCustomControls:self.isTouchEnabled];
            break;
            
        default:
            NSAssert(NO, @"Invalid level id");
            break;
    }
    
    if (gameLevel) [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5f scene:gameLevel withColor:ccWHITE]];
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
