//
//  PlayingCards.h
//  Memory Game
//
//  Created by Naveenu Perumunda on 31/07/2016.
//  Copyright © 2016 Track the Bird. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UiKit/UiKit.h>

@interface PlayingCards : NSObject

@property (nonatomic) NSString *color;
@property (nonatomic) int buttonNum;
@property (nonatomic) UIImage  *imageColor;

- (void) setColorCard: (NSString*) _color;
- (NSString*) getColorCard;
- (void) setButtonNumber:(int)_buttonNum;
- (int) getButtonNumber;
- (void) setImageColor:(UIImage *)_ImageColor;
- (UIImage*) getImageColor;

@end
