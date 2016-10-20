//
//  ConvertString.h
//  ObjcSegmentPushApp
//
//  Created by Nifty on 2016/10/19.
//  Copyright © 2016年 Nifty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConvertString : NSObject

/**
 installationのvalueの値をNSStringクラスに変換する
 @param anyObject NSArray or NSDictionary or NSString オブジェクト
 */
+ (NSString *)convertNSStringToAnyObject:(id)anyObject;

/**
 引数で渡された文字列に「,」が含まれる場合にNSArrayオブジェクトに変換する
 @param str 文字列
 */
+ (id)convertNSArrayToNSString:(NSString *)str;

@end
