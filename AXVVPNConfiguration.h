//
//  AXVVPNConfiguration.h
//  AxionVPNiOS
//
//  Created by AxionVPN on 5/16/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import "AXVObject.h"

@interface AXVVPNConfiguration : AXVObject

@property (nonatomic, retain) NSString *vpnServer;
@property (nonatomic, retain) NSString *port;
@property (nonatomic, retain) NSString *certificateAuthorityCertificate;
@property (nonatomic, retain) NSString *certificate;
@property (nonatomic, retain) NSString *privateKey;
@property (nonatomic, retain) NSString *staticKey;

@end
