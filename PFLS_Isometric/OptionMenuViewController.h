//
//  OptionMenuViewController.h
//  PFLS_Isometric
//
//  Created by Thomas on 6/19/13.
//
//

#import <UIKit/UIKit.h>

@interface OptionMenuViewController : UIViewController

- (IBAction)toggleControl:(id)sender;
- (IBAction)MoveToMainMenu:(id)sender;

@property (retain, nonatomic) IBOutlet UISegmentedControl *ControlSwitch;

@property BOOL isControllerOn;
@property BOOL isTouchOn;

@end
