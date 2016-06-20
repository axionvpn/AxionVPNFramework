//
//  AXVVPNConfiguration.m
//  AxionVPNiOS
//
//  Created by AxionVPN on 5/16/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import "AXVVPNConfiguration.h"

static NSString *const kAXVVPNConfigurationConfigKey = @"conf";

@implementation AXVVPNConfiguration

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    
    if (self != nil)
    {
        NSString *string = [dictionary objectForKey:kAXVVPNConfigurationConfigKey];
        
        NSArray *stringParts = [string componentsSeparatedByString:@"\n"];
        
        for (NSString *string in stringParts)
        {
            if ([string hasPrefix:@"remote vpn-"] == YES)
            {
                NSString *vpnServerString = [string stringByReplacingOccurrencesOfString:@"remote vpn-"
                                                                              withString:@""];
                
                [self setVpnServer:vpnServerString];
            }
            else if ([string hasPrefix:@"port"] == YES)
            {
                NSString *portString = [string stringByReplacingOccurrencesOfString:@"port "
                                                                         withString:@""];
                [self setPort:portString];
            }
            else if ([@[@"<ca>",@"<cert>",@"<key>"] containsObject:string] == YES)
            {
                NSInteger index = [stringParts indexOfObject:string];
                
                NSString *certString = [self getCertStringWithIndexOfStartingKey:index+1
                                                         fromStringsArray:stringParts];

                if ([string isEqualToString:@"<ca>"] == YES)
                {
                    [self setCertificateAuthorityCertificate:certString];
                }
                else if ([string isEqualToString:@"<cert>"] == YES)
                {
                    [self setCertificate:certString];
                }
                else if ([string isEqualToString:@"<key>"] == YES)
                {
                    [self setPrivateKey:certString];
                }
            }
            else if ([string isEqualToString:@"-----BEGIN OpenVPN Static key V1-----"] == YES)
            {
                NSString *openVPNString = [self getCertStringWithIndexOfStartingKey:[stringParts indexOfObject:string]
                                                            fromStringsArray:stringParts];
                [self setStaticKey:openVPNString];
            }
        }
        
    }
    
    return self;
}

-(NSString *)description
{
    NSString *string = [self.dictionaryRepresentation objectForKey:kAXVVPNConfigurationConfigKey];
    
    NSArray *stringParts = [string componentsSeparatedByString:@"\n"];
    
    for (NSString *string in stringParts)
    {
        NSLog(@"%@",string);
    }
    
    return @"";
}

-(NSString *)getCertStringWithIndexOfStartingKey:(NSInteger)startingKeyIndex fromStringsArray:(NSArray <NSString *> *)stringsArray
{
    NSString *certString = @"";
    
    NSInteger index = startingKeyIndex;
    
    NSString *loopString = nil;
    
    while ([[stringsArray objectAtIndex:index + 1] hasPrefix:@"-----END"] == NO)
    {
        index++;
        
        loopString = [stringsArray objectAtIndex:index];
        
        certString = [certString stringByAppendingString:loopString];
    }
    
    return certString;
}

@end
