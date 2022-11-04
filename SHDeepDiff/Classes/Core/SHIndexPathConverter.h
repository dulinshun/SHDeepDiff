//
//  SHIndexPathConverter.h
//  SHDeepDiff
//
//  Created by 花生 on 2022/11/3.
//

#import <Foundation/Foundation.h>
#import "SHChange.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHMoveIndexPath : NSObject
@property (nonatomic, strong) NSIndexPath *from;
@property (nonatomic, strong) NSIndexPath *to;
@end

@interface SHIndexPathConverter : NSObject

@property (nonatomic, copy) NSArray <NSIndexPath *> *inserts;
@property (nonatomic, copy) NSArray <NSIndexPath *> *deletes;
@property (nonatomic, copy) NSArray <NSIndexPath *> *replaces;
@property (nonatomic, copy) NSArray <SHMoveIndexPath *> *moves;

+ (instancetype)converterWithChange:(SHChange *)change section:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
