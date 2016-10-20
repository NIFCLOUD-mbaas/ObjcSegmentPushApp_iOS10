//
//  CustomCell.m
//  ObjcSegmentPushApp
//
//  Created by Nifty on 2016/10/18.
//  Copyright © 2016年 Nifty. All rights reserved.
//

#import "CustomCell.h"
#import <NCMB/NCMB.h>
#import "AppSetting.h"

#import "ConvertString.h"

@interface CustomCell()

@end

const static CGFloat CellMargin = 5.0f;

@implementation CustomCell

/**
 通常セル
 @param keyStr keyラベルに表示する文字列
 @param valueStr valueラベルに表示する文字列
 */
- (void)setCellWithKey:(NSString *)keyStr value:(id)valueStr {
    
    self.keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f + CellMargin, 0.0f + CellMargin, TABLE_VIEW_KEY_LABEL_WIDTH - CellMargin, self.frame.size.height - CellMargin)];
    self.keyLabel.backgroundColor = [UIColor blueColor];
    self.keyLabel.text = keyStr;
    self.keyLabel.textColor = [UIColor whiteColor];
    self.keyLabel.textAlignment = NSTextAlignmentCenter;
    self.keyLabel.font = [UIFont systemFontOfSize:12.0f];
    
    self.valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(TABLE_VIEW_KEY_LABEL_WIDTH + CellMargin, 0.0f + CellMargin, TABLE_VIEW_VALUE_LABEL_WIDTH - CellMargin * 2.0f, self.frame.size.height - CellMargin)];
    self.valueLabel.backgroundColor = [UIColor blackColor];
    if (valueStr) {
        self.valueLabel.text = [ConvertString convertNSStringToAnyObject:valueStr];
        self.valueLabel.textColor = [UIColor whiteColor];
        self.valueLabel.textAlignment = NSTextAlignmentCenter;
        self.valueLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    
    [self addSubview:self.keyLabel];
    [self addSubview:self.valueLabel];
}

/**
 通常セル
 @param keyStr keyラベルに表示する文字列
 @param valueStr valueテキストフィールドに表示する文字列
 */
- (void)setCellWithKey:(NSString *)keyStr editValue:(id)valueStr {
    
    self.keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f + CellMargin, 0.0f + CellMargin, TABLE_VIEW_KEY_LABEL_WIDTH - CellMargin, self.frame.size.height - CellMargin)];
    self.keyLabel.backgroundColor = [UIColor blueColor];
    self.keyLabel.text = keyStr;
    self.keyLabel.textColor = [UIColor whiteColor];
    self.keyLabel.textAlignment = NSTextAlignmentCenter;
    self.keyLabel.font = [UIFont systemFontOfSize:12.0f];
    
    self.valueField = [[UITextField alloc]initWithFrame:CGRectMake(TABLE_VIEW_KEY_LABEL_WIDTH + CellMargin, 0.0f + CellMargin, TABLE_VIEW_VALUE_LABEL_WIDTH - CellMargin * 2.0f, self.frame.size.height - CellMargin)];
    self.valueField.borderStyle = UITextBorderStyleRoundedRect;
    self.valueField.placeholder = @"value";
    if (valueStr) {
        self.valueField.text = [ConvertString convertNSStringToAnyObject:valueStr];
        self.valueField.textAlignment = NSTextAlignmentCenter;
        self.valueField.font = [UIFont systemFontOfSize:12.0f];
    }

    [self addSubview:self.keyLabel];
    [self addSubview:self.valueField];
}

/**
 セルの最後は、追加keyと追加valueと更新ボタンを表示する
 */
- (void)setAddRecordCell {
    
    self.keyField = [[UITextField alloc]initWithFrame:CGRectMake(0.0f + CellMargin, 0.0f + CellMargin, TABLE_VIEW_KEY_LABEL_WIDTH - CellMargin, TABLE_VIEW_CELL_HEIGHT - CellMargin)];
    self.keyField.borderStyle = UITextBorderStyleRoundedRect;
    self.keyField.placeholder = @"追加key";
    self.keyField.textAlignment = NSTextAlignmentCenter;
    self.keyField.font = [UIFont systemFontOfSize:12.0f];
    
    self.valueField = [[UITextField alloc]initWithFrame:CGRectMake(TABLE_VIEW_KEY_LABEL_WIDTH + CellMargin, 0.0f + CellMargin, TABLE_VIEW_VALUE_LABEL_WIDTH - CellMargin * 2.0f, TABLE_VIEW_CELL_HEIGHT - CellMargin)];
    self.valueField.borderStyle = UITextBorderStyleRoundedRect;
    self.valueField.placeholder = @"追加value";
    self.valueField.textAlignment = NSTextAlignmentCenter;
    self.valueField.font = [UIFont systemFontOfSize:12.0f];
    
    // 更新ボタン
    self.registBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.registBtn.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 100) / 2.0f, self.valueField.frame.size.height + 20.0f, 100.0f, 50.0f);
    self.registBtn.backgroundColor = [UIColor blackColor];
    [self.registBtn setTitle:@"更新" forState:UIControlStateNormal];
    [self.registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self addSubview:self.keyField];
    [self addSubview:self.valueField];
    [self addSubview:self.registBtn];
}

- (void)layoutSubviews {
//    self.reuseIdentifier isEqualToString:@""
}

@end
