//
//  WALFailureReason.h
//  WalleeSDK
//
//  Created by Daniel Schmid on 28.08.17.
//  Copyright © 2017 smoca AG. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, WALFailureCategory) {
    WALFailureCategoryTemporaryIssue,
    WALFailureCategoryInternal,
    WALFailureCategoryEndUser,
    WALFailureCategoryConfiguration,
    WALFailureCategoryDeveloper
};

// TODO: make this non initializable?
@interface WALFailureReason : NSObject
NS_ASSUME_NONNULL_BEGIN
@property (nonatomic, readonly) WALFailureCategory category;
@property (nonatomic, readonly, copy) NSDictionary<NSString *, NSString *> *descriptionText;
@property (nonatomic, readonly, copy) NSArray<NSNumber *> *features;
@property (nonatomic, readonly) NSUInteger id;
@property (nonatomic, readonly, copy) NSDictionary<NSString *, NSString *> *name;
NS_ASSUME_NONNULL_END
@end
