//
//  GameManagerViewController.h
//  PFLS_Isometric
//
//  Created by Ruben Flores on 6/5/13.
//
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"


@interface GameManagerViewController : UIViewController
{
    CCGLView * _glView;
}

-(void) startCocos2d;

@end
