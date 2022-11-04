//
//  SHChange.h
//  SHDeepDiff
//
//  Created by 花生 on 2022/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHInsert : NSObject
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, strong) id item;
+ (instancetype)insertWithIndex:(NSUInteger)index item:(id)item;
@end


@interface SHDelete : NSObject
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, strong) id item;
+ (instancetype)deleteWithIndex:(NSUInteger)index item:(id)item;
@end


@interface SHReplace : NSObject
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, strong) id fromItem;
@property (nonatomic, strong) id toItem;
+ (instancetype)replaceWithIndex:(NSUInteger)index fromItem:(id)fromItem toItem:(id)toItem;
@end


@interface SHMove : NSObject
@property (nonatomic, assign) NSUInteger fromIndex;
@property (nonatomic, assign) NSUInteger toIndex;
@property (nonatomic, strong) id item;
+ (instancetype)moveWithFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex item:(id)item;
@end


@interface SHChange : NSObject
@property (nonatomic, copy) NSArray <SHInsert *>    *inserts;
@property (nonatomic, copy) NSArray <SHDelete *>    *deletes;
@property (nonatomic, copy) NSArray <SHReplace *>   *replaces;
@property (nonatomic, copy) NSArray <SHMove *>      *moves;
@end

NS_ASSUME_NONNULL_END
