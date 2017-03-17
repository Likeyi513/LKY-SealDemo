//
//  LKYNetWorkTool.m
//  LKY-Object
//
//  Created by 松宇 on 17/3/17.
//  Copyright © 2017年 songyu. All rights reserved.
//

#import "LKYNetWorkTool.h"
#import <AFNetworking.h>
@implementation LKYNetWorkTool

+(void)getWithURL:(NSString *)Url Params:(NSDictionary *)Params succes:(void (^)(id))succes failure:(void (^)(NSError *))failure{
    
    // 获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:Url parameters:Params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (succes) {
            succes(responseObject); // 成功
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);    // 失败
        }
    }];
    
}
+(void)postWithURL:(NSString *)Url Params:(NSDictionary *)Params succes:(void (^)(id))succes failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr POST:Url parameters:Params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (succes) {
            succes(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}
@end

