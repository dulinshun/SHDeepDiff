//
//  SHHeckel.m
//  Pods
//
//  Created by 花生 on 2022/11/3.
//

#import "SHHeckel.h"
#import "SHEntry.h"

@implementation SHHeckel

//
+ (SHIndexPathConverter *)convertWithFromList:(NSArray <__kindof NSObject *> *)fromList toList:(NSArray <__kindof NSObject *> *)toList section:(NSInteger)section {
    
    __block NSMutableDictionary <__kindof NSNumber *, __kindof SHEntry *> *map = [NSMutableDictionary dictionary];
    __block NSMutableArray <__kindof SHEntry *> *fromEntrys  = [NSMutableArray array];
    __block NSMutableArray <__kindof SHEntry *> *toEntrys  = [NSMutableArray array];
    
    // process 'to list'
    [toList enumerateObjectsUsingBlock:^(__kindof NSObject *obj, NSUInteger toIndex, BOOL * _Nonnull stop) {
        NSNumber *key = @(obj.hash);
        SHTableEntry *entry = map[key];
        if (!entry || ![entry isKindOfClass:[SHTableEntry class]]) {
            entry = [[SHTableEntry alloc] init];
        }
        entry.toCounter ++;
        [toEntrys addObject:entry];
        map[key] = entry;
    }];
    
    // process 'from list'
    [fromList enumerateObjectsUsingBlock:^(__kindof NSObject *obj, NSUInteger fromIndex, BOOL * _Nonnull stop) {
        NSNumber *key = @(obj.hash);
        SHTableEntry *entry = map[key];
        if (!entry || ![entry isKindOfClass:[SHTableEntry class]]) {
            entry = [[SHTableEntry alloc] init];
        }
        entry.fromCounter ++;
        [entry.indexInFrom addIndex:fromIndex];
        [fromEntrys addObject:entry];
        map[key] = entry;
    }];
    
    // process 'from entrys' & 'to entrys'
    [toEntrys enumerateObjectsUsingBlock:^(__kindof SHTableEntry *entry, NSUInteger toIndex, BOOL * _Nonnull stop) {
        if (entry.indexInFrom.count == 0) {
            return;
        }
        NSUInteger fromIndex = entry.indexInFrom.firstIndex;
        BOOL condition1 = entry.toCounter == 1 && entry.fromCounter == 1;
        BOOL condition2 = entry.toCounter > 0 && entry.fromCounter > 0 && fromEntrys[fromIndex] == toEntrys[toIndex];
        if (condition1 || condition2) {
            toEntrys[toIndex] = [SHOtherEntry entryWithIndexInOther:fromIndex];
            fromEntrys[fromIndex] = [SHOtherEntry entryWithIndexInOther:toIndex];
        }
    }];
    
    
    // process deep diff
    __block NSMutableArray <NSIndexPath *> *inserts     = [NSMutableArray array];
    __block NSMutableArray <NSIndexPath *> *deletes     = [NSMutableArray array];
    __block NSMutableArray <NSIndexPath *> *replaces    = [NSMutableArray array];
    __block NSMutableArray <SHMoveIndexPath *> *moves   = [NSMutableArray array];
    
    __block NSUInteger deleteOffset = 0;
    __block NSMutableArray <NSNumber *> *deleteOffsetArray  = [NSMutableArray array];
    [fromEntrys enumerateObjectsUsingBlock:^(__kindof SHEntry * _Nonnull obj, NSUInteger fromIndex, BOOL * _Nonnull stop) {
        [deleteOffsetArray addObject:@(deleteOffset)];
        
        // process delete entry
        if ([obj isKindOfClass:[SHTableEntry class]]) {
            [deletes addObject:[NSIndexPath indexPathForRow:fromIndex inSection:section]];
            deleteOffset ++;
        }
    }];
    
    __block NSUInteger insertOffset = 0;
    [toEntrys enumerateObjectsUsingBlock:^(__kindof SHEntry * _Nonnull obj, NSUInteger toIndex, BOOL * _Nonnull stop) {
        
        // process insert entry
        if ([obj isKindOfClass:[SHTableEntry class]]) {
            [inserts addObject:[NSIndexPath indexPathForRow:toIndex inSection:section]];
            insertOffset ++;
        }
        
        // process ohter entry。
        if ([obj isKindOfClass:[SHOtherEntry class]]) {
            SHOtherEntry *entry = (SHOtherEntry *)obj;
            NSUInteger fromIndex = entry.indexInOther;
            id fromItem = fromList[fromIndex];
            id toItem = toList[toIndex];
            if (![fromItem isEqual:toItem]) {
                [replaces addObject:[NSIndexPath indexPathForRow:toIndex inSection:section]];
            }
            
            NSUInteger deleteOffset = [deleteOffsetArray[fromIndex] unsignedIntegerValue];
            if (fromIndex - deleteOffset + insertOffset != toIndex) {
                SHMoveIndexPath *move = [[SHMoveIndexPath alloc] init];
                move.from  = [NSIndexPath indexPathForRow:fromIndex inSection:section];
                move.to    = [NSIndexPath indexPathForRow:toIndex inSection:section];
                [moves addObject:move];
            }
        }
    }];
    
    SHIndexPathConverter *converter = [[SHIndexPathConverter alloc] init];
    converter.inserts = inserts;
    converter.deletes = deletes;
    converter.replaces = replaces;
    converter.moves = moves;
    return converter;
}




+ (SHChange *)changeWithFromList:(NSArray <__kindof NSObject *> *)fromList toList:(NSArray <__kindof NSObject *> *)toList {
    
    __block NSMutableDictionary <__kindof NSNumber *, __kindof SHEntry *> *map = [NSMutableDictionary dictionary];
    __block NSMutableArray <__kindof SHEntry *> *fromEntrys  = [NSMutableArray array];
    __block NSMutableArray <__kindof SHEntry *> *toEntrys  = [NSMutableArray array];
    
    // process 'to list'
    [toList enumerateObjectsUsingBlock:^(__kindof NSObject *obj, NSUInteger toIndex, BOOL * _Nonnull stop) {
        NSNumber *key = @(obj.hash);
        SHTableEntry *entry = map[key];
        if (!entry || ![entry isKindOfClass:[SHTableEntry class]]) {
            entry = [[SHTableEntry alloc] init];
        }
        entry.toCounter ++;
        [toEntrys addObject:entry];
        map[key] = entry;
    }];
    
    // process 'from list'
    [fromList enumerateObjectsUsingBlock:^(__kindof NSObject *obj, NSUInteger fromIndex, BOOL * _Nonnull stop) {
        NSNumber *key = @(obj.hash);
        SHTableEntry *entry = map[key];
        if (!entry || ![entry isKindOfClass:[SHTableEntry class]]) {
            entry = [[SHTableEntry alloc] init];
        }
        entry.fromCounter ++;
        [entry.indexInFrom addIndex:fromIndex];
        [fromEntrys addObject:entry];
        map[key] = entry;
    }];
    
    // process 'from entrys' & 'to entrys'
    [toEntrys enumerateObjectsUsingBlock:^(__kindof SHTableEntry *entry, NSUInteger toIndex, BOOL * _Nonnull stop) {
        if (entry.indexInFrom.count == 0) {
            return;
        }
        NSUInteger fromIndex = entry.indexInFrom.firstIndex;
        BOOL condition1 = entry.toCounter == 1 && entry.fromCounter == 1;
        BOOL condition2 = entry.toCounter > 0 && entry.fromCounter > 0 && fromEntrys[fromIndex] == toEntrys[toIndex];
        if (condition1 || condition2) {
            toEntrys[toIndex] = [SHOtherEntry entryWithIndexInOther:fromIndex];
            fromEntrys[fromIndex] = [SHOtherEntry entryWithIndexInOther:toIndex];
        }
    }];
    
    
    // process deep diff
    __block NSMutableArray <SHInsert *> *inserts            = [NSMutableArray array];
    __block NSMutableArray <SHDelete *> *deletes            = [NSMutableArray array];
    __block NSMutableArray <SHReplace *> *replaces          = [NSMutableArray array];
    __block NSMutableArray <SHMove *> *moves                = [NSMutableArray array];
    
    __block NSUInteger deleteOffset = 0;
    __block NSMutableArray <NSNumber *> *deleteOffsetArray  = [NSMutableArray array];
    [fromEntrys enumerateObjectsUsingBlock:^(__kindof SHEntry * _Nonnull obj, NSUInteger fromIndex, BOOL * _Nonnull stop) {
        [deleteOffsetArray addObject:@(deleteOffset)];
        
        // process delete entry
        if ([obj isKindOfClass:[SHTableEntry class]]) {
            [deletes addObject:[SHDelete deleteWithIndex:fromIndex item:fromList[fromIndex]]];
            deleteOffset ++;
        }
    }];
    
    __block NSUInteger insertOffset = 0;
    [toEntrys enumerateObjectsUsingBlock:^(__kindof SHEntry * _Nonnull obj, NSUInteger toIndex, BOOL * _Nonnull stop) {
        
        // process insert entry
        if ([obj isKindOfClass:[SHTableEntry class]]) {
            [inserts addObject:[SHInsert insertWithIndex:toIndex item:toList[toIndex]]];
            insertOffset ++;
        }
        
        // process ohter entry。
        if ([obj isKindOfClass:[SHOtherEntry class]]) {
            SHOtherEntry *entry = (SHOtherEntry *)obj;
            NSUInteger fromIndex = entry.indexInOther;
            id fromItem = fromList[fromIndex];
            id toItem = toList[toIndex];
            if (![fromItem isEqual:toItem]) {
                [replaces addObject:[SHReplace replaceWithIndex:toIndex fromItem:fromItem toItem:toItem]];
            }
            
            NSUInteger deleteOffset = [deleteOffsetArray[fromIndex] unsignedIntegerValue];
            if (fromIndex - deleteOffset + insertOffset != toIndex) {
                [moves addObject:[SHMove moveWithFromIndex:fromIndex toIndex:toIndex item:toItem]];
            }
        }
    }];
    
    SHChange *change = [[SHChange alloc] init];
    change.inserts = inserts;
    change.deletes = deletes;
    change.replaces = replaces;
    change.moves = moves;
    return change;
}



@end
