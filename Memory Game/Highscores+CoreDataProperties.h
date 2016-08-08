//
//  Highscores+CoreDataProperties.h
//  Memory Game
//
//  Created by Naveenu Perumunda on 31/07/2016.
//  Copyright © 2016 Track the Bird. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Highscores.h"

NS_ASSUME_NONNULL_BEGIN

@interface Highscores (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *date;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *score;
@property (nullable, nonatomic, retain) NSNumber *rank;

@end

NS_ASSUME_NONNULL_END
