//
//  DataBaseHandle.h
//  UI20 数据库
//
//  Created by 付寒宇 on 15/9/23.
//  Copyright © 2015年 付寒宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@class Home_TravelContent;//游记详情Model
@class Topic_Content;//专题model
@class AreaPlanModel;//行程model
@class AreaSiteModel;//旅行地model
#pragma mark 使用数据库首先需要引入libsqlite3.0FrameWork(框架),然后引入sqlite头文件
@interface DataBaseHandle : NSObject
#pragma mark DataBaseHandle 单例方法
+ (DataBaseHandle *)shareDataBaseHandle;


/**
 *  打开数据库
 */
- (void)openDB;
/**
 *  创建一张表
 *
 *  @param tableName 名字
 */
- (void)createTravelTable;
- (void)createTopicTable;
- (void)createPlanlTable;
- (void)createSiteTable;
/**
 *  插入一个游记信息
 */
- (void)insertTravelDetail:(Home_TravelContent *)travelContent;
/**
 *  插入一个专题信息
 */
- (void)insertTopicDetail:(Topic_Content *)topicContent;
/**
 *  插入一个行程信息
 */
- (void)insertPlanDetail:(AreaPlanModel *)planContent;
/**
 *  插入一个旅行地信息
 */
- (void)insertSiteDetail:(AreaSiteModel *)siteContent;

/**
 *  删除一个信息 根据ID
 */
- (void)deleteTravel:(NSString *)ID;
- (void)deleteTopic:(NSString *)ID;
- (void)deletePlan:(NSString *)ID;
- (void)deleteSite:(NSString *)ID;
/**
 *  查询所有存储信息
 */
- (NSMutableArray *)selectAllTravel;
- (NSMutableArray *)selectAllTopic;
- (NSMutableArray *)selectAllPlan;
- (NSMutableArray *)selectAllSite;
@end
