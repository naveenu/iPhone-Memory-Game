//
//  PlayingCards.m
//  Memory Game
//
//  Created by Naveenu Perumunda on 31/07/2016.
//  Copyright © 2016 Track the Bird. All rights reserved.
//

#import "PlayingCards.h"

@implementation PlayingCards
@synthesize color;
@synthesize buttonNum;
@synthesize imageColor;

- (void) setColorCard: (NSString*) _color{
    color = _color;
}

- (NSString*) getColorCard{
    return color;
}

- (void) setButtonNumber:(int)_buttonNum{
    buttonNum = _buttonNum;
}

- (int) getButtonNumber{
    return buttonNum;
}

- (void) setImageColor:(UIImage *) _imageColor{
    imageColor = _imageColor;
}

- (UIImage*) getImageColor{
    return imageColor;
}

@end
