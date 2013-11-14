//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Alex John on 11/7/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;  // of card

@property (nonatomic, strong) NSMutableArray *otherCards;

@end

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; ++i) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)otherCards
{
    if (!_otherCards) _otherCards = [[NSMutableArray alloc] init];
    return _otherCards;
}

// could alternatively use the C #define macro
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isOutOfPlay) {
        if (card.faceUp) {
            card.faceUp = NO;
        } else {
            // match against other faceUp cards
            for (Card *otherCard in self.cards) {
                if (otherCard.faceUp && !otherCard.isOutOfPlay) {
                    // @[] match accepts an array of cards. hint hint
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.outOfPlay = YES;
                        card.outOfPlay = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        // refer to slides 53. this needs to change
                        otherCard.faceUp = NO;
                    }
                    break;
                    // otherCards need to be set to nil
                }
            }
            self.score -= COST_TO_CHOSE;
            card.faceUp = YES;
            // selected cards need to be added to otherCards
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
