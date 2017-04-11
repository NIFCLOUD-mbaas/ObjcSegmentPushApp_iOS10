//
//  ConvertString.h
//  ObjcSegmentPushApp
//
//  Created by FUJITSU CLOUD TECHNOLOGIES on 2016/10/19.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

#import <Foundation/Foundation.h>

@interface ConvertString : NSObject

/**
 installationのvalueの値をNSStringクラスに変換する
 @param anyObject NSArray or NSDictionary or NSString オブジェクト
 */
+ (NSString *)convertNSStringToAnyObject:(id)anyObject;

@end
