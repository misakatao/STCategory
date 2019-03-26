//
//  UICollectionView+RegisterCell.m
//  YunBoApp
//
//  Created by MisakaTao on 2018/4/9.
//  Copyright © 2018年 misakatao. All rights reserved.
//

#import "UICollectionView+RegisterCell.h"

@implementation UICollectionView (RegisterCell)

- (void)registerNibForCell:(Class)cellClass {
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
    [self registerNib:nib forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerClassForCell:(Class)cellClass {
    
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerNibForHeaderFooter:(Class)cellClass forSupplementaryViewOfKind:(NSString *)kind {
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
    [self registerNib:nib forSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(cellClass)];
    
}

- (void)registerClassForHeaderFooter:(Class)aClass  forSupplementaryViewOfKind:(NSString *)kind {
    
    [self registerClass:aClass forSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(aClass)];
}

- (UICollectionViewCell *)dequeueReusableCellWithReuseClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath {
    
    return [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
}

- (UICollectionReusableView *)dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withReuseClass:(Class)aClass forIndexPath:(NSIndexPath *)indexPath {
    
    return [self dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:NSStringFromClass(aClass) forIndexPath:indexPath];
}

@end
