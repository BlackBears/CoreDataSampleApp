#import "CCFListTableViewController.h"
#import "CCFItemTableViewController.h"

//  mode
#import "CCFList.h"

@interface CCFListTableViewController () <UIAlertViewDelegate>
@property (nonatomic, copy) NSArray *lists;
@end

@implementation CCFListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Lists";

    //  for the sake of demonstration, pop up an alert view in a little while
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"List" message:@"Add a new list?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        [alert show];
    });
}

#pragma mark - Storyboard support

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if( [[segue identifier] isEqualToString:@"com.cocoafactory.PushItems"] ) {
        CCFItemTableViewController *vc = segue.destinationViewController;
        vc.managedObjectContext = self.managedObjectContext;
        
        NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
        vc.list = self.lists[indexPath.row];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"com.cocoafactory.list";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.lists[indexPath.row] name];
    
    return cell;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if( buttonIndex != 0 ) {
        CCFList *list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:self.managedObjectContext];
        list.name = [NSString stringWithFormat:@"List %0.1f",[[NSDate date] timeIntervalSince1970]];
        
        NSError *saveError = nil;
        if( ![[self managedObjectContext] save:&saveError] ) {
            NSLog(@"ERROR saving list %@,%@", saveError, saveError.userInfo);
        }
        else {
            //  force us to reload the lists from Core Data.
            //  there are more efficient ways of doing this - e.g. NSFetchedResultsController
            self.lists = nil;
            [[self tableView] reloadData];
        }
    }
}

- (NSArray *)lists {
    if( !_lists ) {
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"List"];
        NSError *fetchError = nil;
        _lists = [[self managedObjectContext] executeFetchRequest:request error:&fetchError];
        if( !_lists )
            NSLog(@"ERROR fetching lists %@,%@",fetchError,fetchError.userInfo);
    }
    return _lists;
}

@end
