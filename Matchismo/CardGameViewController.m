//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Alex John on 11/6/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *actionLabel;
// this solution isn't great
// @property (weak, nonatomic) UISegmentedControl *numCardsToMatchSegmentedControl;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

// abstract, only useful as a super class
- (Deck *)createDeck
{
    return nil;
}

/*- (void)viewDidLoad/viewWillAppear?
 * the view is not set to nil ever, the game is
 * so i think viewDidLoad is the appropriate choice
{
    [super viewDidLoad];
    // this won't work, but I'm getting closer to a solution
    // [self matchModeSegmentedControl:[self numCardsToMatchSegmentedControl]];
}*/

- (IBAction)touchCardButton:(UIButton *)sender
{
    /*if (self.numCardsToMatchSegmentedControl.enabled) {
        self.numCardsToMatchSegmentedControl.enabled = NO;
    }*/
    
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)dealButton
{
    // self.numCardsToMatchSegmentedControl.enabled = YES;

    self.game = nil;
    [self updateUI];
}

/*- (IBAction)matchModeSegmentedControl:(UISegmentedControl *)sender
{
    self.numCardsToMatchSegmentedControl = sender;
    self.game.numCardsToMatch = [sender selectedSegmentIndex];
}*/

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
        self.actionLabel.text =
        [[NSString alloc] initWithFormat:@"Matched%@",
         [action stringByReplacingOccurrencesOfString:@"m" withString:@", "]];
    } else if ([action characterAtIndex:0] == 's') {
        self.actionLabel.text =
        [[NSString alloc] initWithFormat:@"Selected%@",
         [action stringByReplacingOccurrencesOfString:@"s" withString:@", "]];
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