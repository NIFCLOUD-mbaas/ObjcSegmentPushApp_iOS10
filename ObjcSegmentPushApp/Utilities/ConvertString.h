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

@end
