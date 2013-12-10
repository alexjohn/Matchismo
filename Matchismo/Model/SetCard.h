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
@property (nonatomic) NSUInteger numberOfSymbols;
@property (strong, nonatomic) NSString *shade;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) NSString *symbol;

+ (NSUInteger)maxNumberOfSymbols;
+ (NSArray *)validShades;
+ (NSArray *)validColors;
+ (NSArray *)validSymbols;

@end
