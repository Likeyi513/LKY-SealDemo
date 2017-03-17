//
//  LKYNetWorkTool.h
//  LKY-Object
//
//  Created by 松宇 on 17/3/17.
//  Copyright © 2017年 songyu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void ((^suc)(id json));
@interface LKYNetWorkTool : NSObject


+(void)getWithURL:(NSString *)Url Params:(NSDictionary *)Params succes:(void (^)(id obj))succes failure:(void (^)(NSError *error))failure;

+(void)postWithURL:(NSString *)Url Params:(NSDictionary *)Params succes:(void (^)(id obj))succes failure:(void (^)(NSError *error))failure;
@end
