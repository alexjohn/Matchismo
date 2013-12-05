//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Alex John on 12/4/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

/* the playing card matching currently works because 
 * numCardsToMatch is automatically set to 0 when created
 * and this is the number we want for 2 card matching.
 * when the Set game is implemented there will need to 
 * be some line some where setting nCTM to 1.
 * maybe in the setter?
 */

@end
