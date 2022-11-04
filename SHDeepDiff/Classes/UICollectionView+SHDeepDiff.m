//
//  UICollectionView+SHDeepDiff.m
//  SHDeepDiff
//
//  Created by 花生 on 2022/11/3.
//

#import "UICollectionView+SHDeepDiff.h"
#import "SHHeckel.h"

@implementation UICollectionView (SHDeepDiff)

- (void)reloadSection:(NSUInteger)section
        fromList:(NSArray <__kindof NSObject *> *)fromList
          toList:(NSArray <__kindof NSObject *> *)toList
          updateBlock:(void(^)(void))updateBlock
           completion:(void(^)(BOOL finished))completion {
    
    SHIndexPathConverter *converter = [SHHeckel convertWithFromList:fromList toList:toList section:section];

    void(^updateRowsBlock)(void) = ^{
        !updateBlock ?: updateBlock();
        if (converter.deletes.count > 0) {
            [self deleteItemsAtIndexPaths:converter.deletes];
        }
        if (converter.inserts.count > 0) {
            [self insertItemsAtIndexPaths:converter.inserts];
        }
        if (converter.moves.count > 0) {
            for (SHMoveIndexPath *moveIndexPath in converter.moves) {
                [self moveItemAtIndexPath:moveIndexPath.from toIndexPath:moveIndexPath.to];
            }
        }
    };
    
    [self performBatchUpdates:updateRowsBlock completion:completion];
    [self  reloadItemsAtIndexPaths:converter.replaces];
}


@end
