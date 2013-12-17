//
//  Card.h
//  Matchismo
//
//  Created by Alex John on 11/6/13.
//  Copyright (c) 2013 TwoDesks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isSelected) BOOL selected;
@property (nonatomic, getter = isMatched) BOOL matched;

+ (NSInteger)match:(NSArray *)otherCards;

@end
