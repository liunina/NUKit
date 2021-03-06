//
//  NUViewController+NetworkReachability.m
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import "NUViewController+NetworkReachability.h"
#import <Reachability/Reachability.h>
#import <objc/runtime.h>

static void *kNUReachabilityStatusChangeBlockKey = @"kNUReachabilityStatusChangeBlockKey";
static void *kNULastNetworkStatusKey = @"kNULastNetworkStatusKey";
static void *kNUNetworkStatusKey = @"kNUNetworkStatusKey";

@implementation NUViewController (NetworkReachability)

- (void)setNetWorkReachabilityStatusChangeBlock:(NUReachabilityStatusChangeBlock)block {
	self.lastNetworkStatus = NUNetworkReachabilityStatusUnknown;
	self.networkStatus = NUNetworkReachabilityStatusUnknown;
	self.reachabilityStatusChangeBlock = block;
	__weak typeof(self) ws = self;
	
	Reachability *reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
	reach.reachableBlock = ^(Reachability*reach) {
		dispatch_async(dispatch_get_main_queue(), ^{
			ws.lastNetworkStatus = (NUNetworkReachabilityStatus)ws.networkStatus;
			ws.networkStatus = (NUNetworkReachabilityStatus)reach.currentReachabilityStatus;
			ws.reachabilityStatusChangeBlock(ws.lastNetworkStatus, ws.networkStatus);
		});
	};

	reach.unreachableBlock = ^(Reachability*reach) {
		dispatch_async(dispatch_get_main_queue(), ^{
			ws.lastNetworkStatus = (NUNetworkReachabilityStatus)ws.networkStatus;
			ws.networkStatus = (NUNetworkReachabilityStatus)reach.currentReachabilityStatus;
			ws.reachabilityStatusChangeBlock(ws.lastNetworkStatus, ws.networkStatus);
		});
	};
	[reach startNotifier];
}

#pragma mark - getter
- (void)setReachabilityStatusChangeBlock:(NUReachabilityStatusChangeBlock)reachabilityStatusChangeBlock {
	objc_setAssociatedObject(self, kNUReachabilityStatusChangeBlockKey, reachabilityStatusChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (NUReachabilityStatusChangeBlock)reachabilityStatusChangeBlock {
	return objc_getAssociatedObject(self, kNUReachabilityStatusChangeBlockKey);
}

- (void)setLastNetworkStatus:(NUNetworkReachabilityStatus)lastNetworkStatus {
	return objc_setAssociatedObject(self, kNULastNetworkStatusKey, @(lastNetworkStatus), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NUNetworkReachabilityStatus)lastNetworkStatus {
	return  [objc_getAssociatedObject(self, kNULastNetworkStatusKey) integerValue];
}

- (void)setNetworkStatus:(NUNetworkReachabilityStatus)networkStatus {
	return objc_setAssociatedObject(self, kNUNetworkStatusKey, @(networkStatus), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NUNetworkReachabilityStatus)networkStatus {
	return  [objc_getAssociatedObject(self, kNUNetworkStatusKey) integerValue];
}
@end
