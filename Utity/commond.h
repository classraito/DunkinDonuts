//
//  commond.h
//  Kline
//
//  Created by zhaomingxi on 14-2-11.
//  Copyright (c) 2014年 zhaomingxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
CGSize getScreenSize();
@interface commond : NSObject
+(NSMutableDictionary *)splitDateStringByYYYYMMDD:(NSString *)_str_date;
+(NSMutableDictionary *)splitTimeStringByHHMMSS:(NSString *)_str_timestamp;
+(NSString *)numberToString:(NSNumber *)_number;
+(NSDate*)dateFromString:(NSString*)str;
+(NSDateComponents*)dateComponentsWithDate:(NSDate*)date;
+(bool)isEqualWithFloat:(float)f1 float2:(float)f2 absDelta:(int)absDelta;
+(NSObject *) getUserDefaults:(NSString *) name;
+(void) setUserDefaults:(NSObject *) defaults forKey:(NSString *) key;
+(BOOL)saveToKeyChain:(NSString *)_str_username passwd:(NSString *)_str_passwd;
+(NSString *)getFromKeyChain:(NSString *)_str_username;
+(BOOL)deleteFromKeyChain:(NSString *)_str_username;
+(BOOL)isEmpty:(id)input;
+(NSString *)stringRemovePercentAndPlus:(NSString *)_str_original;
+(CGRect)useDefaultRatioToScaleFrame:(CGRect)_originalFrame;
+(long)EnCodeCoordinate:(double) para;
+(double)DeCodeCoordinate:(long)totalMilliarcseconds;
+(NSString *)meterToKMIfNeeded:(int)_meters;
@end
