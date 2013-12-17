//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Alex John on 12/6/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"

@implementation SetCardGameViewController

-(void)viewDidLoad
{
    self.game.numCardsToMatch = 3;
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (IBAction)dealButton
{
    [super dealButton];
    self.actionLabel.text = @"Matchismo: Set";
}

- (NSString *)titleForCard:(Card *)card
{
    // return a nsattributed string?
    return card.contents;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:@"cardFront"];
}

@end
