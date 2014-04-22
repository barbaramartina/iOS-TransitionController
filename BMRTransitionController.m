//
//  BMRTransitionController.m
//  ProWatermarkMaker
//
//  Created by Barbara Rodeker on 4/22/14.
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
#import "BMRTransitionController.h"

#import "BMRTransitioner.h"
#import "BMRZoomInZoomOutTransitioner.h"

/******************************************************************************************/
#pragma mark static values

static NSString *kEmptyTransitionsError = @"ERROR: You should configure the transitioner controller before using it!!";
static NSString *kNoValidTransitionError = @"ERROR: the transitioner code you provided is outside the indexes range of the configured transitioner. Please review your configuration files.";
static NSString *kNoValidStringError = @"ERROR: The file name you're trying to use is nil.";
static NSString *kNoValidEmptyStringError = @"ERROR: The file name you're trying to use is empty.";
static NSString *kNoConfigurationDataError = @"Configuration data can not be read";
static NSString *kNotClassMatchingError = @"ERROR: the variable you're checking is not from the expected class. Please check the data type.";
static NSString *kNoNegativeNumber = @"ERROR: the number you're using must not be negative";
static NSString *kNotAClassInProject = @"ERROR: the class you're trying to read or use is not an existent class.";
static NSString *kIndexNotFreeError = @"ERROR: the index of the array you're trying to use is already occupied.";

static NSString *kCodeKey = @"code";
static NSString *kClassKey = @"class";


/******************************************************************************************/
#pragma mark Private Interface

@interface BMRTransitionController()

@property (nonatomic, assign) BOOL isPresenting;
@property (nonatomic, strong) NSMutableArray *transitioners;

@end

/******************************************************************************************/

@implementation BMRTransitionController


- (void)configureWithTransitionersFromFile:(NSString *)fileName
{
    self.transitioners = [NSMutableArray array];
    
    NSAssert(fileName != nil, kNoValidStringError);
    NSAssert([fileName length] > 0, kNoValidEmptyStringError);

    NSString *pathToFile = [[NSBundle mainBundle] pathForResource:[fileName stringByDeletingPathExtension] ofType:@"plist"];
    NSAssert(pathToFile != nil, kNoValidStringError);
    
    NSArray *configData = [NSArray arrayWithContentsOfFile:pathToFile];
    NSAssert(configData != nil, kNoConfigurationDataError);
    
    for (NSDictionary* transitioner in configData) {
        NSAssert([transitioner isKindOfClass:[NSDictionary class]], kNotClassMatchingError);
        
        NSInteger code = [transitioner[kCodeKey] integerValue];
        NSString *className = transitioner[kClassKey];
        
        NSAssert(code >= 0, kNoNegativeNumber);
        NSAssert(NSClassFromString(className), kNotAClassInProject);
        
        id transitioner = [[NSClassFromString(className) alloc] init];
        NSAssert([transitioner isKindOfClass:[BMRTransitioner class]], kNotClassMatchingError);
        
        [self.transitioners insertObject:transitioner atIndex:code];
    }
}


#pragma mark UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController*)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source
{
    NSAssert(self.transitioners != nil && [self.transitioners count] != 0, kEmptyTransitionsError);
    
    self.isPresenting = YES;
    return self;
}

-(id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController*)dismissed
{
    NSAssert(self.transitioners != nil && [self.transitioners count] != 0, kEmptyTransitionsError);

    self.isPresenting = NO;
    return self;
}

#pragma mark UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSAssert(self.transitioners != nil && [self.transitioners count] != 0, kEmptyTransitionsError);

    return self.transitionDuration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSAssert(self.transitioners != nil && [self.transitioners count] != 0, kEmptyTransitionsError);
    NSAssert([self.transitioners count] > self.transitionerCode, kNoValidTransitionError);

    if (self.isPresenting) {
        [self.transitioners[self.transitionerCode] executePresentationWithContext:transitionContext
                                                                         duration:[self transitionDuration:transitionContext]];
    } else {
        [self.transitioners[self.transitionerCode] executeDismissalWithContext:transitionContext
                                                                      duration:[self transitionDuration:transitionContext]];
    }
}
@end
