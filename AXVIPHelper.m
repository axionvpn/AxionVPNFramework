//
//  AXVIPHelper.m
//  AxionVPNiOS
//
//  Created by AxionVPN on 6/14/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import "AXVIPHelper.h"
#import "AFNetworking.h"

@interface AXVIPHelper ()
{
    AFHTTPSessionManager *sessionManager;
}

@end

@implementation AXVIPHelper

-(instancetype)init
{
    self = [super init];
    
    if (self != nil)
    {
        sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://ipof.in/"]];
        sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    }
    
    return self;
}

-(void)getIPAddressWithCompletionBlock:(kAXVIPHelperGetIPAddressCompletionBlock)completionBlock
{
    [sessionManager GET:@"txt"
             parameters:nil
               progress:nil
                success:^(NSURLSessionDataTask * _Nonnull task, NSData *stringData)
     {
         NSString *ipAddress = [[NSString alloc] initWithData:stringData
                                                     encoding:NSUTF8StringEncoding];
         
         completionBlock(nil,ipAddress);
     }
                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         completionBlock(error,nil);
     }];

}

@end
