//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Alex John on 12/9/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSUInteger number = 1; number <= [SetCard maxNumberOfSymbols]; number++) {
            for (NSString *shade in [SetCard validShades]) {
                for (UIColor *color in [SetCard validColors]) {
                    for (NSString *symbol in [SetCard validSymbols]) {
                        // that's deep son
                        SetCard *card = [[SetCard alloc] init];
                        card.numberOfSymbols = number;
                        card.shade = shade;
                        card.color = color;
                        card.symbol = symbol;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
