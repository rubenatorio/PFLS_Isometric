//
//  GameManager.h
//  PFLS_Isometric
//
//  Created by Ruben Flores on 6/5/13.

#import <Foundation/Foundation.h>
#import "GameLevel.h"
#import "GameLevelDelegate.h"

@class  GameManagerViewController;

@interface GameManager : NSObject <GameLevelDelegate>
{
    GameManagerViewController * _viewController;
    GameLevel * _currentLevel;
    NSArray * _gameLevels;
    int _currentLevelIndex;
}

@property (retain) GameManagerViewController * viewController;
@property (readonly) GameLevel * currentLevel;

+(GameManager *)sharedManager;

-(UIViewController *) setUpGame;

@end
