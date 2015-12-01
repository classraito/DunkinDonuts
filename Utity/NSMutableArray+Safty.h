//
//  NSMutableArray+Safty.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/12.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Safty)
{
    
}
- (id)objectAtIndexSafty:(NSUInteger)index;
-(void)addObjectSafty:(id)anObject;
-(void)insertObjectSafty:(id)anObject atIndex:(NSUInteger)index;
@end
