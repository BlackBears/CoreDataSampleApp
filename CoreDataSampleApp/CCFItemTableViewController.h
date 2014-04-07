@class CCFList;

@interface CCFItemTableViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) CCFList *list;

@end
