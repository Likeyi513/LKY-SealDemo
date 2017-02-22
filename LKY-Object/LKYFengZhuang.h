//
//  LKYFengZhuang.h
//  LKY-Object
//
//  Created by 松宇 on 17/2/20.
//  Copyright © 2017年 songyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 1.#pragma mark 创建数据库路径
 NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"lkyDB.sqlist"];
 语法说明
 lkyDB.sqlist : 数据库的名字
 
 
 2.#pragma mark 创建表 语句
 NSString *createSql = @"CREATE TABLE IF NOT EXISTS 'LKY'(id_number INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'name' TEXT)";
 语法说明
 CREATE TABLE :  创建表的关键字
 IF NOT EXISTS:  表不存在就创建
 'LKY'        :  表的名字
 id_number INTEGER: 有一个ID字段,类型是INTEGER
 PRIMARY KEY  :  主键
 AUTOINCREMENT:  自动增加
 NOT NULL     :  不允许为空
 
 
 3.#pragma mark 增加数据 语句
 NSString *addSql = @"INSERT INTO 't_student' (name, age, height) VALUES ('why', 18, 1.88)";
 语法说明
 INSERT INTO: 插入数据
 't_student': 在哪一个表中插入数据
 (name, age, height): 给哪些字段插入数据
 VALUES ('why', 18, 1.88): 插入的具体值
 
 
 4.#pragma mark 更新数据 语句
 NSString *addSql = @"UPDATE t_student SET name = 'me' WHERE age = 14";
 语法说明
 UPDATE: 更新数据
 't_student': 在哪一个表中更新数据
 SET 字段 = '值': 更新怎样的数据  (更新字段为name 的值变为 me )
 WHERE 条件判断: 更新哪些数据     (更新字段为name 并且 age = 14 的值变为 me )
 
 
 5.#pragma mark 删除数据 语句
 DELETE FROM t_student;
 DELETE FROM t_student WHERE age < 30;
 语法说明
 DELETE FROM: 从表中删除数据
 t_student : 表名
 可以跟条件也可以不跟:不跟表示删除所有的数据
 
 6.#pragma mark  查询语句 语句
 基本查询(查询整个表格)
 SELECT * FROM t_student;
 查询某些字段（查询name和age两个字段）
 SELECT name, age FROM t_student;
 通过条件判断来查询对应的数据(年龄大于等于18)
 SELECT * FROM t_student WHERE age >= 18;
 通过条件判断来查询对应的数据(名字以i开头),使用like关键字(模糊查询)
 SELECT * FROM t_student WHERE name like '%i%';
 
 计算个数
 计算一共多少列
 SELECT count(*) FROM t_student;
 计算某一个列个数
 SELECT count(age) FROM t_student;
 
 排序
 升序 ASC (默认是升序)
 SELECT * FROM t_student ORDER BY age;
 降序 DESC
 SELECT * FROM t_student ORDER BY age DESC;
 按照年龄升序排序,如果年龄相同,按照名字的降序排列
 SELECT * FROM t_student ORDER BY age,name DESC;
 
 起别名
 给列起别名(as可以省略)
 SELECT name AS myName, age AS myAge FROM t_student;
 给表起别名
 SELECT s.name, s.age FROM t_student as s;
 
 limit
 SELECT * FROM t_student LIMIT 数字1,数字2;
 跳过前9条数据，再查询3条数据
 SELECT * FROM t_student LIMIT 9, 3;
 跳过0条数据,取5条数据
 SELECT * FROM t_student LIMIT 5;

 
 */

@interface LKYFengZhuang : NSObject

// 单例
+(instancetype)shareLkYFengZhuang;

// Label
-(UILabel *)createLabelFrame:(CGRect)frame text:(NSString*)textStr textColor:(UIColor*)color  textFont:(UIFont*)font textAlignment:(NSTextAlignment)alignment backGroupColor:(UIColor*)backGroupColor;


// Button
-(UIButton *)createButtonFrame:(CGRect)frame setImage:(UIImage*)image setbackGroupColor:(UIColor*)BColor setTitle:(NSString*)str setTitleColor:(UIColor*)Textcolor addTarget:(id)target Action:(SEL)action;

//---------------------------------------------------------------------------------------------

/*  打开数据库
 *  file 数据库路径
 */
-(void)open:(NSString *)file;

// 关闭数据库
-(void)closeDB;

/*  增删改
 *  SQL 要增删改的数据
 */
-(void)updateSQL:(NSString *)SQL;

/*  查询
 *  list 表名
 *  num  查询每条数据的第几列 (num = 3   3列之前全部查询)
 */
-(NSArray *)selectAllWithList:(NSString *)list AndListNumber:(NSInteger)num;

















@end
