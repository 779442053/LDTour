//
//  LDHHTTPSessionManager.h
//  LDHMoonAngel
//
//  Created by Daredos on 16/3/20.
//  Copyright © 2016年 LiangDaHong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LDHDownloadProgressBlock)(NSProgress *downloadProgress);
typedef void(^LDHSuccessBlock)         (id responseObject);
typedef void(^LDHFailureBlock)         (NSError   *error);

/*!
 *  @brief 网络管理者
 */
@interface LDHHTTPSessionManager : NSObject

#pragma mark -

#pragma mark - 具体网络请求

/*! 获取主页广告数据 */
+ (void)getAdvertisementDataWithNetIdentifier:(NSString *)netIdentifier
                        downloadProgressBlock:(LDHDownloadProgressBlock)downloadProgressBlock
                                 successBlock:(LDHSuccessBlock)successBlock
                                 failureBlock:(LDHFailureBlock)failureBlock;

/*! 获取主页表格数据*/
+ (void)getMenuTableDataWithNetIdentifier:(NSString *)netIdentifier
                                    start:(int)start
                                    count:(int)count
                    downloadProgressBlock:(LDHDownloadProgressBlock)downloadProgressBlock
                             successBlock:(LDHSuccessBlock)successBlock
                             failureBlock:(LDHFailureBlock)failureBlock;
/*! 登录接口 */
+ (void)loginWithNetIdentifier:(NSString *)netIdentifier
                      userName:(NSString *)userName
                      password:(NSString *)password
         downloadProgressBlock:(LDHDownloadProgressBlock)downloadProgressBlock
                  successBlock:(LDHSuccessBlock)successBlock
                  failureBlock:(LDHFailureBlock)failureBlock;

@end
