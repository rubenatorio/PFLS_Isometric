//
//  IntroLayer.h
//  PFLS_Isometric
//
//  Created by Ruben Flores on 5/22/13.
//  Copyright InvariantStudios 2013. All rights reserved.

#import "cocos2d.h"

@interface IntroLayer : CCLayer

@property (nonatomic, assign) CCScene * transitionScene;

+(CCScene *) scene;
+(CCScene *) sceneWithTransition:(CCScene *) theScene;

-(void) doTransition:(CCScene *)scene;

@end
