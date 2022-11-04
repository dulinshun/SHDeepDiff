//
//  SHIndexPathConverter.m
//  SHDeepDiff
//
//  Created by 花生 on 2022/11/3.
//

#import "SHIndexPathConverter.h"

@implementation SHMoveIndexPath

@end

@implementation SHIndexPathConverter

+ (instancetype)converterWithChange:(SHChange *)change section:(NSInteger)section {

    __block NSMutableArray <NSIndexPath *> *inserts     = [NSMutableArray array];
    __block NSMutableArray <NSIndexPath *> *deletes     = [NSMutableArray array];
    __block NSMutableArray <NSIndexPath *> *replaces    = [NSMutableArray array];
    __block NSMutableArray <SHMoveIndexPath *> *moves   = [NSMutableArray array];
    
    [change.inserts enumerateObjectsUsingBlock:^(SHInsert * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [inserts addObject:[NSIndexPath indexPathForRow:obj.index inSection:section]];
    }];
    [change.deletes enumerateObjectsUsingBlock:^(SHDelete * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [deletes addObject:[NSIndexPath indexPathForRow:obj.index inSection:section]];
    }];
    [change.replaces enumerateObjectsUsingBlock:^(SHReplace * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [replaces addObject:[NSIndexPath indexPathForRow:obj.index inSection:section]];
    }];
    [change.moves enumerateObjectsUsingBlock:^(SHMove * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SHMoveIndexPath *move = [[SHMoveIndexPath alloc] init];
        move.from  = [NSIndexPath indexPathForRow:obj.fromIndex inSection:section];
        move.to    = [NSIndexPath indexPathForRow:obj.toIndex inSection:section];
    }];
    
    SHIndexPathConverter *converter = [[SHIndexPathConverter alloc] init];
    converter.inserts = inserts;
    converter.deletes = deletes;
    converter.replaces = replaces;
    converter.moves = moves;
    return converter;
}

@end
