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
}

@property (readonly,retain) GameManagerViewController * viewController;
@property (readonly, assign) GameLevel * currentLevel;

+(GameManager *)sharedManager;

-(UIViewController *) startCocos2d;

-(void) startGame;

-(void) runLevelWithID:(unsigned) theID;

@end
