//
//  NUViewController+NetworkReachability.h
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//


#import <NUKit/NUViewController.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, NUNetworkReachabilityStatus) {
    NUNetworkReachabilityStatusUnknown          = -1,
    NUNetworkReachabilityStatusNotReachable     = 0,
    NUNetworkReachabilityStatusReachableViaWWAN = 1,
    NUNetworkReachabilityStatusReachableViaWiFi = 2,
};

typedef void(^NUReachabilityStatusChangeBlock)(NUNetworkReachabilityStatus lastStatus, NUNetworkReachabilityStatus status);

@interface NUViewController (NetworkReachability)
@property (nonatomic, assign, readonly) NUNetworkReachabilityStatus networkStatus;

/// 设置网络状态更改回调函数
/// @param block 回调函数
- (void)setNetWorkReachabilityStatusChangeBlock:(NUReachabilityStatusChangeBlock)block;
@end

NS_ASSUME_NONNULL_END
