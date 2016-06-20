//
//  IdentityTrust.h
//  AxionVPNiOS
//
//  Created by AxionVPN on 6/7/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IdentityTrust : NSObject

extern SecIdentityRef myIdentity;
extern SecTrustRef myTrust;
extern SecCertificateRef myReturnedCertificate;

- (void) populateIdentityTrustAndCertificate;
- (SecIdentityRef) getMyIdentity;
- (SecTrustRef) getMyTrust;
- (SecCertificateRef) getMyReturnedCertificate;

@end
