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

@end
