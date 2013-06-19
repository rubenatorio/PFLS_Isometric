//
//  GameManager.h
//  PFLS_Isometric
//
//  Created by Ruben Flores on 6/5/13.

#import <Foundation/Foundation.h>
#import "GameLevel.h"

@class  GameManagerViewController;

@interface GameManager : NSObject
{
    GameManagerViewController * _viewController;
    GameLevel * _currentLevel;
    NSArray * _gameLevels;
    int _currentLevelIndex;
}

@property (readonly,retain) GameManagerViewController * viewController;
@property (readonly, assign) GameLevel * currentLevel;

+(GameManager *)sharedManager;

-(void) startGame;

-(UIViewController *) setUpGame;

@end
