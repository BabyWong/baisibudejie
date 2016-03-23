//
//  WMAFHTTPSessionManager.m
//  baisibudejie
//
//  Created by hwm on 16/3/20.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMAFHTTPSessionManager.h"

@implementation WMAFHTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url {
    
    if (self = [super initWithBaseURL:url]) {
        
        //        self.securityPolicy.validatesDomainName = NO;
        //        self.responseSerializer = nil;
        //        self.requestSerializer = nil;
        
    }
    
    return self;
}

@end
