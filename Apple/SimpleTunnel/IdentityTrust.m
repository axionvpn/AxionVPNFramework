//
//  IdentityTrust.m
//  AxionVPNiOS
//
//  Created by AxionVPN on 6/7/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import "IdentityTrust.h"

@implementation IdentityTrust

SecIdentityRef myIdentity;
SecTrustRef myTrust;
SecCertificateRef myReturnedCertificate;

- (void) populateIdentityTrustAndCertificate {
    // Load Certificate
    NSString *path = [[NSBundle mainBundle] pathForResource:@"iphone6_client" ofType:@"p12"];
    NSData *p12data = [NSData dataWithContentsOfFile:path];
    CFDataRef inP12data = (__bridge CFDataRef)p12data;
    
    OSStatus result_extract_id = extractIdentityAndTrust(inP12data, &myIdentity, &myTrust,(__bridge CFStringRef)@"password");
    OSStatus status = SecIdentityCopyCertificate (myIdentity,
                                                  &myReturnedCertificate);
}

- (SecIdentityRef) getMyIdentity {
    return myIdentity;
}

- (SecTrustRef) getMyTrust {
    return myTrust;
}

- (SecCertificateRef) getMyReturnedCertificate {
    return myReturnedCertificate;
}


/*
The following listing shows how to get the certificate from the identity and how to display information from the certificate. Be sure to add the Security framework to your Xcode project when compiling code with this snippet.
*/
OSStatus extractIdentityAndTrust(CFDataRef inPKCS12Data,
                                 SecIdentityRef *outIdentity,
                                 SecTrustRef *outTrust,
                                 CFStringRef keyPassword)
{
    OSStatus securityError = errSecSuccess;
    const void *keys[] =   { kSecImportExportPassphrase };
    const void *values[] = { keyPassword };
    CFDictionaryRef optionsDictionary = NULL;
    
    /* Create a dictionary containing the passphrase if one
        was specified.  Otherwise, create an empty dictionary. */
        optionsDictionary = CFDictionaryCreate(NULL, keys,
                                               values, (keyPassword ? 1 : 0),
                                               NULL, NULL);  // 1
    
    CFArrayRef items = NULL;
    securityError = SecPKCS12Import(inPKCS12Data,
                                    optionsDictionary,
                                    &items);                    // 2
    
    //
    if (securityError == 0) {                                   // 3
        CFIndex item_count = CFArrayGetCount (items);
        NSLog(@"ITEM COUNT IN THE PK12 FILE IS :- %ld", item_count);
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue (myIdentityAndTrust,
                                             kSecImportItemIdentity);
        CFRetain(tempIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void *tempTrust = NULL;
        tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
        CFRetain(tempTrust);
        *outTrust = (SecTrustRef)tempTrust;
    }
    
    if (optionsDictionary)                                      // 4
        CFRelease(optionsDictionary);
    
    if (items)
        CFRelease(items);
    return securityError;
}

@end
