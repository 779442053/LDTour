//
//  LDHHTTPSessionManager.h
//  LDHMoonAngel
//
//  Created by Daredos on 16/3/20.
//  Copyright © 2016年 LiangDaHong. All rights reserved.
//

/*!
 1. 添加token等公共参数 (ok)。
 2. 登录过期检测        (ok)。
 3. 登录界面处理        (ok)。
 4. 登录成功以后继续请求失败的请求 (暂时是自动执行最后一次失败的网络请求)。
 
    (部门请求不允许自动请求，当一次发出多个网络请求时失败的请求处理问题 是否全部请求都需要缓存起来，如果缓存了一个网络请求 但是这个请求的业务已经dealloc时应该怎么样处理)
 5. 缓存问题 (由于数据的实时性问题，暂不处理数据缓存问题，需要由具体的业务来进行处理，可使用 YYCache 对缓存进行处理)。
 */

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

+ (void)getWxarticleCategoryWithNetIdentifier:(NSString *)netIdentifier
                        downloadProgressBlock:(LDHDownloadProgressBlock)downloadProgressBlock
                                 successBlock:(LDHSuccessBlock)successBlock
                                 failureBlock:(LDHFailureBlock)failureBlock;

+ (void)getWxarticleListRequestByCIDWithCid:(NSString *)cid
                                      start:(int)start
                                      count:(int)count
                              netIdentifier:(NSString *)netIdentifier
                      downloadProgressBlock:(LDHDownloadProgressBlock)downloadProgressBlock
                               successBlock:(LDHSuccessBlock)successBlock
                               failureBlock:(LDHFailureBlock)failureBlock;
/*! 注册接口 */
+ (void)registerWithNetIdentifier:(NSString *)netIdentifier
                         userName:(NSString *)userName
                         password:(NSString *)password
            downloadProgressBlock:(LDHDownloadProgressBlock)downloadProgressBlock
                     successBlock:(LDHSuccessBlock)successBlock
                     failureBlock:(LDHFailureBlock)failureBlock;
@end
