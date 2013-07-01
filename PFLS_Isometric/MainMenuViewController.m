//
//  MainMenuViewController.m
//  PFLS_Isometric
//
//  Created by Ruben Flores on 6/5/13.

#import "LevelMenuViewController.h"
#import "MainMenuViewController.h"
#import "GameManager.h"
#import "OptionMenuViewController.h"

@implementation MainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Force game to be loaded with touch set as default.
    if((![GameManager sharedManager].isTouchEnabled)
       &&
       ![GameManager sharedManager].isControllerEnabled){
        [GameManager sharedManager].isTouchEnabled = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PlayGame:(id)sender
{
    UIViewController *controller = [[GameManager sharedManager] startCocos2d];
   
    [self.navigationController pushViewController: controller animated: YES];
    //[[GameManager sharedManager] startGame];
    
}

- (IBAction)EnterOptions:(id)sender {
    
    OptionMenuViewController *controller = [[OptionMenuViewController alloc] initWithNibName:@"OptionMenuViewController"bundle:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    [controller release];
    
}

- (void)dealloc {
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
