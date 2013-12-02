//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Alex John on 11/6/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *actionLabel;

// this solution is ok, better solved when we build View in code
@property (weak, nonatomic) UISegmentedControl *numCardsToMatchSegCon;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    if (self.numCardsToMatchSegCon.enabled) {
        self.numCardsToMatchSegCon.enabled = NO;
    }
    
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)dealButton
{
    self.numCardsToMatchSegCon.enabled = YES;

    self.game = nil;
    [self updateUI];
}

- (IBAction)matchModeSegmentedControl:(UISegmentedControl *)sender
{
    self.numCardsToMatchSegCon = sender;
    self.game.numCardsToMatch = [sender selectedSegmentIndex];
}

- (void)updateUI
{
    NSMutableString *action = [[NSMutableString alloc] init];
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        
        if (cardButton.enabled) {
            if (card.isMatched) {
                [action appendFormat:@"m%@", [card contents]];
            } else if (card.isSelected) {
                [action appendFormat:@"s%@", [card contents]];
            }
        }
        
        cardButton.enabled = !card.isMatched;
    }

    /* crashes, don't care to fix atm
    if ([action characterAtIndex:0] == 'm') {
        self.actionLabel.text = [[NSString alloc] initWithFormat:@"Matched%@", [action stringByReplacingOccurrencesOfString:@"m"
                                                                                                                 withString:@", "]];
    } else if ([action characterAtIndex:0] == 's') {
        self.actionLabel.text = [[NSString alloc] initWithFormat:@"Selected%@", [action stringByReplacingOccurrencesOfString:@"s"
                                                                                                                  withString:@", "]];
    }*/
    
    self.actionLabel.text = action;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.selected ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isSelected ? @"cardFront" : @"cardBack"];
}

@end