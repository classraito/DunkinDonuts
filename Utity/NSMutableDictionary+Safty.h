//
//  NSMutableDictionary+Safty.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/12.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Safty)
{
    
}
-(void)setObjectSafty:(id)anObject forKey:(id<NSCopying>)aKey;
@end
