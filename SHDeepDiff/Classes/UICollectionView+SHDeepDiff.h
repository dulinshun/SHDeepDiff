//
//  UICollectionView+SHDeepDiff.h
//  SHDeepDiff
//
//  Created by 花生 on 2022/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (SHDeepDiff)

- (void)reloadSection:(NSUInteger)section
        fromList:(NSArray <__kindof NSObject *> *)fromList
          toList:(NSArray <__kindof NSObject *> *)toList
          updateBlock:(void(^)(void))updateBlock
           completion:(void(^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
