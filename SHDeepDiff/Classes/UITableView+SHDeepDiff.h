//
//  UITableView+SHDeepDiff.h
//  SHDeepDiff
//
//  Created by 花生 on 2022/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (SHDeepDiff)

- (void)reloadSection:(NSUInteger)section
        fromList:(NSArray <__kindof NSObject *> *)fromList
          toList:(NSArray <__kindof NSObject *> *)toList
          updateBlock:(void(^)(void))updateBlock
           completion:(void(^)(BOOL finished))completion;

- (void)reloadSection:(NSUInteger)section
         fromList:(NSArray <__kindof NSObject *> *)fromList
           toList:(NSArray <__kindof NSObject *> *)toList
      deleteAnimaiton:(UITableViewRowAnimation)deleteAnimaiton
      insertAnimation:(UITableViewRowAnimation)insertAnimation
     replaceAnimation:(UITableViewRowAnimation)replaceAnimation
          updateBlock:(void(^)(void))updateBlock
           completion:(void(^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
