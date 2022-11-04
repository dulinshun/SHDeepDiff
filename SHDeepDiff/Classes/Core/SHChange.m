//
//  SHChange.m
//  SHDeepDiff
//
//  Created by 花生 on 2022/11/3.
//

#import "SHChange.h"

@implementation SHInsert
+ (instancetype)insertWithIndex:(NSUInteger)index item:(id)item {
    SHInsert *model = [[SHInsert alloc] init];
    model.index = index;
    model.item = item;
    return model;
}
@end


@implementation SHDelete
+ (instancetype)deleteWithIndex:(NSUInteger)index item:(id)item {
    SHDelete *model = [[SHDelete alloc] init];
    model.index = index;
    model.item = item;
    return model;
}
@end


@implementation SHReplace
+ (instancetype)replaceWithIndex:(NSUInteger)index fromItem:(id)fromItem toItem:(id)toItem {
    SHReplace *model = [[SHReplace alloc] init];
    model.index = index;
    model.fromItem = fromItem;
    model.toItem = toItem;
    return model;
}
@end


@implementation SHMove
+ (instancetype)moveWithFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex item:(id)item {
    SHMove *model = [[SHMove alloc] init];
    model.fromIndex = fromIndex;
    model.toIndex = toIndex;
    model.item = item;
    return model;
}
@end


@implementation SHChange

- (void)abcde {
    
}

@end
