//
//  RanksCell.h
//  Memory Game
//
//  Created by Naveenu Perumunda on 31/07/2016.
//  Copyright © 2016 Track the Bird. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RanksCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
