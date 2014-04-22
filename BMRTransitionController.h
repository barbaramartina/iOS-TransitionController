//
//  BMRTransitionController.h
//  ProWatermarkMaker
//
//  Created by Barbara Rodeker on 4/22/14.
//  Copyright (c) 2014 Barbara Martina Rodeker. All rights reserved.
//
//  Licensed to the Apache Software Foundation (ASF) under one
//  or more contributor license agreements.  See the NOTICE file
//  distributed with this work for additional information
//  regarding copyright ownership.  The ASF licenses this file
//  to you under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance
//  with the License.  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.
//

#import <Foundation/Foundation.h>


@interface BMRTransitionController : NSObject <UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>

/*
 * Set your prefered time for the duration of transitions
 */
@property (nonatomic, assign) NSTimeInterval transitionDuration;

/*
 * Choose a transitioner code to be executed
 */
@property (nonatomic, assign) NSUInteger transitionerCode;


/*
 * Before you can use it, you must provide a plist file with the following
 * format in order to configure the transition controller:
 *
 * array of dictionaries with keys / values:
 *          - key: "code"   -> value: a number assigned as code for the transitioner. Should start in 0 and should be incremented by 1.
 *          - key: "class"  -> value: an string with the name of the class inheriting from BMRTransitioner.
 */
- (void)configureWithTransitionersFromFile:(NSString *)fileName;

@end
