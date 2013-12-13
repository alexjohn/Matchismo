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

-(void)viewDidLoad
{
    // 0 for 2 card matching, 1 for 3 etc.
    self.game.numCardsToMatch = 0;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)dealButton
{
    [super dealButton];
    self.actionLabel.text = @"Matchismo: Card Matching";
}

@end
