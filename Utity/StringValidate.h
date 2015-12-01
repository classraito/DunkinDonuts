//
//  StringValidate.h
//  VANCL
//
//  Created by xiaoyue wu on 10-12-10.
//  Copyright 2010 person. All rights reserved.
//

#import <Foundation/Foundation.h>

extern  NSString* REG_EMAIL;
extern  NSString* REG_PHONE;
extern  NSString* REG_MOBILE;
@interface StringValidate : NSObject {

}
+(BOOL)isEmail:(NSString *)input;
+(BOOL)isPhoneNum:(NSString *)input;
+(BOOL)isMobileNum:(NSString *)input;
+(BOOL)isEmpty:(NSString *)input;
+(int)passwdLevel:(NSString *)passwd;

+(NSString *)numberFormat:(float)_number formater:(NSString * )_format type:(int)_type;
+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim;
@end
