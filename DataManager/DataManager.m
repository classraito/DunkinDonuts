//
//  DataManager.m
//  MyStock
//
//  Created by Ryan Gong on 15/9/11.
//  Copyright (c) 2015年 Ryan Gong. All rights reserved.
//

#import "DataManager.h"
#import "Global.h"
static DataManager *manager;
@implementation DataManager
@synthesize dic_data;
+(id)alloc
{
    @synchronized(self)     {
        NSAssert(manager == nil, @"企圖創建一個singleton模式下的DataManager");
        return [super alloc];
    }
    return nil;
}


+(DataManager *)sharedManager//用这个方法来初始化DataManager
{
    @synchronized(self)     {
        if(!manager)
        {
            manager=[[DataManager alloc]init];
            manager.dic_data = [[NSMutableDictionary alloc] init];
            return manager;
        }
    }
    return manager;
}

-(void)clearAllData
{
    [dic_data removeAllObjects];
    
}

-(void)clearDataForKey:(NSString *)_str_url
{
    NSString *_str_key = [NSString md5:_str_url];
    if(![[dic_data allKeys] containsObject:_str_key])
        return;
    [dic_data removeObjectForKey:_str_key];
}

-(void)saveData:(NSMutableDictionary *)_dic_json info:(NSMutableDictionary *)_dic_info
{
    NSString *_str_url = [_dic_info objectForKey:@"url"];
    [dic_data setObject:_dic_json forKey:[NSString md5:_str_url]];
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_UpdateData object:_dic_info];//通知每个viewcontroller 已经收到新数据
//    NSLog(@"::::>%s %d %@",__FUNCTION__,__LINE__,dic_data);
}

-(NSMutableDictionary *)getDataByUrl:(NSString *)_str_url
{
    if(![[dic_data allKeys] containsObject:[NSString md5:_str_url]])
        return nil;
    
    NSMutableDictionary *_dic_json = [dic_data objectForKey:[NSString md5:_str_url]];
//    NSLog(@"::::>%s %d %@",__FUNCTION__,__LINE__,_dic_json);
    if(_dic_json && [_dic_json isKindOfClass:[NSMutableDictionary class]])
    {
        return _dic_json;
    }
    return nil;
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    dic_data = nil;
}
@end
