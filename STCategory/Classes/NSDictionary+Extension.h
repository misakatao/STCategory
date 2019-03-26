//
//  NSDictionary+Extension.h
//  yunbo2016
//
//  Created by MisakaTao on 15/10/22.
//  Copyright © 2015年 misakatao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

/**
 *  
 *判断 key 在dic 里是否存在
 */

- (id)objectForSafeKey:(NSString *)key;

@end
