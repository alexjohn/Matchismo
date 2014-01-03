//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Alex John on 12/6/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCard.h"
#import "SetCardDeck.h"

@implementation SetCardGameViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.game.numCardsToMatch = 3;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
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

- (void)updateUI
{
    [super updateUI];
    
    for (UIButton *cardButton in self.cardButtons) {
        // it would be awesome if this logic could be moved to titleForCard
        NSInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        SetCard *card = (SetCard *)[self.game cardAtIndex:cardButtonIndex];
        
        UIColor *color = [card.attributes objectForKey:@"color"];
        // NSLog(@"%@", color.description);
        NSMutableAttributedString *buttonText = [cardButton.titleLabel.attributedText mutableCopy];
        [buttonText addAttributes:@{ NSForegroundColorAttributeName : color }
                            range:NSMakeRange(0, [buttonText.string length])];
        cardButton.titleLabel.attributedText = buttonText;
    }
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
