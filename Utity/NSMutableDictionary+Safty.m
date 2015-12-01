//
//  NSMutableDictionary+Safty.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/12.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "NSMutableDictionary+Safty.h"

@implementation NSMutableDictionary (Safty)
-(void)setObjectSafty:(id)anObject forKey:(id<NSCopying>)aKey
{
    id _anObject = anObject;
    if(!_anObject)
    {
        _anObject = @"";
        NSLog(@"::::>do exception in %s,%d anObject:%@ key:%@",__FUNCTION__,__LINE__,anObject,aKey);
    }
    [self setObject:_anObject forKey:aKey];
}

@end
