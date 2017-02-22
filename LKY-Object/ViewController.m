//
//  ViewController.m
//  LKY-Object
//
//  Created by 松宇 on 17/2/20.
//  Copyright © 2017年 songyu. All rights reserved.
//

#import "ViewController.h"
#import "LKYFengZhuang.h"
#define KMRect [UIScreen mainScreen].applicationFrame
@interface ViewController ()<UITextViewDelegate>{
    UITextView *NameTextView;
    UITextView *AgeTextView;
    UITextView *SexTextView;
    int n;
    UIButton *closeBtn;
}
@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, assign) NSInteger ageStr;
@property (nonatomic, copy) NSString *sexStr;
@property (nonatomic, copy) NSString *file;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    n = 0;
    UILabel *Namelabel =  [[LKYFengZhuang shareLkYFengZhuang] createLabelFrame:CGRectMake(100, 100, 50, 30) text:@"Name" textColor:[UIColor redColor] textFont:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter backGroupColor:[UIColor blueColor]];
    [self.view addSubview:Namelabel];

    UILabel *Agelabel =  [[LKYFengZhuang shareLkYFengZhuang] createLabelFrame:CGRectMake(180, 100, 50, 30) text:@"Age" textColor:[UIColor redColor] textFont:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter backGroupColor:[UIColor blueColor]];
    [self.view addSubview:Agelabel];
    
    UILabel *Sexlabel =  [[LKYFengZhuang shareLkYFengZhuang] createLabelFrame:CGRectMake(260, 100, 50, 30) text:@"Sex" textColor:[UIColor redColor] textFont:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter backGroupColor:[UIColor blueColor]];
    [self.view addSubview:Sexlabel];
    
    NameTextView = [[UITextView alloc]initWithFrame:CGRectMake(100, 140, 50, 30)];
    NameTextView.delegate  = self;
    NameTextView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:NameTextView];
    
    AgeTextView = [[UITextView alloc]initWithFrame:CGRectMake(180, 140, 50, 30)];
    AgeTextView.delegate  = self;
    AgeTextView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:AgeTextView];
    
    SexTextView = [[UITextView alloc]initWithFrame:CGRectMake(260, 140, 50, 30)];
    SexTextView.delegate  = self;
    SexTextView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:SexTextView];
    

    UIButton *btn = [[LKYFengZhuang shareLkYFengZhuang] createButtonFrame:CGRectMake(100, 250, 80, 80) setImage:nil setbackGroupColor:[UIColor whiteColor] setTitle:@"查询数据库" setTitleColor:[UIColor blackColor] addTarget:self Action:@selector(selectSQLlist)];
    [self.view addSubview:btn];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    UIButton *selectBtn = [[LKYFengZhuang shareLkYFengZhuang]createButtonFrame:CGRectMake(250, 250, 80, 80) setImage:nil setbackGroupColor:[UIColor whiteColor] setTitle:@"删除数据库" setTitleColor:[UIColor blackColor] addTarget:self Action:@selector(select)];
    [self.view addSubview:selectBtn];
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    UIButton *AddBtn = [[LKYFengZhuang shareLkYFengZhuang]createButtonFrame:CGRectMake(100, 360, 80, 80) setImage:nil setbackGroupColor:[UIColor whiteColor] setTitle:@"添加数据" setTitleColor:[UIColor blackColor] addTarget:self Action:@selector(add)];
    [self.view addSubview:AddBtn];
    AddBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    closeBtn = [[LKYFengZhuang shareLkYFengZhuang]createButtonFrame:CGRectMake(250, 360, 80, 80) setImage:nil setbackGroupColor:[UIColor whiteColor] setTitle:@"关闭数据库" setTitleColor:[UIColor blackColor] addTarget:self Action:@selector(closeORopen)];
    [self.view addSubview:closeBtn];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    // 数据库路径
    _file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"lkyDB.sqlist"];
    NSLog(@"数据库路径 %@",_file);
    [[LKYFengZhuang shareLkYFengZhuang] open:_file];
    // 创建 表 SQL语句
    //2.执行sqlite语句
    NSString *createSql = [NSString stringWithFormat:@"create table if not exists 'ListBDD' ('number' integer primary key autoincrement not null,'name' text,'age'integer,'sex' text)"];
    // 执行SQL  语句
    [[LKYFengZhuang shareLkYFengZhuang] updateSQL:createSql];
    
    
}

-(void)selectSQLlist{
    NSArray *result = [[LKYFengZhuang shareLkYFengZhuang] selectAllWithList:@"ListBDD" AndListNumber:4];
    NSLog(@"查询数据库数据-----%@",result);
}

-(void)select{
//     DELETE FROM t_student;
    NSString *sql = @"DELETE FROM ListBDD;";
    [[LKYFengZhuang shareLkYFengZhuang]updateSQL:sql];
    NSLog(@"删除数据库");
}

-(void)add{
    
    // 添加数据 SQL语句  INSERT INTO 't_student' (name, age, height) VALUES ('why', 18, 1.88);
//    NSString *addSql = @"INSERT INTO 'LKY'(name) VALUES ('HAHA')";
    
    NSString *addSql = [NSString stringWithFormat:@"INSERT INTO 'ListBDD'(name,age,sex) VALUES ('%@','%ld','%@')",_nameStr,(long)_ageStr,_sexStr];
    
    [[LKYFengZhuang shareLkYFengZhuang] updateSQL:addSql];
    
    
}
-(void)closeORopen{
    if (n %2 == 0) {
        [[LKYFengZhuang shareLkYFengZhuang] closeDB];
        n ++;
        [closeBtn setTitle:@"打开数据库" forState:UIControlStateNormal];
    }else{
        [[LKYFengZhuang shareLkYFengZhuang] open:_file];
        n ++;
        [closeBtn setTitle:@"关闭数据库" forState:UIControlStateNormal];
    }

}
-(void)textViewDidEndEditing:(UITextView *)textView
{
   
    if ( textView == NameTextView) {
        _nameStr = textView.text;
        NSLog(@"----Name----%@",textView.text);
    }
    if ( textView == AgeTextView) {
        _ageStr = textView.text.integerValue;
        NSLog(@"----Age----%@",textView.text);
    }
    if ( textView == SexTextView) {
        _sexStr = textView.text;
        NSLog(@"----Sex----%@",textView.text);
    }
    
}





















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
