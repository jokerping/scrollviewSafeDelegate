//
//  UIViewController+EHMRCUMAnalytics.h
//  ieltsListen
//
//  Created by 王志平 on 2017/2/23.
//  Copyright © 2017年 enhance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (EHMRCUMAnalytics)


/**
 删除self.navigationController.viewControllers 中
 从controller之后到self之间的controller.

 @param controller 开始删除的controller,
 可以传入：controller类名，controller对象
 */
- (void)deleteControllerFrom:(id)controller;

/**
 重新生成数组，赋值给self.navigationController.viewControllers
 添加从self.navigationController.viewControllers[0]到controller之间的controller,和self
 
 @param controller 开始删除的controller,
 可以传入：controller类名，controller对象
 */

- (void)addControllersTo:(id)controller;

/**
 添加传入控制器之前的控制器，不包含传入的控制器

 @param controller 类名或者对象
 */
- (void)addControllersuntil:(id)controller;


@end
