//
//  UIDevice+IdentifierAddition.m
//  MyStock
//
//  Created by Ryan Gong on 15/9/9.
//  Copyright (c) 2015年 Ryan Gong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UIDevice+IdentifierAddition.h"
#import "NSString+MD5.h"


#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)

@interface UIDevice(Private)

- (NSString *) macaddress;

@end

@implementation UIDevice (IdentifierAddition)


#pragma mark - Private Methods
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to erica sadun & mlamb.
- (NSString *) macaddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

#pragma mark - uniqueDeviceIdentifier
- (NSString *) uniqueDeviceIdentifier{
    
    if(IS_IOS_7){
        NSString *identifierForVendor = [NSString stringWithFormat:@"%@",[[[UIDevice currentDevice]identifierForVendor]UUIDString]];
        NSLog(@"identifierForVendor=%@",identifierForVendor);
        return identifierForVendor;
    }else{//IOS7 以上使用udid
        NSString *macaddress = [[UIDevice currentDevice] macaddress];
        NSLog(@"macaddress = %@",macaddress);
        return macaddress;
    }//IOS7以下使用mac地址
}

@end