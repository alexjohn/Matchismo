//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Alex John on 11/6/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//
//  Abstract class. Must implement methods as described below.

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "Deck.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;

- (Deck *)createDeck;  // abstract

@end
