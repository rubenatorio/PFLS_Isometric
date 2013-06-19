//
//  LevelMenuViewController.h
//  PFLS_Isometric
//
//  Created by Thomas on 6/17/13.
//
//

#import <UIKit/UIKit.h>

@interface LevelMenuViewController : UITableViewController <UITableViewDelegate , UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *LevelSelect;
@property (retain, nonatomic) NSMutableArray *levelArray;

@end
