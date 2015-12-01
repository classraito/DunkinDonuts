//
//  NSMutableArray+Safty.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/12.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "NSMutableArray+Safty.h"
@implementation NSMutableArray (Safty)
- (id)objectAtIndexSafty:(NSUInteger)index
{
    if (index >= [self count]) {
        NSLog(@"::::>do exception in %s,%d index=%ld",__FUNCTION__,__LINE__,index);
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    return value;
}

-(void)addObjectSafty:(id)anObject
{
    if(!anObject)
    {
        [self addObject:[NSNull null]];
        NSLog(@"::::>do exception in %s,%d anObject:%@",__FUNCTION__,__LINE__,anObject);
        return;
    }
    [self addObject:anObject];
}

-(void)insertObjectSafty:(id)anObject atIndex:(NSUInteger)index
{
    id _anObject = anObject;
    if(!_anObject)
    {
        _anObject = [NSNull null];
        NSLog(@"::::>do exception in %s,%d anObject:%@",__FUNCTION__,__LINE__,anObject);
    }
    if(index<[self count])
    {
        [self insertObject:_anObject atIndex:index];
    }
    else
    {
        NSLog(@"::::>do exception in %s,%d index:%ld anObject%@",__FUNCTION__,__LINE__,index,anObject);
    }
}
@end
