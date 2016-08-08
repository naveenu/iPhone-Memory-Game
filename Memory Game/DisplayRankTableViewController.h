//
//  DisplayRankTableViewController.h
//  Memory Game
//
//  Created by Naveenu Perumunda on 31/07/2016.
//  Copyright © 2016 Track the Bird. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RanksCell.h"
#import "Highscores.h"


@interface DisplayRankTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic,strong) NSManagedObjectContext* context;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;


@end
