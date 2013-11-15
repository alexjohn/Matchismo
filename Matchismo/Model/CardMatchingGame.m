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
@property (nonatomic, strong) NSMutableArray *flippedCards;

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

- (NSMutableArray *)flippedCards
{
    if (!_flippedCards) _flippedCards = [[NSMutableArray alloc] init];
    return _flippedCards;
}

// could alternatively use the C #define macro
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
     
    if (!card.isOutOfPlay) {
        if (!card.isFaceUp) {
            if (![self.flippedCards containsObject:card]) {
                int matchScore = [card match:self.flippedCards];
                if (matchScore) {
                    // adjust score
                    if ([self.flippedCards count] == self.matchingMode + 1) {
                        for (Card *flipped in self.flippedCards) {
                            flipped.outOfPlay = YES;
                        }
                        [self.flippedCards removeAllObjects];
                        card.outOfPlay = YES;
                    } else {
                        [self.flippedCards addObject:card];
                    }
                } else {
                    for (Card *flipped in self.flippedCards) {
                        flipped.faceUp = NO;
                    }
                    [self.flippedCards removeAllObjects];
                    [self.flippedCards addObject:card];
                }
            }
        } else {
            [self.flippedCards removeObject:card];
        }
        card.faceUp = !card.isFaceUp;
        //adjust score
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end