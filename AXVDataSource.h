//
//  AXVDataSource.h
//  AxionVPNiOS
//
//  Created by AxionVPN on 5/6/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXVGeosite.h"
#import "AXVUser.h"
#import "AXVVPNConfiguration.h"

typedef enum
{
    kAXVDataSourceAuthenticationInformationError = -1,
    kAXVDataSourceAuthenticationInformationLoginSuccess = 0,
    kAXVDataSourceAuthenticationInformationBadCredentials = 1,
    kAXVDataSourceAuthenticationInformationAccountNotActivated = 2,
    kAXVDataSourceAuthenticationInformationCredentialsCorrectButNotOnVPN = 3
}kAXVDataSourceAuthenticationInformation;

typedef void(^kAXVDataSourceGetGeositesCompletionBlock)(NSError *error, NSArray <AXVGeosite *> *givenGeositesArray);
typedef void(^kAXVDataSourceAuthenticateUserCompletionBlock)(NSError *error, kAXVDataSourceAuthenticationInformation userInformation);
typedef void(^kAXVDataSourceGetVPNConfigurationCompletionBlock)(NSError *error,AXVVPNConfiguration *configuration);

@interface AXVDataSource : NSObject

-(void)getGeositesWithCompletionBlock:(kAXVDataSourceGetGeositesCompletionBlock)givenCompletionBlock;
-(void)getVPNConfigurationForUser:(AXVUser *)user andGeosite:(AXVGeosite *)geosite withCompletionBlock:(kAXVDataSourceGetVPNConfigurationCompletionBlock)givenCompletionBlock;
-(void)authenticateUser:(AXVUser *)user withCompletionBlock:(kAXVDataSourceAuthenticateUserCompletionBlock)givenCompletionBlock;

@end
