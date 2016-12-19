//
//  AXVDataSource.m
//  AxionVPNiOS
//
//  Created by AxionVPN on 5/6/16.
//  Copyright © 2016 AxionVPN. All rights reserved.
//

#import "AXVDataSource.h"
#import "AFNetworking.h"

static NSString *const kAXVDataSourceBaseURL = @"https://axionvpn.com/api/";
static NSString *const kAXVDataSourceGetVPNsPath = @"get-vpns";//GET
static NSString *const kAXVDataSourceGetConfigPath = @"get-config"; //POST geosite id, username, and password
static NSString *const kAXVDataSourceGetInfoPath = @"get-info"; //POST username, password


static NSString *const kAXVDataSourceUserNameKey = @"username";
static NSString *const kAXVDataSourcePasswordKey = @"password";
static NSString *const kAXVDataSourceGeositeIdKey = @"id";

@interface AXVDataSource ()
{
    AFHTTPSessionManager *sessionManager;
}

@end

@implementation AXVDataSource

-(instancetype)init
{
    self = [super init];
    
    if (self != nil)
    {
        sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kAXVDataSourceBaseURL]];
    }
    
    return self;
}

-(void)getGeositesWithCompletionBlock:(kAXVDataSourceGetGeositesCompletionBlock)givenCompletionBlock
{
    [sessionManager GET:kAXVDataSourceGetVPNsPath
             parameters:nil
               progress:nil
                success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *jsonDict)
    {
        NSMutableArray <AXVGeosite *> *geositesArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in [jsonDict objectForKey:@"vpns"])
        {
            AXVGeosite *geosite = [[AXVGeosite alloc] initWithDictionary:dict];
            
            [geositesArray addObject:geosite];
        }
        
        givenCompletionBlock(nil,geositesArray);
    }
                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
         givenCompletionBlock(error,nil);
    }];
}

-(void)getVPNConfigurationForUser:(AXVUser *)user andGeosite:(AXVGeosite *)geosite withCompletionBlock:(kAXVDataSourceGetVPNConfigurationCompletionBlock)givenCompletionBlock
{
    if (user == nil)
    {
        [NSException raise:@"User is nil!" format:@""];
    }
    
    [sessionManager POST:kAXVDataSourceGetConfigPath
              parameters:@{kAXVDataSourceUserNameKey:user.userName,
                           kAXVDataSourcePasswordKey:user.password,
                           kAXVDataSourceGeositeIdKey:geosite.geositeId}
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *jsonDictionary)
     {
         if ([jsonDictionary objectForKey:@"conf"] != nil)
         {
             NSString *configFileString = [jsonDictionary objectForKey:@"conf"];
             
             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
             NSString *documentsDirectory = [paths objectAtIndex:0];
             NSString *path = [documentsDirectory stringByAppendingPathComponent:@"configuration.ovpn"];
             
             NSError *error = nil;
             
             [configFileString writeToURL:[NSURL fileURLWithPath:path] atomically:YES encoding:NSUTF8StringEncoding error:&error];
             
             if (error != nil)
             {
                 NSLog(@"error saving ovpn file: %@",error);
             }
             
             AXVVPNConfiguration *config = [[AXVVPNConfiguration alloc] initWithDictionary:jsonDictionary];
                          
             givenCompletionBlock(nil,config);
         }
         else
         {
             NSLog(@"Failed to get cert for %@: %@",geosite.geoArea,jsonDictionary);
             givenCompletionBlock(nil,nil);
         }
     }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         givenCompletionBlock(error,nil);
     }];
}

-(void)authenticateUser:(AXVUser *)user withCompletionBlock:(kAXVDataSourceAuthenticateUserCompletionBlock)givenCompletionBlock
{
    if (user == nil)
    {
        [NSException raise:@"User is nil!" format:@""];
    }
    
    [sessionManager POST:kAXVDataSourceGetInfoPath
             parameters:@{kAXVDataSourceUserNameKey:user.userName,
                          kAXVDataSourcePasswordKey:user.password}
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *jsonDictionary)
    {
        kAXVDataSourceAuthenticationInformation authInfo = kAXVDataSourceAuthenticationInformationError;
        
        if (jsonDictionary != nil)
        {
            authInfo = (kAXVDataSourceAuthenticationInformation)[[jsonDictionary objectForKey:@"result"] integerValue];
        }
        
        givenCompletionBlock(nil,authInfo);
    }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        givenCompletionBlock(error,kAXVDataSourceAuthenticationInformationError);
    }];
}

@end
