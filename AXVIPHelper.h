//
//  AXVIPHelper.h
//  AxionVPNiOS
//
//  Created by AxionVPN on 6/14/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^kAXVIPHelperGetIPAddressCompletionBlock)(NSError *error, NSString *ipAddress);
@interface AXVIPHelper : NSObject

-(void)getIPAddressWithCompletionBlock:(kAXVIPHelperGetIPAddressCompletionBlock)completionBlock;

@end
