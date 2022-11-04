//
//  SHEntry.m
//  SHDeepDiff
//
//  Created by 花生 on 2022/11/3.
//

#import "SHEntry.h"

@implementation SHEntry
@end


@implementation SHTableEntry

- (instancetype)init {
    self = [super init];
    if (self) {
        self.fromCounter = 0;
        self.toCounter = 0;
        self.indexInFrom = [NSMutableIndexSet indexSet];
    }
    return self;
}

@end


@implementation SHOtherEntry

+ (instancetype)entryWithIndexInOther:(NSUInteger)indexInOther {
    SHOtherEntry *entry = [[SHOtherEntry alloc] init];
    entry.indexInOther = indexInOther;
    return entry;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.indexInOther = 0;
    }
    return self;
}

@end
