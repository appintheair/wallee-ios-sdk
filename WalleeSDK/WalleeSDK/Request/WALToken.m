//
//  WALToken.m
//  WalleeSDK
//
//  Created by Daniel Schmid on 28.08.17.
//  Copyright © 2017 smoca AG. All rights reserved.
//

#import "WALToken.h"
#import "WALJSONParser.h"
#import "WALDataObject+Private.h"

static NSString * const walCustomerEmailAddress = @"customerEmailAddress";
static NSString * const walCreatedOn = @"createdOn";
static NSString * const walCustomerId = @"customerId";
static NSString * const walLanguage = @"language";
static NSString * const walLinkedSpaceId = @"linkedSpaceId";
static NSString * const walEnabledForOneClickPayment = @"enabledForOneClickPayment";
static NSString * const walExternalId = @"externalId";
static NSString * const walId = @"id";
static NSString * const walPlannedPurgeDate = @"plannedPurgeDate";
static NSString * const walState = @"state";
static NSString * const walTokenReference = @"tokenReference";
static NSString * const walVersion = @"version";

@implementation WALToken

- (instancetype)initInternal {
    self = [super initInternal];
    return self;
}

+ (instancetype)decodedObjectFromJSON:(NSDictionary<NSString *,id> *)dictionary error:(NSError * _Nullable __autoreleasing *)error {
    WALToken *token = [[WALToken alloc] initInternal];
    if (![WALJSONParser populate:token withDictionary:dictionary error:error]) {
        return nil;
    }
    return token;
}

// MARK: - Mapping
+ (NSArray *)jsonMapping {
    return @[walCreatedOn, walCustomerId, walCustomerEmailAddress, walEnabledForOneClickPayment, walExternalId, walId, walLanguage, walLinkedSpaceId, walPlannedPurgeDate, walState, walTokenReference, walVersion];
}

+ (NSDictionary<NSString *,Class> *)jsonComplexMapping {
    return nil;
}

+ (NSDictionary<NSString *,NSString *> *)jsonReMapping {
    return nil;
}

// MARK: - Description
- (NSString *)description {
    return [NSString stringWithFormat:@"%@", @{walCustomerId: _customerId,
                                               walCustomerEmailAddress: _customerEmailAddress,
                                               walCreatedOn: _createdOn,
                                               walLinkedSpaceId: @(_linkedSpaceId),
                                               walId: @(_id), walExternalId: _externalId,
                                               walEnabledForOneClickPayment: @(_enabledForOneClickPayment),
                                               walPlannedPurgeDate: _plannedPurgeDate,
                                               walState: _state,
                                               walTokenReference: _tokenReference,
                                               walVersion: @(_version)
                                               }];
}

- (NSString *)debugDescription{
    return [NSString stringWithFormat:@"<%@: %p, \"%@\">", [self class], self, [self description]];
}

// MARK: - Copying
- (id)copyWithZone:(NSZone *)zone {
    WALToken *token = [[self.class allocWithZone:zone] initInternal];
    token->_createdOn = [_createdOn copyWithZone:zone];
    token->_customerEmailAddress = [_customerEmailAddress copyWithZone:zone];
    token->_customerId = [_customerId copyWithZone:zone];
    token->_enabledForOneClickPayment = _enabledForOneClickPayment;
    token->_externalId = [_externalId copyWithZone:zone];
    token->_id = _id;
    token->_language = [_language copyWithZone:zone];
    token->_linkedSpaceId = _linkedSpaceId;
    token->_plannedPurgeDate = [_plannedPurgeDate copyWithZone:zone];
    token->_state = [_state copyWithZone:zone];
    token->_tokenReference = [_tokenReference copyWithZone:zone];
    token->_version = _version;
    return token;
}
@end
