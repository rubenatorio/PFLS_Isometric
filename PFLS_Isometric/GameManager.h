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
    CGSize screenSize;
}

@property (readonly,retain) GameManagerViewController * viewController;
@property (readonly, assign) GameLevel * currentLevel;
@property BOOL isTouchEnabled;
@property BOOL isControllerEnabled;

+(GameManager *)sharedManager;

-(UIViewController *) startCocos2d;

-(void) startGameWithControlOptions:(BOOL) isTouchOn;

-(void) runLevelWithID:(unsigned) theID;

@end
