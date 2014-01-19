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
        // self.numCardsToMatch = ??
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
    
    if ([self.flippedCards containsObject:card]) {
        [self.flippedCards removeObject:card];
        card.selected = NO;
    } else {
        [self.flippedCards insertObject:card atIndex:0];
        card.selected = YES;
    }
    
    self.score -= COST_TO_CHOSE;
    
    if ([self.flippedCards count] == self.numCardsToMatch) {
        NSInteger matchScore = [[self.flippedCards firstObject] match:self.flippedCards];
        if (matchScore) {
            self.score += matchScore * MATCH_BONUS;
            for (Card *flipped in self.flippedCards) {
                flipped.matched = YES;
            }
            [self.flippedCards removeAllObjects];
        } else {
            self.score -= MISMATCH_PENALTY;
            
            // this is messy, but better than the nested ifs used previously
            Card *mostRecentlySelected = [self.flippedCards firstObject];
            for (Card *flipped in self.flippedCards) {
                flipped.selected = NO;
            }
            [self.flippedCards removeAllObjects];
            mostRecentlySelected.selected = YES;
            [self.flippedCards addObject:mostRecentlySelected];
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
