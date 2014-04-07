#import "CCFItemTableViewController.h"

#import "CCFList.h"
#import "CCFItem.h"

@interface CCFItemTableViewController () <UIAlertViewDelegate>
@property (nonatomic, copy) NSArray *items;
@end

@implementation CCFItemTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Items";

    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Item"
                                                        message:@"Do you want to add an item to list?"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    });
}

#pragma mark - Alert view delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if( buttonIndex != 0 ) {
        CCFItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:self.managedObjectContext];
        item.name = [NSString stringWithFormat:@"Item %0.1f",[[NSDate date] timeIntervalSince1970]];
        item.price = [NSDecimalNumber decimalNumberWithString:@"10.41"];
        item.desc = @"A really cool item";
        item.list = self.list;
        
        NSError *saveError = nil;
        if( ![[self managedObjectContext] save:&saveError] ) {
            NSLog(@"ERROR - unable to save context after adding item %@,%@",saveError,saveError.userInfo);
        }
        else {
            _items = nil;
            [[self tableView] reloadData];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"com.cocoafactory.item";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [[self items][indexPath.row] name];
    
    return cell;
}


- (NSArray *)items {
    if( !_items ) {
        NSSet *itemSet = self.list.items;
        _items = [[itemSet allObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    }
    return _items;
}

@end
