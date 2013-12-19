//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Alex John on 12/4/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@implementation PlayingCardGameViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.game.numCardsToMatch = 2;
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
