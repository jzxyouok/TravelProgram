//
//  MyPageViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/21.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "MyPageViewController.h"
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import "AreaEnterNavigationBar.h"
#import "MyPageCell.h"
#import "CollectionViewController.h"
#import "StatementViewController.h"
#import <MessageUI/MessageUI.h>
#import <SDImageCache.h>
@interface MyPageViewController ()<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
@property (nonatomic,retain)AreaEnterNavigationBar *customBar;
@property (nonatomic,retain)NSArray *contentArr;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)UIAlertController *picAlert;
@property (nonatomic,retain)UIAlertController *diaryAlert;
@end

@implementation MyPageViewController
- (void)dealloc
{
    [_picAlert release];
    [_diaryAlert release];
    [_contentArr release];
    [_customBar release];
    [_tableView release];
    [super dealloc];
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setHidesBottomBarWhenPushed:YES];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.8824 green:0.9059 blue:0.9333 alpha:1.0]];
    //创建文字数组
    self.contentArr = [NSArray arrayWithObjects:@"我的收藏",@"清除图片缓存",@"清除文章缓存",@"特别声明",@"反馈问题", nil];
    //创建TableView
    [self createTableView];
    //创建自定义navBar
    [self createCustomBar];
    [self createDiaryAlertController];
    [self createPicAlertController];
    
}
//创建TableView
- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, kWidth, kHeight - 44) style:UITableViewStyleGrouped];
    [self.tableView registerClass:[MyPageCell class] forCellReuseIdentifier:@"myPageCell"];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.8824 green:0.9059 blue:0.9333 alpha:1.0]];
    [self.tableView setDelegate:self];
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.view addSubview:self.tableView];
    [_tableView release];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 3 : 2;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myPageCell" forIndexPath:indexPath];
    [cell.contentLabel setText:_contentArr[indexPath.section * 3 + indexPath.row]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    if (indexPath.section == 0 && indexPath.row == 1) {
        [cell.moreLabel setText:[NSString stringWithFormat:@"%ldM",[[SDImageCache sharedImageCache] getSize] / 1024 / 1024]];
    } else if (indexPath.section == 0 && indexPath.row == 2){
        NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
        [cell.moreLabel setText:[NSString stringWithFormat:@"%.1fM",[self floatWithPath:diaryInfo]]];
    }
    return cell;
}
//每个cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 38;
}
//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        CollectionViewController *collectionViewController = [[CollectionViewController alloc]init];
        [self.navigationController pushViewController:collectionViewController animated:YES];
        [collectionViewController release];
    } else if (indexPath.section == 0 && indexPath.row == 1){
            [self cleanPic];
    } else if (indexPath.section == 0 && indexPath.row == 2){
        [self cleanDiary];
    } else if (indexPath.section == 1 && indexPath.row == 1){
        if ([MFMailComposeViewController canSendMail]) { // 用户已设置邮件账户
            [self sendEmailAction]; // 调用发送邮件的代码
        } else{
            UIAlertController *cantSendMail = [UIAlertController alertControllerWithTitle:@"您没有设置系统邮件账户" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [cantSendMail addAction:cancelAction];
            [self presentViewController:cantSendMail animated:YES completion:nil];
        }
    }else if (indexPath.section == 1 && indexPath.row == 0){
        StatementViewController *statementViewController = [[StatementViewController alloc]init];
        [self.navigationController pushViewController:statementViewController animated:YES];
        [statementViewController release];
    }
}
- (void)createDiaryAlertController{
    self.diaryAlert = [UIAlertController alertControllerWithTitle:@"您是否要清除缓存的所有文章" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
        if ([[NSFileManager defaultManager]fileExistsAtPath:diaryInfo]) {
            [[NSFileManager defaultManager] removeItemAtPath:diaryInfo error:nil];
            [[NSFileManager defaultManager] createDirectoryAtPath:diaryInfo withIntermediateDirectories:YES attributes:nil error:nil];
            [self.tableView reloadData];
        }
    }];
    [self.diaryAlert addAction:cancelAction];
    [self.diaryAlert addAction:okAction];
}
- (void)createPicAlertController{
    self.picAlert = [UIAlertController alertControllerWithTitle:@"您是否要清除缓存的所有图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        [self.tableView reloadData];
    }];
    [self.picAlert addAction:cancelAction];
    [self.picAlert addAction:okAction];
}
- (void)cleanDiary{

    [self presentViewController:self.diaryAlert animated:YES completion:nil];

}
- (void)cleanPic{

    [self presentViewController:self.picAlert animated:YES completion:nil];
}
- (void)sendEmailAction
{
    // 邮件服务器
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
    
    // 设置邮件主题
    [mailCompose setSubject:@"<行者日记> BUG用户反馈"];
    
    // 设置收件人
    [mailCompose setToRecipients:@[@"fuhanyumail@gmail.com"]];
    // 设置抄送人
    [mailCompose setCcRecipients:@[@"fuhanyujob@163.com"]];
    
    /**
     *  设置邮件的正文内容
     */
    NSString *emailContent = @"非常感谢您愿意对我们进行问题的反馈，我们在收到反馈后会立即对您反馈的问题做出处理，再次感谢您的支持与理解！";
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    
    // 弹出邮件发送视图
    [self presentViewController:mailCompose animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: // 用户取消编辑
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent: // 用户点击发送
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
    }
    
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}


//创建自定义bar
- (void)createCustomBar{
    self.customBar = [[AreaEnterNavigationBar alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.customBar.titleView setText:@"我的"];
    [self.customBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customBar];
    [_customBar release];
}
- (void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)floatWithPath:(NSString *)path
{
    CGFloat num = 0;
    NSFileManager *man = [NSFileManager defaultManager];
    if ([man fileExistsAtPath:path]) {
        NSEnumerator *childFile = [[man subpathsAtPath:path] objectEnumerator];
        NSString *fileName;
        while ((fileName = [childFile nextObject]) != nil) {
            NSString *fileSub = [path stringByAppendingPathComponent:fileName];
            num += [self fileSizeAtPath:fileSub];
        }
    }
    return num / (1024.0 * 1024.0);
}

//计算单个文件大小
- (long long)fileSizeAtPath:(NSString *)file
{
    NSFileManager *man = [NSFileManager defaultManager];
    if ([man fileExistsAtPath:file]) {
        return [[man attributesOfItemAtPath:file error:nil] fileSize];
    }
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
