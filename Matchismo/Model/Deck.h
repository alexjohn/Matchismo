//
//  Deck.h
//  Matchismo
//
//  Created by Alex John on 11/7/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;

@end
