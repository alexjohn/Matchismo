//
//  SetCard.h
//  Matchismo
//
//  Created by Alex John on 12/9/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

// three lightly shaded red circles
@property (strong, nonatomic) NSDictionary *attributes;

+ (NSUInteger)maxNumberOfSymbols;
+ (NSArray *)validShades;
+ (NSArray *)validColors;
+ (NSArray *)validSymbols;

@end
