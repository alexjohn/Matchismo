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

// this solution is ok, better solved when we build View in code
@property (weak, nonatomic) UISegmentedControl *matchModeSC;

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
    if (self.matchModeSC.enabled) {
        self.matchModeSC.enabled = NO;
    }
    
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)dealButton
{
    self.matchModeSC.enabled = YES;

    self.game = nil;
    [self updateUI];
}

- (IBAction)matchModeSegmentedControl:(UISegmentedControl *)sender
{
    self.matchModeSC = sender;
    self.game.matchingMode = [sender selectedSegmentIndex];
}

- (void)updateUI
{
    NSLog(@"*** break ***");
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        
        if (card.isMatched && cardButton.enabled) {
            NSLog(@"matched %@", [card contents]);
        } else if (card.isSelected && cardButton.enabled) {
            NSLog(@"selected %@", [card contents]);
        }
        
        cardButton.enabled = !card.isMatched;
    }
    // update some label
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