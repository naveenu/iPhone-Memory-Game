//
//  PlayViewController.h
//  Memory Game
//
//  Created by Naveenu Perumunda on 30/07/2016.
//  Copyright © 2016 Track the Bird. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "PlayingCards.h"
#import "Highscores.h"

@interface PlayViewController : UIViewController <UITextFieldDelegate>{
    
}

@property (weak, nonatomic) IBOutlet UIView *playerCardsView;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UIButton *button10;
@property (weak, nonatomic) IBOutlet UIButton *button11;
@property (weak, nonatomic) IBOutlet UIButton *button12;
@property (weak, nonatomic) IBOutlet UIButton *button13;
@property (weak, nonatomic) IBOutlet UIButton *button14;
@property (weak, nonatomic) IBOutlet UIButton *button15;
@property (weak, nonatomic) IBOutlet UIButton *button16;

@property (weak, nonatomic) IBOutlet UILabel *currentLabel;

@property (weak, nonatomic) IBOutlet UIView *informationView;
@property (weak, nonatomic) IBOutlet UITextField *playerNameTextField;

@property (nonatomic,strong) NSManagedObjectContext* context;


@end
