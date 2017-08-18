//
//  UIScrollView+safeDelegate.m
//  ieltsListen
//
//  Created by 王志平 on 2017/8/18.
//  Copyright © 2017年 enhance. All rights reserved.
//

#import "UIScrollView+safeDelegate.h"
#import <objc/runtime.h>
#import "NSObject+Guard.h"
@implementation UIScrollView (safeDelegate)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL oldSEL = @selector(setDelegate:);
        SEL newSEL = @selector(myselfSetDelegate:);
        Method oldMethod = class_getInstanceMethod(class, oldSEL);
        Method newMethod = class_getInstanceMethod(class, newSEL);
        BOOL success = class_addMethod(class, oldSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        if (success)
        {
            class_replaceMethod(class, newSEL, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
        }
        else
        {
            method_exchangeImplementations(oldMethod, newMethod);
        }
    });
}

- (void)myselfSetDelegate:(id )delegate
{
    if (delegate) {
        __weak typeof(UIScrollView *)weak_self = self;
        [delegate guard_addDeallocBlock:^{
            weak_self.delegate = nil;
            if ([weak_self isKindOfClass:[UITableView class]])
            {
                ((UITableView *)weak_self).editing = NO;
                ((UITableView *)weak_self).dataSource = nil;
                ((UITableView *)weak_self).delegate = nil;
                
            }
            else if ([weak_self isKindOfClass:[UICollectionView class]])
            {
                ((UICollectionView *)weak_self).dataSource = nil;
                ((UICollectionView *)weak_self).delegate = nil;
            }
        }];
    }
    
    [self myselfSetDelegate:delegate];
}
@end
