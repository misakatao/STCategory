//
//  UICollectionView+RegisterCell.h
//  YunBoApp
//
//  Created by MisakaTao on 2018/4/9.
//  Copyright © 2018年 misakatao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (RegisterCell)

- (void)registerNibForCell:(nullable Class)cellClass;

- (void)registerClassForCell:(nullable Class)cellClass;

- (void)registerNibForHeaderFooter:(nullable Class)cellClass forSupplementaryViewOfKind:(NSString *)kind;

- (void)registerClassForHeaderFooter:(nullable Class)aClass  forSupplementaryViewOfKind:(NSString *)kind;

- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;

- (__kindof UICollectionReusableView *)dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withReuseClass:(Class)aClass forIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
