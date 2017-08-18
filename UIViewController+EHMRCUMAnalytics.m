//
//  UIViewController+EHMRCUMAnalytics.m
//  ieltsListen
//
//  Created by 王志平 on 2017/2/23.
//  Copyright © 2017年 enhance. All rights reserved.
//

#import "UIViewController+EHMRCUMAnalytics.h"

@implementation UIViewController (EHMRCUMAnalytics)

- (void)addControllersTo:(id)controller
{
    Class toClass = nil;
    if ([controller isKindOfClass:[NSString class]]) {
        toClass = NSClassFromString(controller);
    } else {
        toClass = [controller class];
    }

    NSMutableArray *temp = [NSMutableArray array];
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj != self) {
            [temp addObject:obj];
        }
        *stop = [obj isKindOfClass:toClass];
    }];
    [temp addObject:self];
    
    self.navigationController.viewControllers = temp;
}

- (void)addControllersuntil:(id)controller
{
    Class toClass = nil;
    if ([controller isKindOfClass:[NSString class]]) {
        toClass = NSClassFromString(controller);
    } else {
        toClass = [controller class];
    }
    
    NSMutableArray *temp = [NSMutableArray array];
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL same =  [obj isKindOfClass:toClass];
        if (obj != self && !same)
        {
            [temp addObject:obj];
        }
        *stop = same;
    }];
    [temp addObject:self];
    
    self.navigationController.viewControllers = temp;
}

- (void)deleteControllerFrom:(id)controller
{
    Class fromClass = nil;
    if ([controller isKindOfClass:[NSString class]]) {
        fromClass = NSClassFromString(controller);
    } else {
        fromClass = [controller class];
    }
    __block BOOL have = NO;
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:fromClass])
        {
            have = YES;
            *stop = YES;
        }
    }];
    if (have)
    {
        [self.navigationController.viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj isKindOfClass:fromClass])
            {
                if (obj != self)
                {
                    [obj removeFromParentViewController];
                }
            }
            else
            {
                *stop = YES;
            }
        }];
    }
}



@end
