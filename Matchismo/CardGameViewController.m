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

// actionlabel
@property (strong, nonatomic) NSMutableArray *selectedCardButtons;

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

- (NSMutableArray *)selectedCardButtons
{
    if (!_selectedCardButtons) _selectedCardButtons = [[NSMutableArray alloc] init];
    return _selectedCardButtons;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    if (self.matchModeSC.enabled) {
        self.matchModeSC.enabled = NO;
    }
    
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    
    [self describeResultsOfPressingCard:sender];
}

- (void)describeResultsOfPressingCard:(UIButton *)cardButton
{
    // i bet i could integrate this logic into updateUI, where isSlected is scanned
    //  and matched are scanned
    NSString *buttonTitle = [[NSString alloc] initWithString:cardButton.currentTitle];
    NSUInteger titleIndex = 0;
    BOOL containsTitle = NO;
    
    for (; titleIndex < [self.selectedCardButtons count]; ++titleIndex) {
        if ([self.selectedCardButtons[titleIndex] isEqualToString:buttonTitle]) {
            containsTitle = YES;
            break;
        }
    }
    
    if (containsTitle) {
        [self.selectedCardButtons removeObjectAtIndex:titleIndex];
    } else {
        [self.selectedCardButtons addObject:buttonTitle];
    }
    
    // this is pretty sloppy
    // also, score change should be in the controller not model
    if (self.game.scoreChange >= 0) {
        NSLog(@"matched: ");
        for (NSString *buttonTitle in self.selectedCardButtons) {
            NSLog(@"%@, ", buttonTitle);
        }
        [self.selectedCardButtons removeAllObjects];
    } else if (self.game.scoreChange < 0) {
        if ([self.selectedCardButtons count] == self.game.matchingMode + 2) {
            for (NSString *buttonTitle in self.selectedCardButtons) {
                NSLog(@"%@, ", buttonTitle);
            }
            NSLog(@"do not match");
            [self.selectedCardButtons removeAllObjects];
            [self.selectedCardButtons addObject:buttonTitle];
        } else {
            NSLog(@"selected: ");
            for (NSString *buttonTitle in self.selectedCardButtons) {
                NSLog(@"%@, ", buttonTitle);
            }
        }
    }
}

- (IBAction)dealButton
{
    self.matchModeSC.enabled = YES;

    self.game = nil;
    [self updateUI];
    
    self.selectedCardButtons = nil;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isOutOfPlay;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (IBAction)matchModeSegmentedControl:(UISegmentedControl *)sender
{
    self.matchModeSC = sender;
    self.game.matchingMode = [sender selectedSegmentIndex];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.faceUp ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isFaceUp ? @"cardFront" : @"cardBack"];
}

@end