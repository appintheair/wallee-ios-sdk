//
//  WALNSURLSessionApiClient.m
//  WalleeSDK
//
//  Created by Daniel Schmid on 15.08.17.
//  Copyright © 2017 smoca AG. All rights reserved.
//

#import "WALNSURLSessionApiClient.h"
#import "WALMobileSdkUrl.h"
#import "WALPaymentMethodConfiguration.h"
#import "WALApiConfig.h"
#import "WALCredentials.h"

@interface WALNSURLSessionApiClient ()
@property (nonatomic, strong, readwrite) WALCredentials *credentialsProvider;
@property (nonatomic, strong, readwrite) NSURL *baseURL;
@property (nonatomic, strong, readwrite) NSURLSession *urlSession;
@end

@implementation WALNSURLSessionApiClient

- (instancetype)initWithBaseUrl:(NSString*) baseUrl credentialsProvider:(WALCredentials *)credentialsProvider {
    if (self = [super init]) {
        _baseURL = [NSURL URLWithString:baseUrl];
        _urlSession = [NSURLSession sessionWithConfiguration:[self configuration]];
        _credentialsProvider = credentialsProvider;
    }
    return self;
}

- (NSURLSessionConfiguration *)configuration {
    return [NSURLSessionConfiguration defaultSessionConfiguration];
}


+ (instancetype)clientWithBaseUrl:(NSString *)baseUrl credentialsProvider:(WALCredentials *)credentialsProvider {
    // validation
    return [[self alloc] initWithBaseUrl:baseUrl credentialsProvider:credentialsProvider];
}

// MARK: extract

- (void)buildMobileSdkUrl:(WALMobileSdkUrlCompletion)completion {
    NSString *endpoint = [NSString stringWithFormat:@"%@?credentials=%@", WalleeEndpointBuildMobilUrl, self.credentialsProvider.credentials];
    NSURL *url = [NSURL URLWithString:endpoint relativeToURL:self.baseURL];
    
    NSURLSessionDataTask *task = [self.urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSString *url = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            WALTimestamp expiryDate = [[NSDate date] timeIntervalSince1970] + WalleeMobileSdkUrlExpiryTime;
            WALMobileSdkUrl *mobileUrl = [[WALMobileSdkUrl alloc] initWithUrl:url expiryDate:expiryDate];
            completion(mobileUrl, nil);
        } else {
            completion(nil, error);
        }
    }];
    
    [task resume];
}

- (void)fetchPaymentMethodConfigurations:(WALPaymentMethodConfigurationsCompletion)completion {
    NSString *endpoint = [NSString stringWithFormat:@"%@?credentials=%@", WalleeEndpointFetchPossiblePaymentMethods, self.credentialsProvider.credentials];
    NSURL *url = [NSURL URLWithString:endpoint relativeToURL:self.baseURL];
    
    NSURLSessionDataTask *task = [self.urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSArray* json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:nil];
            completion(@[[WALPaymentMethodConfiguration decodedObjectFromJSON:json[0]]], nil);
        } else {
            completion(nil, error);
        }
    }];
    
    [task resume];
}


@end
