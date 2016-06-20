//
//  AXVIPHelper.m
//  AxionVPNiOS
//
//  Created by AxionVPN on 6/14/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import "AXVIPHelper.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation AXVIPHelper

+(NSString *)getIPAddress
{
    
    NSString *address = @"error";
    
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    
    int success = getifaddrs(&interfaces);
    
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        
        while (temp_addr != NULL)
        {
            if (temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"] == YES)
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

@end
