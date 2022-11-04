//
//  SHHeckel.h
//  Pods
//
//  Created by 花生 on 2022/11/3.
//

#import <Foundation/Foundation.h>
#import "SHChange.h"
#import "SHIndexPathConverter.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHHeckel : NSObject

+ (SHIndexPathConverter *)convertWithFromList:(NSArray <__kindof NSObject *> *)fromList toList:(NSArray <__kindof NSObject *> *)toList section:(NSInteger)section;

+ (SHChange *)changeWithFromList:(NSArray <__kindof NSObject *> *)fromList toList:(NSArray <__kindof NSObject *> *)toList;

@end

NS_ASSUME_NONNULL_END
