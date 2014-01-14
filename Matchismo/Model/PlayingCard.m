//
//  PlayingCard.m
//  Matchismo
//
//  Created by Alex John on 11/6/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) _suit = suit;
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <=[PlayingCard maxRank]) {
        _rank = rank;
    }
}

+ (NSArray *)validSuits
{
    return @[@"♥︎",@"♦︎",@"♠︎",@"♣︎"];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",
             @"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (NSInteger)match:(NSArray *)otherCards
{
    NSInteger score = 0;
    
    for (PlayingCard *card in otherCards) {
        for (PlayingCard *otherCard in otherCards) {
            if (card != otherCard) {
                // NSLog(@"%@\n%@", card, otherCard);
                if (card.rank == otherCard.rank) {
                    score += 4;
                } else if ([card.suit isEqualToString:otherCard.suit]) {
                    score += 1;
                }
            }
        }
    }

    return score;
}

@end
