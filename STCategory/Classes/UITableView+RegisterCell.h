//
//  UITableView+RegisterCell.h
//  YunBoApp
//
//  Created by MisakaTao on 2018/4/9.
//  Copyright © 2018年 misakatao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (RegisterCell)

- (void)registerNibForCell:(nullable Class)cellClass;

- (void)registerClassForCell:(nullable Class)cellClass;

- (void)registerNibForHeaderFooter:(nullable Class)cellClass;

- (void)registerClassForHeaderFooter:(nullable Class)aClass;

- (nullable __kindof UITableViewCell *)dequeueReusableCellWithClass:(Class)cellClass;

- (nullable __kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithClass:(Class)cellClass;

@end

NS_ASSUME_NONNULL_END
