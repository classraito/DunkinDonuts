//
//  DataManager.h
//  MyStock
//
//  Created by Ryan Gong on 15/9/11.
//  Copyright (c) 2015年 Ryan Gong. All rights reserved.
//

#import <Foundation/Foundation.h>
/*一个简易的持久化，读取数据的类
 
 它存储从NetworkManager请求来的JSON dictionary
 
 */
#define KEY_ACCESSTOKEN @"KEY_DUNKIN_ACCESSTOKEN"
#define KEY_ALIAS @"KEY_DUNKIN_ALIAS"
#define KEY_USERID @"KEY_DUNKIN_USERID"

#define Notification_UpdateData @"Notification_UpdateData"
#define Notification_UpdateFailed @"Notification_UpdateFailed"
@interface DataManager : NSObject
{
    
}
@property(nonatomic,strong)NSMutableDictionary *dic_data;
+(DataManager *)sharedManager;//用这个方法来初始化DataManager
-(void)saveData:(NSMutableDictionary *)_dic_json info:(NSMutableDictionary *)_dic_info;
-(NSMutableDictionary *)getDataByUrl:(NSString *)_str_url;
-(void)clearAllData;
-(void)clearDataForKey:(NSString *)_str_url;
@end
