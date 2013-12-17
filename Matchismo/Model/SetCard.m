//
//  SetCard.m
//  Matchismo
//
//  Created by Alex John on 12/9/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (void)setNumberOfSymbols:(NSUInteger)numberOfSymbols
{
    if (numberOfSymbols > 0 && numberOfSymbols <= [SetCard maxNumberOfSymbols]) {
        _numberOfSymbols = numberOfSymbols;
    }
}

+ (NSUInteger)maxNumberOfSymbols
{
    return 3;  // ??
}

@synthesize shade = _shade;

- (NSString *)shade
{
    return _shade ? _shade : @"SHADE N/A";
}

- (void)setShade:(NSString *)shade
{
    if ([[SetCard validShades] containsObject:shade]) {
        _shade = shade;
    }
}

+ (NSArray *)validShades
{
    // I've decided strings are a great representation in the model, they are descriptive
    // and keep view details out of the model. If I were being completely correct color
    // and symbol would be similarly implemented. As they stand, they are convience hacks
    return @[@"no shading", @"light shading", @"dark shading"];
}

@synthesize color = _color;

- (UIColor *)color
{
    return _color ? _color : [UIColor blackColor];
}

- (void)setColor:(UIColor *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

+ (NSArray *)validColors
{
    return @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
}

@synthesize symbol = _symbol;

- (NSString *)symbol
{
    return _symbol ? _symbol : @"✕";
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

+ (NSArray *)validSymbols
{
    return @[@"○", @"□", @"△"];
}

- (NSString *)contents
{
    NSString *tmp = @"";
    
    for (int i = 0; i < self.numberOfSymbols; i++) {
        tmp = [tmp stringByAppendingFormat:@"%@", self.symbol];
    }
    
    return tmp;
}

+ (NSInteger)alexMatch:(NSArray *)otherCards
{
    NSInteger score = 1;
    
    for (SetCard *card in otherCards) {
        for (SetCard *otherCard in otherCards) {
            if (card != otherCard) {
                // NSLog(@"%@\n%@", card, otherCard);
                // this is going to be impossible to test until the set cards are displayed properly
                ;
            }
        }
    }
    
    return score;
}











@end
