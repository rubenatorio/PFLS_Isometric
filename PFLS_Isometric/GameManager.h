//
//  GameManager.h
//  PFLS_Isometric
//
//  Created by Ruben Flores on 6/5/13.
//
//

#import <Foundation/Foundation.h>

@class  GameManagerViewController;

@interface GameManager : NSObject
{
    GameManagerViewController * _viewController;
}

@property (readonly,retain) GameManagerViewController * viewController;

+(GameManager *)sharedManager;

-(UIViewController *) startCocos2d;

@end
