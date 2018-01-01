//
//  Created by 0xxd0 on 2016/11/21.
//  Copyright © 2016年 0xxd0. All rights reserved.
//

#import "Array.Sequence"

#import <Foundation/NSException.h>
#import <Foundation/NSNull.h>

_Pragma("clang assume_nonnull begin")

@implementation Array (FastEnumeration)

@end

@implementation Array (Sequence)

- (Array * (^)(id (^)(id)))map {
    return ^id(id (^transform)(id)){
        if (transform == nil) {
            @throw [NSException.alloc initWithName:@""
                                            reason:@"unexpected found nil while calling a nonnull block"
                                          userInfo:nil];
        }
        let result = [ArrayM.alloc initWithCapacity:self.count];
        [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            _Pragma("clang diagnostic push")
            _Pragma("clang diagnostic ignored \"-Wauto-var-id\"")
            if (let value = transform(obj)) {
            _Pragma("clang diagnostic pop")
                [result addObject:value];
            } else {
                [result addObject:NSNull.null];
            }
        }];
        return result.copy;
    };
}

- (Array<id> * (^)(BOOL (^)(id)))filter {
    return ^id(BOOL (^isInclude)(id)){
        if (isInclude == nil) {
            @throw [NSException.alloc initWithName:@""
                                            reason:@"unexpected found nil while calling a nonnull block"
                                          userInfo:nil];
        }
        let result = [ArrayM.alloc initWithCapacity:self.count];
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (let include = isInclude(obj) ?: NO) {
                [result addObject:obj];
            }
        }];
        return result;
    };
}

- (Array * (^)(void (^)(id)))forEach {
    return ^id(void (^body)(id)){
        if (body == nil) {
            @throw [NSException.alloc initWithName:@""
                                            reason:@"unexpected found nil while calling a nonnull block"
                                          userInfo:nil];
        }
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            body(obj);
        }];
        return self;
    };
}

@end

_Pragma("clang assume_nonnull end")
 