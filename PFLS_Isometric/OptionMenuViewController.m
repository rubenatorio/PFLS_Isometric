//
//  OptionMenuViewController.m
//  PFLS_Isometric
//
//  Created by Thomas on 6/19/13.
//
//

#import "OptionMenuViewController.h"
#import "GameManager.h"
#import "MainMenuViewController.h"

enum SegmenOrentation{
    Touch, Controllers
};

@interface OptionMenuViewController ()

@end

@implementation OptionMenuViewController


@synthesize ControlSwitch = _ControlSwitch;
@synthesize isControllerOn;
@synthesize isTouchOn;


- (IBAction)toggleControl:(id)sender {
    if (_ControlSwitch.selectedSegmentIndex != Controllers) {
        [GameManager sharedManager].isControllerEnabled = NO;
        [GameManager sharedManager].isTouchEnabled = YES;
        NSLog(@"Touch is on.");
    }
    else{
        [GameManager sharedManager].isControllerEnabled = YES;
        [GameManager sharedManager].isTouchEnabled = NO;
        NSLog(@"Controllers are on.");
    }
}

- (IBAction)MoveToMainMenu:(id)sender {
       MainMenuViewController * viewController = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
    
   [self.navigationController pushViewController: viewController animated: YES];
}


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


- (void)dealloc {
    [_ControlSwitch release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setControlSwitch:nil];
    [super viewDidUnload];
}

@end
