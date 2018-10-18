//
//  HomePageVC.m
//  App
//
//  Created by longcai on 2018/9/8.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#import "HomePageVC.h"
#import "SuspendView.h"
#import "ModelObject.h"

@interface HomePageVC ()

@property (weak, nonatomic) IBOutlet UITableView *homePageTabelView;

@property (strong, nonatomic)  NSMutableArray *dataArray;

@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    SuspendView *jycWindow = [[SuspendView alloc]initWithFrame:CGRectMake(0 , kScreenHeight-150-160, 92, 172) mainImageName:@"蓝色气球" bgcolor:[UIColor clearColor] animationColor:[UIColor colorWithHexString:@"338FFD"]AndSubview:self.view];
    jycWindow.callService = ^{
    };
    [self.view addSubview:jycWindow];
    
    __weak __typeof(&*self)weakSelf = self;
    [weakSelf.homePageTabelView configureHelper:^   (UITableViewProtocolHelper *helper) {
        helper.bindTableView(weakSelf.homePageTabelView, [UITableViewCell class], NO, @"cell").heightForRow(^CGFloat(NSIndexPath *indexPath) {
            return 50;
        }).sectionsNumber(^NSInteger{
            return 1;
        }).rowsNumber(^NSInteger(NSInteger section) {
            return weakSelf.dataArray.count;
        }).configureCell(^(__kindof UITableViewCell *cell, NSIndexPath *indexPath) {
            cell.textLabel.text = weakSelf.dataArray[indexPath.row];
            cell.textLabel.font=[UIFont systemFontOfSize:14];
            cell.textLabel.numberOfLines=0;
        }).didSelectCell(^(NSIndexPath *indexPath) {
            
            UITableViewCell *cell = [weakSelf.homePageTabelView cellForRowAtIndexPath:indexPath];
            
            NSTimeInterval duration = 0.6;
            CAKeyframeAnimation *springAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            springAnimation.values = @[@.85, @1.15, @.9, @1.0,];
            springAnimation.keyTimes = @[@(0.0 / duration), @(0.15 / duration) , @(0.3 / duration), @(0.45 / duration),];
            springAnimation.duration = duration;
            [cell.layer addAnimation:springAnimation forKey:@"SpringAnimationKey"];
            
            if (indexPath.row==0) {
                // 从文件ModelObject读取json对象
                NSString * jsonString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ModelObject" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
                NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

                /************** 解析jsonData **************/
                ModelObject * model = [ModelObject whc_ModelWithJson:jsonData];
                NSLog(@"解析jsonData model = %@\n\n",model);
                
                /************** json -> modelObject **************/
                model = [ModelObject whc_ModelWithJson:jsonString];
                NSLog(@"json -> modelObject model = %@\n\n\n",model);
                
                /************** modelObject -> json **************/
                NSString * modelString = [model whc_Json];
                NSLog(@"modelObject -> json modelString = %@\n\n\n",modelString);
                
                /************** modelObject - > NSDictionary **************/
                NSDictionary * modelDict = [model whc_Dictionary];
                NSLog(@"modelObject - > NSDictionary modelDict = %@\n\n\n",modelDict);
                
                /************** 指定路径只解析Head对象 **************/
                Head * head = [Head whc_ModelWithJson:jsonString keyPath:@"Head"];
                head.testNum = [NSNumber numberWithInt:100];
                {
                    /************** 归档对象 **************/
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:head];
                    
                    /************** 解归档对象 **************/
                    Head * tempHead = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                    NSLog(@"tempHead.testNum = %@",tempHead.testNum);
                }
                NSLog(@"指定路径只解析Head对象 head = %@\n\n\n",head);
                
                /************** 指定路径只解析ResponseBody对象 **************/
                ResponseBody * body = [ResponseBody whc_ModelWithJson:jsonString keyPath:@"ResponseBody"];
                NSLog(@"指定路径只解析ResponseBody对象 ResponseBody = %@\n\n\n",body);
                
                /************** 指定路径只解析PolicyRuleList集合中第一个对象 **************/
                PolicyRuleList * rule = [PolicyRuleList whc_ModelWithJson:jsonString keyPath:@"ResponseBody.PolicyRuleList[10]"];
                NSLog(@"指定路径只解析PolicyRuleList集合中第一个对象 rule = %@\n\n\n",rule);
                
                /************** 归档对象 **************/
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
                
                /************** 解归档对象 **************/
                ModelObject * tempModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                NSLog(@"tempModel = %@",tempModel);
                
                /************** 复制对象 **************/
                ModelObject * copyModel = model.copy;
                NSLog(@"copyModel = %@",copyModel);
                
            }else if (indexPath.row==1){
                RootNavigationController *loginNavi =[[RootNavigationController alloc] initWithRootViewController:[[RootWebViewController alloc] initWithUrl:@"http://www.baidu.com"]];
                [self presentViewController:loginNavi animated:YES completion:nil];
                
            }
        });
    }];
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
        [_dataArray addObject:@"「快速把json/xml数据转换生成对应模型类属性」"];
        [_dataArray addObject:@"「打开web地址,带进度条,带二阶返回按钮」"];
    }
    return _dataArray;
}

@end
