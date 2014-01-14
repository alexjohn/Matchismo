//
//  Card.m
//  Matchismo
//
//  Created by Alex John on 11/6/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//

#import "Card.h"

@implementation Card

- (NSInteger)match:(NSArray *)otherCards
{
    NSInteger score = 0;
    
    for (Card *card in otherCards) {
        for (Card *otherCard in otherCards) {
            if (card != otherCard) {
                // NSLog(@"%@\n%@", card, otherCard);
                if ([card.contents isEqualToString:otherCard.contents]) {
                    score += 1;
                }
            }
        }
    }
    
    return score;
}

@end
