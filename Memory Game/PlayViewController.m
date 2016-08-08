//
//  PlayViewController.m
//  Memory Game
//
//  Created by Naveenu Perumunda on 30/07/2016.
//  Copyright © 2016 Track the Bird. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController ()
@end

@implementation PlayViewController
@synthesize     button1,    button2,    button3,    button4;
@synthesize     button5,    button6,    button7,    button8;
@synthesize     button9,    button10,   button11,   button12;
@synthesize     button13,   button14,   button15,   button16;
@synthesize     currentLabel;
@synthesize     informationView;
@synthesize     playerNameTextField;
@synthesize     context;

NSMutableArray  *colourMemoryCards;
NSMutableArray  *repeatedMutableArray;
NSString        *firstItem;
NSString        *secondItem;

int btnTag1, btnTag2, page, totalCards, numberCardsControl, randomNumber, presentScore;

// Initialize variables
- (void) initialize{
    AppDelegate *appDelegate            = [[UIApplication sharedApplication] delegate];
    context                             = [appDelegate managedObjectContext];
    
    colourMemoryCards                   = [[NSMutableArray alloc] init];
    repeatedMutableArray                = [[NSMutableArray alloc] init];
    self.playerNameTextField.delegate   =  self;
    btnTag1                             =   0;
    btnTag2                             =   0;
    page                                =   0;
    randomNumber                        =   0;
    presentScore                        =   0;
    totalCards                          =   16;
    numberCardsControl                  =   16;
    currentLabel.text                   =   @"Score: 0";
    informationView.hidden              =   YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Init variables
    [self initialize];
    
    // Init Playing Cards
    [self initializeCards];
    

}

// Create playing card and add it to Mutable Array
-(PlayingCards *) setImageAttributes:(NSString *)imageName{
    PlayingCards *playingCards  =   [[PlayingCards alloc] init];
    [playingCards setImageColor: [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",imageName]]];
    [playingCards setColor:imageName];
    [playingCards setButtonNumber:[self getRandomNumber]];
    return playingCards;
}

// Initilize the cards and get display print
- (void) initializeCards{
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"Olive"]];
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"Olive"]];
    
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"White"]];
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"White"]];
    
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"Orange"]];
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"Orange"]];
    
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"Megenta"]];
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"Megenta"]];
    
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"Green"]];
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"Green"]];
    
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"Purple"]];
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"Purple"]];
    
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"Red"]];
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"Red"]];
    
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"Yellow"]];
    [colourMemoryCards addObject:[self setImageAttributes:(NSString *)@"Yellow"]];
}

- (IBAction)savePlayerData:(UIButton *)sender {
    // Validate for empty string.
    if([playerNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0){
        [UIView animateWithDuration:1.0 delay:0 options:0 animations:^{
            informationView.hidden  =   YES;
        } completion:^(BOOL finished) { }];
        // Save data into Code data
        NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        NSManagedObject *newRecord  = [NSEntityDescription insertNewObjectForEntityForName:@"Highscores" inManagedObjectContext:context];
        [newRecord setValue:self.playerNameTextField.text forKey:@"name"];
        [newRecord setValue:[NSNumber numberWithInt:presentScore] forKey:@"score"];
        [newRecord setValue:dateString forKey:@"date"];
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        // Navigate to Ranks table view
        UIStoryboard *storyboard                = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        UIViewController * viewController       = [storyboard instantiateViewControllerWithIdentifier:@"rankDisplayTableViewID"];
        viewController.modalTransitionStyle     = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    else{
        // UI Alert View to show error
        self.playerNameTextField.text           =  @"";
        UIAlertController *alertController      = [UIAlertController alertControllerWithTitle:@"Sorry!!!" message:@"Please enter valid name" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok                       = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

    // Selected card item
- (IBAction)selectedCards:(id)sender {
    page++;
    // Select one colour card to display
    if(page == 1){
        for (int i=0; i<colourMemoryCards.count; i++) {
            if([sender tag]==[[colourMemoryCards objectAtIndex:i] getButtonNumber]){
                firstItem   = [[colourMemoryCards objectAtIndex:i] getColorCard];
                [sender setImage:[[colourMemoryCards objectAtIndex:i] getImageColor] forState:UIControlStateNormal];
            }
        }
        btnTag1 = (int)[sender tag];
    }
    else if (btnTag1 == (int)[sender tag]){ // Avoid double click option.
        UIAlertController *alertController  = [UIAlertController alertControllerWithTitle:@"Sorry!!" message:@"You can't select the same card!!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok                   = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
        page        = 1;
    }
    else if(page == 2){ // Validate Card one color with Card 2 colour.
        for (int i=0; i<colourMemoryCards.count; i++) {
            if([sender tag]==[[colourMemoryCards objectAtIndex:i] getButtonNumber]){
                [sender setImage:[[colourMemoryCards objectAtIndex:i] getImageColor] forState:UIControlStateNormal];
                secondItem = [[colourMemoryCards objectAtIndex:i] getColorCard];
            }
        }
        page            = 0;
        btnTag2         = (int)[sender tag];
        if([firstItem isEqualToString:secondItem]){ // If first card is equal to second card, then increase the score by 2 points.
            presentScore            = presentScore + 2;
            currentLabel.text       =     [NSString stringWithFormat:@"Score : %d",presentScore];
            [self hideButtons];
            numberCardsControl = numberCardsControl - 2;
            // If the cards are empty, Ask user to save the score with user name.
            if(numberCardsControl<=0){
                numberCardsControl          =   16; // Reset the cad back to 16 and hide colours card view
                [UIView animateWithDuration:1.0 delay:0 options:0 animations:^{
                    informationView.hidden  =   NO;
                } completion:^(BOOL finished) { }];
            }
        }
        else{ // Wrong card selection. Decrease the point by one
            presentScore            = presentScore - 1;
            currentLabel.text       =     [NSString stringWithFormat:@"Score : %d",presentScore];
            [self performSelector:@selector(resetAllButtons) withObject:nil afterDelay:1.0f];
        }
    }
}

// Hide the buttons.
- (void) hideButtons{
    // Hide second set of buttons
    switch (btnTag2) {
        case 1:
            button1.alpha = 0;
            break;
        case 2:
            button2.alpha = 0;
            break;
        case 3:
            button3.alpha = 0;
            break;
        case 4:
            button4.alpha = 0;
            break;
        case 5:
            button5.alpha = 0;
            break;
        case 6:
            button6.alpha = 0;
            break;
        case 7:
            button7.alpha = 0;
            break;
        case 8:
            button8.alpha = 0;
            break;
        case 9:
            button9.alpha = 0;
            break;
        case 10:
            button10.alpha = 0;
            break;
        case 11:
            button11.alpha = 0;
            break;
        case 12:
            button12.alpha = 0;
            break;
        case 13:
            button13.alpha = 0;
            break;
        case 14:
            button14.alpha = 0;
            break;
        case 15:
            button15.alpha = 0;
            break;
        case 16:
            button16.alpha = 0;
            break;
        default:
            break;
    }

    // First set of buttons
    switch (btnTag1) {
        case 1:
            button1.alpha = 0;
            break;
        case 2:
            button2.alpha = 0;
            break;
        case 3:
            button3.alpha = 0;
            break;
        case 4:
            button4.alpha = 0;
            break;
        case 5:
            button5.alpha = 0;
            break;
        case 6:
            button6.alpha = 0;
            break;
        case 7:
            button7.alpha = 0;
            break;
        case 8:
            button8.alpha = 0;
            break;
        case 9:
            button9.alpha = 0;
            break;
        case 10:
            button10.alpha = 0;
            break;
        case 11:
            button11.alpha = 0;
            break;
        case 12:
            button12.alpha = 0;
            break;
        case 13:
            button13.alpha = 0;
            break;
        case 14:
            button14.alpha = 0;
            break;
        case 15:
            button15.alpha = 0;
            break;
        case 16:
            button16.alpha = 0;
            break;
        default:
            break;
    }
}
    // Reset the buttons to it original state
- (void) resetButton: (UIButton *)button{
    dispatch_async(dispatch_get_main_queue(),^{
        [button setImage:[UIImage imageNamed:@"guess_me.png"] forState:UIControlStateNormal];
    });
}

//  Reset all teh buttons
- (void) resetAllButtons {
    switch (btnTag2) {
        case 1:
            [self resetButton:(UIButton *)button1];
            break;
        case 2:
            [self resetButton:(UIButton *)button2];
            break;
        case 3:
            [self resetButton:(UIButton *)button3];
            break;
        case 4:
            [self resetButton:(UIButton *)button4];
            break;
        case 5:
            [self resetButton:(UIButton *)button5];
            break;
        case 6:
            [self resetButton:(UIButton *)button6];
            break;
        case 7:
            [self resetButton:(UIButton *)button7];
            break;
        case 8:
            [self resetButton:(UIButton *)button8];
            break;
        case 9:
            [self resetButton:(UIButton *)button9];
            break;
        case 10:
            [self resetButton:(UIButton *)button10];
            break;
        case 11:
            [self resetButton:(UIButton *)button11];
            break;
        case 12:
            [self resetButton:(UIButton *)button12];
            break;
        case 13:
            [self resetButton:(UIButton *)button13];
            break;
        case 14:
            [self resetButton:(UIButton *)button14];
            break;
        case 15:
            [self resetButton:(UIButton *)button15];
            break;
        case 16:
            [self resetButton:(UIButton *)button16];
            break;
        default:
            break;
    }
    switch (btnTag1) {
        case 1:
            [self resetButton:(UIButton *)button1];
            break;
        case 2:
            [self resetButton:(UIButton *)button2];
            break;
        case 3:
            [self resetButton:(UIButton *)button3];
            break;
        case 4:
            [self resetButton:(UIButton *)button4];
            break;
        case 5:
            [self resetButton:(UIButton *)button5];
            break;
            
        case 6:
            [self resetButton:(UIButton *)button6];
            break;
            
        case 7:
            [self resetButton:(UIButton *)button7];
            break;
            
        case 8:
            [self resetButton:(UIButton *)button8];
            break;
            
        case 9:
            [self resetButton:(UIButton *)button9];
            break;
            
        case 10:
            [self resetButton:(UIButton *)button10];
            break;
        case 11:
            [self resetButton:(UIButton *)button11];
            break;
        case 12:
            [self resetButton:(UIButton *)button12];
            break;
        case 13:
            [self resetButton:(UIButton *)button13];
            break;
        case 14:
            [self resetButton:(UIButton *)button14];
            break;
        case 15:
            [self resetButton:(UIButton *)button15];
            break;
        case 16:
            [self resetButton:(UIButton *)button16];
            break;
        default:
            break;
    }
}

    // Aviod same pattern
- (bool) isrepeatedMutableArray: (int) randomNumber{
    for(int i=0; i<[repeatedMutableArray count];i++){
        if(randomNumber == [[repeatedMutableArray objectAtIndex:i] integerValue]){
            return true;
        }
    }
    [repeatedMutableArray addObject:[NSNumber numberWithInt:randomNumber]];
    return false;
}

    // Get Random Number
- (int) getRandomNumber{
    int random = 0;
    do {
        random = arc4random() % totalCards;
    }while ([self isrepeatedMutableArray:random]);
    if(random == 0){
        random = 16;
    }
    return random;
}

@end
