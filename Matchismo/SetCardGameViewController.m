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

- (void)viewDidLoad
{
    // where should this line go so that it's not duplicated?
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
    self.game.numCardsToMatch = 3;
}

- (void)updateUI
{
    [super updateUI];
    
    for (UIButton *cardButton in self.cardButtons) {
        // it would be awesome if this logic could be moved to titleForCard
        // i forget why I thought this. also, it seems possible to accomplish. i think?
        NSInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        SetCard *card = (SetCard *)[self.game cardAtIndex:cardButtonIndex];
        
        UIColor *color = [card.attributes objectForKey:@"color"];
        UIColor *shade = [self shadeForCard:card];

        NSMutableAttributedString *buttonText = [cardButton.titleLabel.attributedText mutableCopy];
        [buttonText addAttributes:@{ NSForegroundColorAttributeName : color,
                                     NSBackgroundColorAttributeName : shade }
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

- (UIColor *)shadeForCard:(SetCard *)card
{
    UIColor *color = [card.attributes objectForKey:@"color"];
    NSString *shade = [card.attributes objectForKey:@"shade"];
    
    if ([shade isEqualToString:@"no shade"]) {
        color = [color colorWithAlphaComponent:0.0];
    } else if ([shade isEqualToString:@"light shade"]) {
        color = [color colorWithAlphaComponent:0.1];
    } else {
        color = [color colorWithAlphaComponent:0.3];
    }
    
    return  color;
}

@end
