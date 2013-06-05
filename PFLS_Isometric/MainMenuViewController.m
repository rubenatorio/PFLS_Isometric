//
//  MainMenuViewController.m
//  PFLS_Isometric
//
//  Created by Ruben Flores on 6/5/13.
//
//

#import "MainMenuViewController.h"
#import "GameManager.h"

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PlayGame:(id)sender
{
    UIViewController * viewController = [[GameManager sharedManager] startCocos2d];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
    //[[GameManager sharedManager] startGame];
    
}
- (void)dealloc {
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
