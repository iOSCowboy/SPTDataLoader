/*
 * Copyright (c) 2015-2016 Spotify AB.
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
@import XCTest;

#import "SPTDataLoaderResolverAddress.h"

@interface SPTDataLoaderResolverAddress (Tests)

@property (nonatomic, assign) CFAbsoluteTime lastFailedTime;

@end

@interface SPTDataLoaderResolverAddressTest : XCTestCase

@property (nonatomic, strong) SPTDataLoaderResolverAddress *address;

@end

@implementation SPTDataLoaderResolverAddressTest

#pragma mark XCTestCase

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.address = [SPTDataLoaderResolverAddress dataLoaderResolverAddressWithAddress:@"192.168.0.1"];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark SPTDataLoaderResolverAddressTest

- (void)testNotNil
{
    XCTAssertNotNil(self.address, @"The address should not be nil after construction");
}

- (void)testReachable
{
    XCTAssertTrue(self.address.reachable, @"The address should be reachable");
}

- (void)testNotReachableIfFailed
{
    [self.address failedToReach];
    XCTAssertFalse(self.address.reachable, @"The address should not be reachable");
}

- (void)testLastFailedTimeNonsensical
{
    self.address.lastFailedTime = CFAbsoluteTimeGetCurrent() + 100000;
    XCTAssertTrue(self.address.reachable, @"The address should be reachable");
}

@end
