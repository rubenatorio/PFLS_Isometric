//
//  LevelMenuViewController.m
//  PFLS_Isometric
//
//  Created by Thomas on 6/17/13.
//
//

#import "LevelMenuViewController.h"
#import "GameManager.h"

@interface LevelMenuViewController ()

@end

@implementation LevelMenuViewController

@synthesize levelArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        levelArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [levelArray addObject:@"1-1"];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int selectedRow = indexPath.row;
    NSLog(@"touch on row %d", selectedRow);
}

-(NSInteger *)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return levelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellId = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId] autorelease];
    }
    
    cell.textLabel.text = [levelArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_LevelSelect release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLevelSelect:nil];
    [super viewDidUnload];
}
@end
