//
//  ConvertString.m
//  ObjcSegmentPushApp
//
//  Created by FUJITSU CLOUD TECHNOLOGIES on 2016/10/19.
//  Copyright 2020 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

#import "ConvertString.h"

@implementation ConvertString

/**
 installationのvalueの値をNSStringクラスに変換する
 @param anyObject NSArray or NSDictionary or NSString オブジェクト
 @return 文字列
 */
+ (NSString *)convertNSStringToAnyObject:(id)anyObject {
    
    if ([anyObject isKindOfClass:[NSArray class]]) {
        // NSArrayをNSStringに変換する
        return [anyObject componentsJoinedByString:@","];;
    } else if ([anyObject isKindOfClass:[NSDictionary class]]) {
        // NSDictionaryをNSStringに変換する
        NSError*error=nil;
        NSData*data=[NSJSONSerialization dataWithJSONObject:anyObject options:2 error:&error];
        return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    } else {
        // NSStringはNSStringのまま
        return [NSString stringWithFormat:@"%@",anyObject];
    }
}

@end
