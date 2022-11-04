//
//  SHDataModel.m
//  SHDeepDiff_Example
//
//  Created by 花生 on 2022/11/3.
//  Copyright © 2022 huasheng. All rights reserved.
//

#import "SHDataModel.h"

@implementation SHDataModel

+ (NSArray <NSString *> *)totalTitle {
    return @[@"张飞", @"马超", @"黄忠", @"魏延", @"刘备", @"赵云", @"诸葛亮", @"邓艾", @"糜竺", @"刘备", @"刘禅", @"庞统", @"法正", @"孟获", @"孟忧"];;
}

+ (NSArray <SHDataModel *> *)totalModels {
    NSArray *titles = [self totalTitle];
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *title in titles) {
        SHDataModel *model = [[SHDataModel alloc] init];
        model.title = title;
        [array addObject:model];
    }
    return [array copy];
}

+ (NSArray <SHDataModel *> *)randomModels {
    return [self randomChange:[self totalModels]];
}

+ (NSArray <SHDataModel *> *)randomChange:(NSArray <SHDataModel *> *)models {
    NSMutableArray *array = [NSMutableArray arrayWithArray:models];
    NSMutableArray *results = [NSMutableArray array];
    [self randomModel:array results:results];
    return [results copy];
}

+ (void)randomModel:(NSMutableArray <SHDataModel *> *)models results:(NSMutableArray *)results {
    if (models.count == 0) {
        return;
    }
    NSUInteger count = models.count;
    NSUInteger index = arc4random()%count;
    SHDataModel *model = models[index];
    [results addObject:model];
    [models removeObject:model];
    [self randomModel:models results:results];
}

+ (NSArray <SHDataModel *> *)randomInsertOrDelete:(NSArray <SHDataModel *> *)models {
    NSArray *titles = [self totalTitle];
    NSUInteger count = titles.count;
    NSUInteger index = arc4random()%count;
    NSString *title = titles[index];
    SHDataModel *tmpModel = nil;
    for (SHDataModel *model in models) {
        if ([model.title isEqualToString:title]) {
            tmpModel = model;
            break;
        }
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:models];
    if (tmpModel) {
        [array removeObject:tmpModel];
    } else {
        tmpModel = [[SHDataModel alloc] init];
        tmpModel.title = title;
        [array addObject:tmpModel];
    }
    return  [array copy];
}

@end
