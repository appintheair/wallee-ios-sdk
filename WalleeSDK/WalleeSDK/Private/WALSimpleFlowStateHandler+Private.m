//
//  WALSimpleFlowStateHandler+Private.m
//  WalleeSDK
//
//  Created by Daniel Schmid on 12.09.17.
//  Copyright © 2017 smoca AG. All rights reserved.
//

#import "WALSimpleFlowStateHandler+Private.h"


@implementation WALSimpleFlowStateHandler (Private)
@dynamic alive;

- (instancetype)initInternal {
    if (self = [super init]) {
        self.alive = YES;
    }
    return self;
}
@end
