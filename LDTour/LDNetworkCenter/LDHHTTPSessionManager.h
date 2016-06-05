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

/*!
 *  @brief 获取主页广告数据
 *
 *  @param netIdentifier         请求标签
 *  @param downloadProgressBlock 进度block
 *  @param successBlock          成功block
 *  @param failureBlock          失败block
 */
+ (void)getAdvertisementDataWithNetIdentifier:(NSString *)netIdentifier
                        downloadProgressBlock:(LDHDownloadProgressBlock)downloadProgressBlock
                                 successBlock:(LDHSuccessBlock)successBlock
                                 failureBlock:(LDHFailureBlock)failureBlock;

+ (void)getMenuTableDataWithNetIdentifier:(NSString *)netIdentifier
                                    start:(int)start
                                    count:(int)count
                    downloadProgressBlock:(LDHDownloadProgressBlock)downloadProgressBlock
                             successBlock:(LDHSuccessBlock)successBlock
                             failureBlock:(LDHFailureBlock)failureBlock;
@end
