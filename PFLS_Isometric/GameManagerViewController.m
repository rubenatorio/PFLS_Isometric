//
//  GameManagerViewController.m
//  PFLS_Isometric
//
//  Created by Ruben Flores on 6/5/13.

#import "GameManagerViewController.h"
#import "IntroLayer.h"
#import "GameManager.h"

@implementation GameManagerViewController

-(void) startCocos2d
{
    // Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
    _glView = [CCGLView viewWithFrame:[[UIScreen mainScreen] bounds]
                                   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
                                   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
                            preserveBackbuffer:NO
                                    sharegroup:nil
                                 multiSampling:NO
                               numberOfSamples:0];
        
    [[CCDirector sharedDirector] setView:_glView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Adding the GL View to the main view...");
    
    //[[GameManager sharedManager] startGame];
    
    [self.view insertSubview:_glView atIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    
    [super viewWillAppear:animated];
}

@end
