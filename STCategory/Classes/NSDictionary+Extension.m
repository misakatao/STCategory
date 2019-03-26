//
//  NSDictionary+Extension.m
//  yunbo2016
//
//  Created by MisakaTao on 15/10/22.
//  Copyright © 2015年 misakatao. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (id)objectForSafeKey:(NSString *)key {
    NSArray *keyArr = [self allKeys];
    if (keyArr.count) {
        for (NSString *obj in keyArr) {
            if ([obj isEqualToString:key]) {
                return [self objectForKey:key];
            }
        }
    }
    return @"";
}

@end
