//
//  SHDataModel.h
//  SHDeepDiff_Example
//
//  Created by 花生 on 2022/11/3.
//  Copyright © 2022 huasheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHDataModel : NSObject

@property (nonatomic, copy) NSString *title;

+ (NSArray <SHDataModel *> *)randomModels;

+ (NSArray <SHDataModel *> *)randomChange:(NSArray <SHDataModel *> *)models;

+ (NSArray <SHDataModel *> *)randomInsertOrDelete:(NSArray <SHDataModel *> *)models;

@end

NS_ASSUME_NONNULL_END
