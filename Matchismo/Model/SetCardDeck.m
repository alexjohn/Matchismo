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
                        // that's deep, son
                        SetCard *card = [[SetCard alloc] init];
                        
                        NSDictionary *attributes = [[NSDictionary alloc] initWithObjects:@[[NSNumber numberWithInteger:number], shade, color, symbol]
                                                                                 forKeys:@[@"numberOfSymbols", @"shade", @"color", @"symbol"]];
                        card.attributes = attributes;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
