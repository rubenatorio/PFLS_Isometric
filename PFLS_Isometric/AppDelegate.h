//
//  AppDelegate.h
//  PFLS_Isometric
//
//  Created by Ruben Flores on 5/22/13.
//  Copyright InvariantStudios 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "GameManager.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	* director_;							// weak ref
    GameManager * manager_;
    
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
