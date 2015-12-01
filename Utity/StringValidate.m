//
//  StringValidate.m
//  VANCL
//
//  Created by xiaoyue wu on 10-12-10.
//  Copyright 2010 person. All rights reserved.
//
#import "StringValidate.h"
#import "RegexKitLite.h"

 NSString* REG_EMAIL = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
 NSString* REG_MOBILE = @"^(13[0-9]|15[0-9]|18[0-9])\\d{8}$";
 NSString* REG_PHONE = @"^(([0\\+]\\d{2,3}-?)?(0\\d{2,3})-?)?(\\d{7,8})(-(\\d{3,}))?$";


//////////////////////////////////判断密码强度///////////////////////////////////
NSString *REG1 = @"\\d{6,}";//数字
NSString *REG2 = @"[a-zA-Z]{6,}";//字母
NSString *REG3 = @"[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]+";//特殊字符
NSString *REG4 = @"[\\da-zA-Z]*\\d+[a-zA-Z]+[\\da-zA-Z]*";//字母＋数字
NSString *REG5 = @"[-\\d`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*\\d+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]+[-\\d`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*";//特殊字符＋数字
NSString *REG6 = @"[-a-zA-Z`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*[a-zA-Z]+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]+[-a-zA-Z`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*";//字符＋特殊字符
NSString *REG7 = @"[-\\da-zA-Z`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*((\\d+[a-zA-Z]+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]+)|(\\d+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]+[a-zA-Z]+)|([a-zA-Z]+\\d+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]+)|([a-zA-Z]+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]+\\d+)|([-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]+\\d+[a-zA-Z]+)|([-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]+[a-zA-Z]+\\d+))[-\\da-zA-Z`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*";//字符＋特殊字母＋数字
//////////////////////////////////判断密码强度///////////////////////////////////
@implementation StringValidate
+(BOOL)isEmail:(NSString *)input{
	return [input isMatchedByRegex:REG_EMAIL];
}

+(BOOL)isPhoneNum:(NSString *)input{
	return [input isMatchedByRegex:REG_PHONE];
}

+(BOOL)isMobileNum:(NSString *)input{
	return [input isMatchedByRegex:REG_MOBILE];
}
+(BOOL)isEmpty:(NSString *)input
{
    if(!input ||[input isEqual:[NSNull null]] || [input isEqual:@"<null>"] || [input isKindOfClass:[NSNull class] ]
       || ![input isKindOfClass:[NSString class]])
        
        
        return YES;
    
    NSString *ret = [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(ret && ![ret isEqualToString:@""] )
        return NO;
    else
        return YES;
}

+(int)passwdLevel:(NSString *)passwd
{
    NSLog(@"passwd=%@",passwd);
   
    if([passwd isMatchedByRegex:REG7])
    {
        return 3;
    }
    if([passwd isMatchedByRegex:REG6])
    {
        return 3;
    }
    
    if([passwd isMatchedByRegex:REG5])
    {
        return 2;
    }
    
    if([passwd isMatchedByRegex:REG4])
    {
        return 2;
    }
    if([passwd isMatchedByRegex:REG3])
    {
        return 2;
    }
    
    if([passwd isMatchedByRegex:REG2])
    {
        return 1;
    }
    
    if([passwd isMatchedByRegex:REG1])
    {
        return 1;
    }
    return 0;
}

+(NSString *)numberFormat:(float)_number formater:(NSString * )_format type:(int)_type
{
	//NSLog(@"::::::numberFormat:(float)%f formater:(NSString *)%@ type:(int)%d",_number,_format,_type);
	assert(_type==kCFNumberIntType||_type==kCFNumberFloatType);
	assert(_number>=0);
	assert(_format);
    
	CFLocaleRef currentLocale = CFLocaleCopyCurrent();
	CFNumberFormatterRef numberFormatter = CFNumberFormatterCreate
	(NULL, currentLocale, kCFNumberFormatterNoStyle);
	CFStringRef formatString =(__bridge CFStringRef)_format;
	CFNumberFormatterSetFormat(numberFormatter, formatString);
	CFStringRef formattedNumberString;
	if(_type==kCFNumberIntType)
	{
		int _numberInt=(int)_number;
        formattedNumberString = CFNumberFormatterCreateStringWithValue(NULL, numberFormatter, _type, &_numberInt);
	}
	else if(_type==kCFNumberFloatType)
	{
        float _numberFloat=(float)_number;
        formattedNumberString = CFNumberFormatterCreateStringWithValue//TODO: 这里怎么释放?
		(NULL, numberFormatter, _type, &_numberFloat);
	}
	// Memory management
	CFRelease(currentLocale);
	CFRelease(numberFormatter);
    NSString *retVal = (__bridge NSString *)formattedNumberString;
	return [retVal autorelease];
}

+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim {
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([theScanner isAtEnd] == NO) {
            // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
            // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
            // replace the found tag with a space
            //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    
        // trim off whitespace
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}
@end
