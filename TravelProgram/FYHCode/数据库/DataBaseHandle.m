//
//  DataBaseHandle.m
//  UI20 数据库
//
//  Created by 付寒宇 on 15/9/23.
//  Copyright © 2015年 付寒宇. All rights reserved.
//

#import "DataBaseHandle.h"
#import "Home_TravelContent.h"
#import "Topic_Content.h"
#import "AreaPlanModel.h"
#import "AreaSiteModel.h"
#import "User_Model.h"
@implementation DataBaseHandle
+ (DataBaseHandle *)shareDataBaseHandle{
    static DataBaseHandle *dataBaseHandle = nil;
    if (dataBaseHandle == nil) {
        dataBaseHandle = [[DataBaseHandle alloc]init];
    }
    return dataBaseHandle;
}
//首先,声明一个数据库
static sqlite3 *db;



- (void)openDB{
    //1.找到Document的路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [documentPath stringByAppendingPathComponent:@"travelProgram.sqlite"];
    //判断当前数据库是否已经打开,如果没有打开那么进行打开操作,如果已经打开那么停止当前操作;
    //打开数据库
    if (db) {
//        NSLog(@"数据库已经打开");
        return;
    }
    //打开数据库 使用sqlite3_open
    /**
     *  打开数据库 使用sqlite3_open
     *
     *  @param databasePath.UTF8String 数据库打开的未知,需要转换成UTF8字符串
     *  @param db                      数据库对象
     *
     *  @return 该方法执行结果(int 类型 , 与系统枚举相对应,例如SQLITE_OK 代表执行成功 0);
     */
    int result = sqlite3_open(databasePath.UTF8String, &db);
    if (result == SQLITE_OK) {//数据库打开成功
//        NSLog(@"数据库打开成功%@",databasePath);
    }else{
        NSLog(@"数据库打开失败");
    }
}
- (void)createTravelTable{
    NSString *createTableSQL = @"create table if not exists travelTable (ID text primary key,name text,front_cover_photo_url text,start_date text,days text,photos_count text,userImage text,userName text)";
    int result = sqlite3_exec(db, createTableSQL.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"创建表成功");
    }else{
        NSLog(@"未创建成功%d",result);
    }
}
- (void)createTopicTable{
    NSString *createTableSQL = @"create table if not exists topicTable (ID text primary key,name text,title text,image_url text,distination_id text)";
    int result = sqlite3_exec(db, createTableSQL.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"创建表成功");
    }else{
        NSLog(@"未创建成功%d",result);
    }
}
- (void)createPlanlTable{
    NSString *createTableSQL = @"create table if not exists planTable (ID text primary key,Description text,image_url text,name text,plan_days_count text,plan_nodes_count text)";
    int result = sqlite3_exec(db, createTableSQL.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"创建表成功");
    }else{
        NSLog(@"未创建成功%d",result);
    }
}
- (void)createSiteTable{
    NSString *createTableSQL = @"create table if not exists siteTable (ID text primary key,Description text,image_url text,name text,user_score text)";
    int result = sqlite3_exec(db, createTableSQL.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"创建表成功");
    }else{
        NSLog(@"未创建成功%d",result);
    }
}
/**
 *  插入一个游记信息
  @"create table if not exists travelTable (ID text primary key,name text,front_cover_photo_url text,start_date text,days text,photos_count text,userImage text,userName text)";
 */
- (void)insertTravelDetail:(Home_TravelContent *)travelContent{
    //创建插入的SQL语句
//    NSLog(@"%@ =%@= %@= %@= %@= %@= %@= %@",travelContent.ID,travelContent.name,travelContent.front_cover_photo_url,travelContent.start_date,travelContent.days,travelContent.photos_count,travelContent.userModel.image,travelContent.userModel.name);
    //insert into 表名(字段名称) values (对应字段的值)
    NSString *insertTableSQL = [NSString stringWithFormat:@"INSERT INTO travelTable(ID,name,front_cover_photo_url,start_date,days,photos_count,userImage,userName) VALUES(\'%@\',\'%@\',\'%@\',\'%@\',\'%@\',\'%@\',\'%@\',\'%@\')",travelContent.ID,travelContent.name,travelContent.front_cover_photo_url,travelContent.start_date,travelContent.days,travelContent.photos_count,travelContent.userModel.image,travelContent.userModel.name];
    //执行SQL语句
        int result = sqlite3_exec(db, insertTableSQL.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"信息插入成功");
    }else{
        NSLog(@"插入失败%d",result);
    }
}
/**
 *  插入一个专题信息
 */
- (void)insertTopicDetail:(Topic_Content *)topicContent{
    NSString *insertTableSQL = [NSString stringWithFormat:@"INSERT INTO topicTable(ID,name,title,image_url,distination_id) VALUES(\'%@\',\'%@\',\'%@\',\'%@\',\'%@\')",topicContent.ID,topicContent.name,topicContent.title,topicContent.image_url,topicContent.distination_id];
    //执行SQL语句
    int result = sqlite3_exec(db, insertTableSQL.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"信息插入成功");
    }else{
        NSLog(@"插入失败%d",result);
    }
}
/**
 *  插入一个行程信息
 */
- (void)insertPlanDetail:(AreaPlanModel *)planContent{
    NSString *insertTableSQL = [NSString stringWithFormat:@"INSERT INTO planTable(ID,Description,image_url,name,plan_days_count,plan_nodes_count) VALUES(\'%@\',\'%@\',\'%@\',\'%@\',\'%@\',\'%@\')",planContent.ID,planContent.Description,planContent.image_url,planContent.name,planContent.plan_days_count,planContent.plan_nodes_count];
    //执行SQL语句
    int result = sqlite3_exec(db, insertTableSQL.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"信息插入成功");
    }else{
        NSLog(@"插入失败%d",result);
    }
}
/**
 *  插入一个旅行地信息
 */
- (void)insertSiteDetail:(AreaSiteModel *)siteContent{
    NSString *insertTableSQL = [NSString stringWithFormat:@"INSERT INTO siteTable(ID,Description,image_url,name,user_score) VALUES(\'%@\',\'%@\',\'%@\',\'%@\',\'%@\')",siteContent.ID,siteContent.Description,siteContent.image_url,siteContent.name,siteContent.user_score];
    //执行SQL语句
    int result = sqlite3_exec(db, insertTableSQL.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"信息插入成功");
    }else{
        NSLog(@"插入失败%d",result);
    }
}
- (void)deleteTravel:(NSString *)ID{
    NSString *deleteTableSQL = [NSString stringWithFormat:@"DELETE FROM travelTable WHERE ID = %@",ID];
    
    int result = sqlite3_exec(db, deleteTableSQL.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"Delete成功");
    } else {
        NSLog(@"Delete失败%d",result);
    }
}
- (void)deleteTopic:(NSString *)ID{
    NSString *deleteTableSQL = [NSString stringWithFormat:@"DELETE FROM topicTable WHERE ID = %@",ID];
    
    int result = sqlite3_exec(db, deleteTableSQL.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"Delete成功");
    } else {
        NSLog(@"Delete失败%d",result);
    }
}
- (void)deletePlan:(NSString *)ID{
    NSString *deleteTableSQL = [NSString stringWithFormat:@"DELETE FROM planTable WHERE ID = %@",ID];
    
    int result = sqlite3_exec(db, deleteTableSQL.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"Delete成功");
    } else {
        NSLog(@"Delete失败%d",result);
    }
}
- (void)deleteSite:(NSString *)ID{
    NSString *deleteTableSQL = [NSString stringWithFormat:@"DELETE FROM siteTable WHERE ID = %@",ID];
    
    int result = sqlite3_exec(db, deleteTableSQL.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"Delete成功");
    } else {
        NSLog(@"Delete失败%d",result);
    }
}

/**
 *  查询所有存储信息
 */
- (NSMutableArray *)selectAllTravel{
    NSString *selectTableSQL = [NSString stringWithFormat:@"SELECT * FROM travelTable"];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, selectTableSQL.UTF8String, -1, &stmt, nil);
    NSMutableArray *array = [NSMutableArray array];
    if (result == SQLITE_OK) {
//        NSLog(@"查询成功");
        
        //如果查询成功,对查询结果进行取值操作
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //进入循环, 判定在数据库中存在一条数据
            //查到多少条数据,走多少次循环
            const unsigned char *ID = sqlite3_column_text(stmt, 0);
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            const unsigned char *front_cover_photo_url = sqlite3_column_text(stmt, 2);
            const unsigned char *start_date = sqlite3_column_text(stmt, 3);
            const unsigned char *days = sqlite3_column_text(stmt, 4);
            const unsigned char *photos_count = sqlite3_column_text(stmt, 5);
            const unsigned char *userImage = sqlite3_column_text(stmt, 6);
            const unsigned char *userName = sqlite3_column_text(stmt, 7);
            Home_TravelContent *travelContent = [[Home_TravelContent alloc]init];
            travelContent.ID = [NSString stringWithUTF8String:(const char *)ID];;
            travelContent.name = [NSString stringWithUTF8String:(const char *)name];
            travelContent.front_cover_photo_url = [NSString stringWithUTF8String:(const char *)front_cover_photo_url];
            travelContent.start_date = [NSString stringWithUTF8String:(const char *)start_date];
            travelContent.days = [NSString stringWithUTF8String:(const char *)days];
            travelContent.photos_count = [NSString stringWithUTF8String:(const char *)photos_count];
            travelContent.userModel = [[User_Model alloc]init];
            travelContent.userModel.image = [NSString stringWithUTF8String:(const char *)userImage];
            travelContent.userModel.name = [NSString stringWithUTF8String:(const char *)userName];
            [array addObject:travelContent];
            [travelContent release];
        }
    } else {
        NSLog(@"查询失败%d",result);
    }
    return array;
}
- (NSMutableArray *)selectAllTopic{
    NSString *selectTableSQL = [NSString stringWithFormat:@"SELECT * FROM topicTable"];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, selectTableSQL.UTF8String, -1, &stmt, nil);
    NSMutableArray *array = [NSMutableArray array];
    if (result == SQLITE_OK) {
//        NSLog(@"查询成功");
        
        //如果查询成功,对查询结果进行取值操作
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //进入循环, 判定在数据库中存在一条数据
            //查到多少条数据,走多少次循环
            const unsigned char *ID = sqlite3_column_text(stmt, 0);
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            const unsigned char *title = sqlite3_column_text(stmt, 2);
            const unsigned char *image_url = sqlite3_column_text(stmt, 3);
            const unsigned char *distination_id = sqlite3_column_text(stmt, 4);
            Topic_Content *topicContent = [[Topic_Content alloc]init];
            topicContent.ID = [NSString stringWithUTF8String:(const char *)ID];;
            topicContent.name = [NSString stringWithUTF8String:(const char *)name];
            topicContent.title = [NSString stringWithUTF8String:(const char *)title];
            topicContent.image_url = [NSString stringWithUTF8String:(const char *)image_url];
            topicContent.distination_id = [NSString stringWithUTF8String:(const char *)distination_id];
            [array addObject:topicContent];
            [topicContent release];
        }
    } else {
        NSLog(@"查询失败%d",result);
    }
    return array;
}
- (NSMutableArray *)selectAllPlan{
    NSString *selectTableSQL = [NSString stringWithFormat:@"SELECT * FROM planTable"];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, selectTableSQL.UTF8String, -1, &stmt, nil);
    NSMutableArray *array = [NSMutableArray array];
    if (result == SQLITE_OK) {
//        NSLog(@"查询成功");
        
        //如果查询成功,对查询结果进行取值操作
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //进入循环, 判定在数据库中存在一条数据
            //查到多少条数据,走多少次循环
            const unsigned char *ID = sqlite3_column_text(stmt, 0);
            const unsigned char *Description = sqlite3_column_text(stmt, 1);
            const unsigned char *image_url = sqlite3_column_text(stmt, 2);
            const unsigned char *name = sqlite3_column_text(stmt, 3);
            const unsigned char *plan_days_count = sqlite3_column_text(stmt, 4);
            const unsigned char *plan_nodes_count = sqlite3_column_text(stmt, 5);
            AreaPlanModel *planContent = [[AreaPlanModel alloc]init];
            planContent.ID = [NSString stringWithUTF8String:(const char *)ID];;
            planContent.Description = [NSString stringWithUTF8String:(const char *)Description];
            planContent.image_url = [NSString stringWithUTF8String:(const char *)image_url];
            planContent.name = [NSString stringWithUTF8String:(const char *)name];
            planContent.plan_days_count = [NSString stringWithUTF8String:(const char *)plan_days_count];
            planContent.plan_nodes_count = [NSString stringWithUTF8String:(const char *)plan_nodes_count];
            [array addObject:planContent];
            [planContent release];
        }
    } else {
        NSLog(@"查询失败%d",result);
    }
    return array;
}
- (NSMutableArray *)selectAllSite{
    NSString *selectTableSQL = [NSString stringWithFormat:@"SELECT * FROM siteTable"];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, selectTableSQL.UTF8String, -1, &stmt, nil);
    NSMutableArray *array = [NSMutableArray array];
    if (result == SQLITE_OK) {
//        NSLog(@"查询成功");
        
        //如果查询成功,对查询结果进行取值操作
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //进入循环, 判定在数据库中存在一条数据
            //查到多少条数据,走多少次循环
            const unsigned char *ID = sqlite3_column_text(stmt, 0);
            const unsigned char *Description = sqlite3_column_text(stmt, 1);
            const unsigned char *image_url = sqlite3_column_text(stmt, 2);
            const unsigned char *name = sqlite3_column_text(stmt, 3);
            const unsigned char *user_score = sqlite3_column_text(stmt, 4);
            AreaSiteModel *siteContent = [[AreaSiteModel alloc]init];
            siteContent.ID = [NSString stringWithUTF8String:(const char *)ID];;
            siteContent.Description = [NSString stringWithUTF8String:(const char *)Description];
            siteContent.image_url = [NSString stringWithUTF8String:(const char *)image_url];
            siteContent.name = [NSString stringWithUTF8String:(const char *)name];
            siteContent.user_score = [NSString stringWithUTF8String:(const char *)user_score];
            [array addObject:siteContent];
            [siteContent release];
        }
    } else {
        NSLog(@"查询失败%d",result);
    }
    return array;
}
@end
