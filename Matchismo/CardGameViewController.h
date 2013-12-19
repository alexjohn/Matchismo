//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Alex John on 11/6/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//
//  Abstract class. Must implement methods as described
//
//  How could I keep the current functionality while keeping
//  game, actionLabel and dealButton private?

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "Deck.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *actionLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

- (Deck *)createDeck;  // abstract
- (IBAction)dealButton;
- (void)updateUI;

@end
