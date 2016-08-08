//
//  DisplayRankTableViewController.m
//  Memory Game
//
//  Created by Naveenu Perumunda on 31/07/2016.
//  Copyright © 2016 Track the Bird. All rights reserved.
//

#import "DisplayRankTableViewController.h"

@interface DisplayRankTableViewController ()

@end

@implementation DisplayRankTableViewController

@synthesize context;
@synthesize fetchedResultsController;
int previousScore;
int rank;

// Initialize
- (void) initialize{
    AppDelegate *appDelegate    =   [[UIApplication sharedApplication] delegate];
    context                     =   [appDelegate managedObjectContext];
    // Init Previous score and ranks
    previousScore               =   -999;
    rank                        =   1;
}

// Initialize Fetch result controller
- (void)initFetchResultController{
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate     =   self;
    self.tableView.dataSource   =   self;
    
    // Init
    [self initialize];
    
    // Init Fetch result controller
    [self initFetchResultController];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - fetchedResultsController
- (NSFetchedResultsController *)fetchedResultsController {
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    NSFetchRequest *fetchRequest    = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity     = [NSEntityDescription entityForName:@"Highscores" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    //NSPredicate *predicate          = [NSPredicate predicateWithFormat:@"(forecastLocation == %@) AND (date >= %@)", selectedLocation, cutOffDate];
   // [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *highestToLowest = [[NSSortDescriptor alloc] initWithKey:@"score" ascending:NO];
   // NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];

    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:highestToLowest]];
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:context sectionNameKeyPath:nil
                                                   cacheName:nil];
    self.fetchedResultsController = theFetchedResultsController;
    fetchedResultsController.delegate = (id)self;
    return fetchedResultsController;
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Set Table View Cell height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id  sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        Highscores    *scoresInfo           =  [fetchedResultsController objectAtIndexPath:indexPath];
        
        //Define Cell identifier
        static NSString *cellIdentifier     =  @"ranksCell";
        RanksCell *rankDetailsCell          =  (RanksCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!rankDetailsCell){
            rankDetailsCell                 =  [[RanksCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        rankDetailsCell.rankLabel.text      =   [NSString stringWithFormat:@"%d",rank];
        rankDetailsCell.nameLabel.text      =   [NSString stringWithFormat:@"%@",scoresInfo.name];
        rankDetailsCell.scoreLabel.text     =   [NSString stringWithFormat:@"%@",scoresInfo.score];
        rankDetailsCell.dateLabel.text      =   [NSString stringWithFormat:@"%@",scoresInfo.date];
        
        if(previousScore != (int)scoresInfo.score){
            previousScore   =   (int)scoresInfo.score;
            rank++;
        }

        return rankDetailsCell;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

@end
