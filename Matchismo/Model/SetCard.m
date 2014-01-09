//
//  SetCard.m
//  Matchismo
//
//  Created by Alex John on 12/9/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (void)setAttributes:(NSDictionary *)attributes
{
    if ([[SetCard validShades] containsObject:[attributes objectForKey:@"shade"]] &&
        [[SetCard validColors] containsObject:[attributes objectForKey:@"color"]] &&
        [[SetCard validSymbols] containsObject:[attributes objectForKey:@"symbol"]])
    {
        _attributes = attributes;
    }
}

+ (NSUInteger)maxNumberOfSymbols
{
    return 3;  // ??
}

+ (NSArray *)validShades
{
    return @[@"no shade", @"light shade", @"dark shade"];
}

+ (NSArray *)validColors
{
    return @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
}

+ (NSArray *)validSymbols
{
    return @[@"○", @"□", @"△"];
}

- (NSString *)contents
{
    NSString *tmp = @"";
    
    // shouldn't [self.attributes objectForKey:@"numberOfSymbols"] be cast to (nsnumber *)?
    // or maybe responds to selector?
    for (int i = 0; i < [[self.attributes objectForKey:@"numberOfSymbols"] intValue]; i++) {
        tmp = [tmp stringByAppendingFormat:@"%@", [self.attributes objectForKey:@"symbol"]];
    }
    
    return tmp;
}

+ (NSInteger)match:(NSArray *)otherCards
{
    NSInteger score = 1;
    
    /*for (SetCard *card in otherCards) {
        for (SetCard *otherCard in otherCards) {
            if (card != otherCard) {
                // NSLog(@"%@\n%@", card, otherCard);
                // this is going to be impossible to test until the set cards are displayed properly
                ;
            }
        }
    }*/
    
    return score;
}











@end
