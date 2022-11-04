//
//  SHEntry.h
//  SHDeepDiff
//
//  Created by 花生 on 2022/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHEntry : NSObject
@end


@interface SHTableEntry : SHEntry
@property (nonatomic, assign) NSUInteger fromCounter;
@property (nonatomic, assign) NSUInteger toCounter;
@property (nonatomic, strong) NSMutableIndexSet *indexInFrom;
@end


@interface SHOtherEntry : SHEntry
@property (nonatomic, assign) NSUInteger indexInOther;
+ (instancetype)entryWithIndexInOther:(NSUInteger)indexInOther;
@end

NS_ASSUME_NONNULL_END
