//
//  FGIPManager.m
//  Autotrader_Iphone
//
//  Created by rui.gong on 11-5-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FGIPManager.h"
#import "IPAddress.h"

@implementation FGIPManager

@end
extern void getMyIPInfo()
{
    InitAddresses();
    GetIPAddresses();
    GetHWAddresses();
    
    int i;
    
    for (i=0; i<MAXADDRS; ++i)
    {
        static unsigned long localHost = 0x7F000001;            // 127.0.0.1
        unsigned long theAddr;
        
        theAddr = ip_addrs[i];
        
        if (theAddr == 0) break;
        if (theAddr == localHost) continue;
        
        NSLog(@"Name: %s MAC: %s IP: %s\n", if_names[i], hw_addrs[i], ip_names[i]);
        
        //decided what adapter you want details for
        if (strncmp(if_names[i], "en", 2) == 0)
        {
            NSLog(@"Adapter en has a IP of %@", [NSString stringWithFormat:@"%s", ip_names[i]]);
        }
    }
    
}