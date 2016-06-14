//
//  LDHHTTPSessionManager.m
//  LDHMoonAngel
//
//  Created by Daredos on 16/3/20.
//  Copyright © 2016年 LiangDaHong. All rights reserved.
//

#import "LDHHTTPSessionManager.h"
#import "AFNetworking.h"
#import "LDNetworkInterface-Header.h"
#import "LDAPPCacheManager.h"
#import "LDAertLoginVC.h"
#import "UIApplication+BMExtension.h"
#import <MobAPI/MobAPI.h>

#define kBASE_URL            @""
#define kTimeoutInterval     10.0f

@interface LDHHTTPSessionManager () <UIAlertViewDelegate>

@property (strong, nonatomic) NSMutableArray <NSDictionary<NSString *,NSURLSessionDataTask *> *> *networkingManagerArray;

@property (strong, nonatomic) AFHTTPSessionManager *mager;
@property (assign, nonatomic) BOOL alertLogin;

@property (copy, nonatomic) dispatch_block_t tokenBlock;

@end

@implementation LDHHTTPSessionManager

#pragma mark -

#pragma mark -

- (instancetype)init {
    
    if (self = [super init]) {
        _networkingManagerArray = [@[] mutableCopy];

        self.mager = (kBASE_URL.length > 0) ?
        [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBASE_URL]]
        : [[AFHTTPSessionManager alloc] init];
        AFHTTPRequestSerializer *requestSerializerNotCache = [AFHTTPRequestSerializer serializer];
        requestSerializerNotCache.timeoutInterval = kTimeoutInterval;
        self.mager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

+ (instancetype)sharedHTTPSessionManager {
    
    static  LDHHTTPSessionManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager  = [[self  alloc] init];
    });
    return sessionManager;
}

#pragma mark - get

- (void)get:(NSString *)urlString parameters:(id)parameter netIdentifier:(NSString *)netIdentifier progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock success:(void (^)(id responseObject))successBlock failure:(void (^)(NSError   *error))failureBlock {
    
    // 获取网络管理者
    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameter netIdentifier:netIdentifier progress:nil success:successBlock failure:failureBlock ];

    if (!sessionManager) {
        return;
    }

    NSURLSessionDataTask *task = [sessionManager GET:urlString parameters:parameter progress:downloadProgressBlock success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        successBlock ? successBlock(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }

        failureBlock ? failureBlock(error) : nil;
    }];
    
    if (netIdentifier) {
        [self.networkingManagerArray addObject:@{netIdentifier:task}];
    }
}

#pragma mark - post

- (void)post:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier progress:(LDHDownloadProgressBlock)downloadProgressBlock success:(LDHSuccessBlock)successBlock failure:(LDHFailureBlock)failureBlock {
    
    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameters netIdentifier:netIdentifier progress:downloadProgressBlock success:successBlock failure:failureBlock ];
    
    if (!sessionManager) {
        
        return;
    }

    NSURLSessionDataTask *task = [sessionManager POST:urlString parameters:parameters progress:successBlock success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        successBlock ? successBlock(responseObject) : nil;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        failureBlock ? failureBlock(error) : nil;
    }];
    if (netIdentifier) {
        [self.networkingManagerArray addObject:@{netIdentifier:task}];
    }
}

#pragma mark - cancel

- (void)cancelAllNetworking {
    
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString  *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        [task cancel];
    }
    [self.networkingManagerArray removeAllObjects];
}
- (void)cancelNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray {
    
    for (NSString *netIdentifier in netIdentifierArray) {
        [self cancelNetworkingWithNetIdentifier:netIdentifier];
    }
}

- (void)cancelNetworkingWithNetIdentifier:(NSString *)netIdentifier {
    if (!netIdentifier) {
        return;
    }
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        if ([key isEqualToString:netIdentifier]) {
            NSURLSessionDataTask *task = dict[key];
            [task cancel];
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
            return;
        }
    }
}

- (NSArray <NSString *>*)getUnderwayNetIdentifierArray {
    
    NSMutableArray *muarr = [@[] mutableCopy];
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        [muarr addObject:key];
    }
    return muarr;
}

#pragma mark - suspend

- (void)suspendAllNetworking {
    
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString  *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        if (task.state == NSURLSessionTaskStateRunning) {
            [task suspend];
        }
    }
}

- (void)suspendNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray {
    
    for (NSString *netIdentifier in netIdentifierArray) {
        [self suspendNetworkingWithNetIdentifier:netIdentifier];
    }
    
}

- (void)suspendNetworkingWithNetIdentifier:(NSString *)netIdentifier {
    
    if (!netIdentifier) {
        return;
    }
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        if ([key isEqualToString:netIdentifier]) {
            NSURLSessionDataTask *task = dict[key];
            [task suspend];
        }
    }
}

- (NSArray<NSString *> *)getSuspendNetIdentifierArray {
    
    NSMutableArray *muarr = [@[] mutableCopy];
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        
        if (task.state == NSURLSessionTaskStateSuspended) {
            [muarr addObject:key];
        }
    }
    return muarr;
}

#pragma  mark - resume

- (void)resumeAllNetworking {
    
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString  *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        if (task.state == NSURLSessionTaskStateSuspended) {
            [task resume];
        }
    }
}

- (void)resumeNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray {
    
    for (NSString *netIdentifier in netIdentifierArray) {
        
        [self resumeNetworkingWithNetIdentifier:netIdentifier];
    }
}

- (void)resumeNetworkingWithNetIdentifier:(NSString *)netIdentifier {
    
    if (!netIdentifier) {
        return;
    }
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        if ([key isEqualToString:netIdentifier]) {
            NSURLSessionDataTask *task = dict[key];
            if (task.state == NSURLSessionTaskStateSuspended) {
                [task resume];
            }
        }
    }
}

#pragma  mark - 私有方法

- (AFHTTPSessionManager *)getManagerWithWithPath:(const NSString *)path
                                      parameters:(id)parameters
                                   netIdentifier:(NSString *)netIdentifier
                                        progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                         success:(void (^)(id responseObject))successBlock
                                         failure:(void (^)(NSError   *error))failureBlock {
    
    /*! 当前的请求是否正在进行 */
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        if ([key isEqualToString:netIdentifier]) {
            // 当前的请求正在进行,拦截请求
            return nil;
        }
    }
    
    /*! 检测是否有网络 */
    AFNetworkReachabilityStatus net = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if ( net == AFNetworkReachabilityStatusNotReachable) {
        // 没有网络
        NSError *cancelError = [NSError errorWithDomain:@"没有网络,请检测网络!" code:(-12002) userInfo:nil];
        ! failureBlock ? : failureBlock(cancelError);
        return nil;
    }
    
    /* 是否可以发起api 1.是否登录  2.token是否过期 ... */
    LDAPPCacheManager *cacheManager = [LDAPPCacheManager sharedAPPCacheManager];
    
    if (!cacheManager.isLogin) {
        NSLog(@"没登录");
        // 没有网络
         NSError *cancelError = [NSError errorWithDomain:@"没有登录,请先登录!" code:(-12003) userInfo:nil];
         ! failureBlock ? : failureBlock(cancelError);
        [SVProgressHUD dismiss];
        
        if (!self.alertLogin) {
            DAAlertAction *loginAction = [DAAlertAction actionWithTitle:@"去登录" style:DAAlertActionStyleDefault handler:^{
                self.alertLogin = NO;
                [LDAertLoginVC alertLoginVC];
            }];
            DAAlertAction *noAction = [DAAlertAction actionWithTitle:@"暂不登录" style:DAAlertActionStyleDestructive handler:^{
                self.alertLogin = NO;
            }];
            [DAAlertController showAlertOfStyle:1 inViewController:[UIApplication bm_topViewController] withTitle:@"请先登录" message:nil actions:@[noAction,loginAction]];
            self.alertLogin = YES;
        }

        self.tokenBlock = ^{
            [self get:(NSString *)path parameters:parameters netIdentifier:netIdentifier progress:downloadProgressBlock success:successBlock failure:failureBlock];
        };
        return nil;
    }
    NSLog(@"已经登录  token = %@",cacheManager.token);

    return  self.mager;
}

#pragma mark - 具体网络请求

+ (void)getAdvertisementDataWithNetIdentifier:(NSString *)netIdentifier
                        downloadProgressBlock:(LDHDownloadProgressBlock)downloadProgressBlock
                                 successBlock:(LDHSuccessBlock)successBlock
                                 failureBlock:(LDHFailureBlock)failureBlock {
    
    [[self sharedHTTPSessionManager] get:kLDMENUM_ADVERTISEMENT_INTERFACE_URL parameters:nil netIdentifier:netIdentifier progress:downloadProgressBlock success:successBlock failure:failureBlock];
}

+ (void)getMenuTableDataWithNetIdentifier:(NSString *)netIdentifier
                                    start:(int)start
                                    count:(int)count
                    downloadProgressBlock:(LDHDownloadProgressBlock)downloadProgressBlock
                             successBlock:(LDHSuccessBlock)successBlock
                             failureBlock:(LDHFailureBlock)failureBlock {
    
    NSString *url = [NSString stringWithFormat:kLDMENUM_TABLE_INTERFACE_URL,(count),(start)];
    [[self sharedHTTPSessionManager] get:url parameters:nil netIdentifier:netIdentifier progress:downloadProgressBlock success:successBlock failure:failureBlock];
}

+ (void)loginWithNetIdentifier:(NSString *)netIdentifier
                      userName:(NSString *)userName
                      password:(NSString *)password
         downloadProgressBlock:(LDHDownloadProgressBlock)downloadProgressBlock
                  successBlock:(LDHSuccessBlock)successBlock
                  failureBlock:(LDHFailureBlock)failureBlock {

    [MobAPI sendRequest:[MOBAUserCenter userLoginRequestByUsername:userName password:password] onResult:^(MOBAResponse *response) {
        if (response.error) {
            failureBlock ? failureBlock(response.error) : nil;
        }else{
            LDAPPCacheManager *cacheManager = [LDAPPCacheManager sharedAPPCacheManager];
            [cacheManager saveLoginUserInfoWithToken:response.responder[@"token"]];
            successBlock ? successBlock(response.responder) : nil;
            [[self sharedHTTPSessionManager] tokenBlock] ? [[self sharedHTTPSessionManager] tokenBlock]() : nil;
            LDHHTTPSessionManager *s = [self sharedHTTPSessionManager];
            s.tokenBlock = nil;
        }
    }];
}
+ (void)registerWithNetIdentifier:(NSString *)netIdentifier
                         userName:(NSString *)userName
                         password:(NSString *)password
            downloadProgressBlock:(LDHDownloadProgressBlock)downloadProgressBlock
                     successBlock:(LDHSuccessBlock)successBlock
                     failureBlock:(LDHFailureBlock)failureBlock {
    
    [MobAPI sendRequest:[MOBAUserCenter userRigisterRequestByUsername:userName password:password] onResult:^(MOBAResponse *response) {
        if (response.error) {
            failureBlock ? failureBlock(response.error) : nil;
        }else{
            successBlock ? successBlock(response.responder) : nil;
        }
    }];
}

+ (void)getWxarticleCategoryWithNetIdentifier:(NSString *)netIdentifier
                        downloadProgressBlock:(LDHDownloadProgressBlock)downloadProgressBlock
                                 successBlock:(LDHSuccessBlock)successBlock
                                 failureBlock:(LDHFailureBlock)failureBlock {
    
    [MobAPI sendRequest:[MOBAWxArticleRequest wxarticleCategoryRequest] onResult:^(MOBAResponse *response) {
        if (response.error) {
            failureBlock ? failureBlock(response.error) : nil;
        }else{
            successBlock ? successBlock(response.responder) : nil;
        }
    }];
}

+ (void)getWxarticleListRequestByCIDWithCid:(NSString *)cid
                                      start:(int)start
                                      count:(int)count
                              netIdentifier:(NSString *)netIdentifier
                                downloadProgressBlock:(LDHDownloadProgressBlock)downloadProgressBlock
                                 successBlock:(LDHSuccessBlock)successBlock
                                 failureBlock:(LDHFailureBlock)failureBlock {
    
    [MobAPI sendRequest:[MOBAWxArticleRequest wxarticleListRequestByCID:cid page:start size:count] onResult:^(MOBAResponse *response) {
        if (response.error) {
            failureBlock ? failureBlock(response.error) : nil;
        }else{
            successBlock ? successBlock(response.responder) : nil;
        }
    }];
}

@end
