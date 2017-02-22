//
//  LKYFengZhuang.m
//  LKY-Object
//
//  Created by 松宇 on 17/2/20.
//  Copyright © 2017年 songyu. All rights reserved.
//

#import "LKYFengZhuang.h"
#import <sqlite3.h>
@implementation LKYFengZhuang

+(instancetype)shareLkYFengZhuang{
    static LKYFengZhuang *Lkyseal = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Lkyseal = [LKYFengZhuang new];
    });
    return Lkyseal;
}

-(UILabel *)createLabelFrame:(CGRect)frame text:(NSString *)textStr textColor:(UIColor *)color  textFont:(UIFont *)font textAlignment:(NSTextAlignment)alignment backGroupColor:(UIColor*)backGroupColor{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = textStr;
    label.textColor = color;
    label.font = font;
    label.backgroundColor = backGroupColor;
    label.textAlignment = alignment;
    return label;
}

-(UIButton *)createButtonFrame:(CGRect)frame setImage:(UIImage *)image setbackGroupColor:(UIColor *)BColor setTitle:(NSString *)str setTitleColor:(UIColor *)Textcolor addTarget:(id)target Action:(SEL)action{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setTitleColor:Textcolor forState:UIControlStateNormal];
    [btn setBackgroundColor:BColor];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

sqlite3 *db;
-(void)open:(NSString *)file{
    if (db) {
        NSLog(@"数据库已开启");
        return;
    }
    int result = sqlite3_open(file.UTF8String, &db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库开启成功");
    }else{
        NSLog(@"数据库打开失败,code = %d",result);
    }
}

-(void)closeDB{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
        db = nil;
    }else{
        NSLog(@"数据库关闭失败,code = %d",result);
    }
}

-(void)updateSQL:(NSString *)SQL{
    char *error = NULL;
    int result = sqlite3_exec(db, SQL.UTF8String, nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"成功");
    }else{
        NSLog(@"失败,code = %d %s",result,error);
    }
}

-(NSArray *)selectAllWithList:(NSString *)list AndListNumber :(NSInteger)num{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    //SQL 语句
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM %@",list];
    //声明一个stmt对象  结构体(伴随指针)
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare(db, selectSQL.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        // 每行都执行查询语句
        while (sqlite3_step(stmt) == SQLITE_ROW) {
        // 如果查询条件匹配 通过sqlite3_column函数取出值.
            NSMutableArray *tempArr = [[NSMutableArray alloc]init];
          
                for (int i = 0; i < num; i++) {
                    const unsigned char *str = sqlite3_column_text(stmt, i);
                    [tempArr addObject:[NSString stringWithUTF8String:(const char *)str]];
                }

            [arr addObject:tempArr];
        }
        // 销毁对象 关闭指针
        sqlite3_finalize(stmt);
    }else{
        NSLog(@"不能正常查询 code = %d ",result);
        // 销毁对象 关闭指针
        sqlite3_finalize(stmt);
    }
    return  arr;
}


































@end
