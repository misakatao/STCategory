//
//  UITableView+RegisterCell.m
//  YunBoApp
//
//  Created by MisakaTao on 2018/4/9.
//  Copyright © 2018年 misakatao. All rights reserved.
//

#import "UITableView+RegisterCell.h"

@implementation UITableView (RegisterCell)

- (void)registerNibForCell:(Class)cellClass {
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerClassForCell:(Class)cellClass {
    
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerNibForHeaderFooter:(Class)cellClass {
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
    [self registerNib:nib forHeaderFooterViewReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerClassForHeaderFooter:(Class)aClass {
    
    [self registerClass:aClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(aClass)];
}

- (UITableViewCell *)dequeueReusableCellWithClass:(Class)cellClass {
    
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
}

- (UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithClass:(Class)cellClass {
    
    return [self dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(cellClass)];
}

@end
