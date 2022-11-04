//
//  UITableView+SHDeepDiff.m
//  SHDeepDiff
//
//  Created by 花生 on 2022/11/3.
//

#import "UITableView+SHDeepDiff.h"
#import "SHHeckel.h"

@implementation UITableView (SHDeepDiff)

- (void)reloadSection:(NSUInteger)section
        fromList:(NSArray <__kindof NSObject *> *)fromList
          toList:(NSArray <__kindof NSObject *> *)toList
          updateBlock:(void(^)(void))updateBlock
           completion:(void(^)(BOOL finished))completion {
    
    [self reloadSection:section
           fromList:fromList
             toList:toList
        deleteAnimaiton:UITableViewRowAnimationFade
        insertAnimation:UITableViewRowAnimationFade
       replaceAnimation:UITableViewRowAnimationFade
            updateBlock:updateBlock
             completion:completion];
}

- (void)reloadSection:(NSUInteger)section
         fromList:(NSArray <__kindof NSObject *> *)fromList
           toList:(NSArray <__kindof NSObject *> *)toList
      deleteAnimaiton:(UITableViewRowAnimation)deleteAnimaiton
      insertAnimation:(UITableViewRowAnimation)insertAnimation
     replaceAnimation:(UITableViewRowAnimation)replaceAnimation
          updateBlock:(void(^)(void))updateBlock
           completion:(void(^)(BOOL finished))completion {
    
    SHIndexPathConverter *converter = [SHHeckel convertWithFromList:fromList toList:toList section:section];
    
    //
    void(^updateRowsBlock)(void) = ^{
        !updateBlock ?: updateBlock();
        if (converter.deletes.count > 0) {
            [self deleteRowsAtIndexPaths:converter.deletes withRowAnimation:deleteAnimaiton];
        }
        if (converter.inserts.count > 0) {
            [self insertRowsAtIndexPaths:converter.inserts withRowAnimation:insertAnimation];
        }
        if (converter.moves.count > 0) {
            for (SHMoveIndexPath *moveIndexPath in converter.moves) {
                [self moveRowAtIndexPath:moveIndexPath.from toIndexPath:moveIndexPath.to];
            }
        }
    };
    
    if (@available(iOS 11.0, *)) {
        [self performBatchUpdates:updateRowsBlock completion:completion];
    } else {
        [self beginUpdates];
        updateRowsBlock();
        [self endUpdates];
        !completion ?: completion(YES);
    }
    
    [self reloadRowsAtIndexPaths:converter.replaces withRowAnimation:replaceAnimation];
}

@end
