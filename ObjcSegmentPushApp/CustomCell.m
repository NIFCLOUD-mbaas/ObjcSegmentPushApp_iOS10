//
//  CustomCell.m
//  ObjcSegmentPushApp
//
//  Created by FUJITSU CLOUD TECHNOLOGIES on 2016/10/18.
//  Copyright 2020 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
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
 通常セル (内容を表示するだけ)
 @param keyStr keyラベルに表示する文字列
 @param valueStr valueラベルに表示する文字列
 */
- (void)setCellWithKey:(NSString *)keyStr value:(id)valueStr {
    
    self.keyLabel = [[UILabel alloc]init];
    self.keyLabel.backgroundColor = [UIColor blueColor];
    self.keyLabel.text = keyStr;
    self.keyLabel.textColor = [UIColor whiteColor];
    self.keyLabel.textAlignment = NSTextAlignmentCenter;
    self.keyLabel.font = [UIFont systemFontOfSize:12.0f];
    self.keyLabel.numberOfLines = 0;
    
    self.valueLabel = [[UILabel alloc]init];
    self.valueLabel.backgroundColor = [UIColor blackColor];
    if (valueStr) {
        self.valueLabel.text = [ConvertString convertNSStringToAnyObject:valueStr];
        self.valueLabel.textColor = [UIColor whiteColor];
        if ([self.reuseIdentifier isEqualToString:NOMAL_CELL_IDENTIFIER]) {
            self.valueLabel.textAlignment = NSTextAlignmentCenter;
        }
        self.valueLabel.font = [UIFont systemFontOfSize:12.0f];
        self.valueLabel.numberOfLines = 0;
    }
    
    [self addSubview:self.keyLabel];
    [self addSubview:self.valueLabel];
    
    [self setNeedsLayout];
}

/**
 value編集セル
 @param keyStr keyラベルに表示する文字列
 @param valueStr valueテキストフィールドに表示する文字列
 */
- (void)setCellWithKey:(NSString *)keyStr editValue:(id)valueStr {
    
    self.keyLabel = [[UILabel alloc]init];
    self.keyLabel.backgroundColor = [UIColor blueColor];
    self.keyLabel.text = keyStr;
    self.keyLabel.textColor = [UIColor whiteColor];
    self.keyLabel.textAlignment = NSTextAlignmentCenter;
    self.keyLabel.font = [UIFont systemFontOfSize:12.0f];
    self.keyLabel.numberOfLines = 0;
    
    self.valueField = [[UITextField alloc]init];
    self.valueField.borderStyle = UITextBorderStyleRoundedRect;
    self.valueField.placeholder = @"value";
    if (valueStr) {
        self.valueField.text = [ConvertString convertNSStringToAnyObject:valueStr];
        self.valueField.textAlignment = NSTextAlignmentCenter;
        self.valueField.font = [UIFont systemFontOfSize:12.0f];
    }
    
    [self addSubview:self.keyLabel];
    [self addSubview:self.valueField];
    
    [self setNeedsLayout];
}

/**
 セルの最後は、追加keyと追加valueと更新ボタンを表示する
 */
- (void)setAddRecordCell {
    
    self.keyField = [[UITextField alloc]init];
    self.keyField.borderStyle = UITextBorderStyleRoundedRect;
    self.keyField.placeholder = @"追加key";
    self.keyField.textAlignment = NSTextAlignmentCenter;
    self.keyField.font = [UIFont systemFontOfSize:12.0f];
    
    self.valueField = [[UITextField alloc]init];
    self.valueField.borderStyle = UITextBorderStyleRoundedRect;
    self.valueField.placeholder = @"追加value";
    self.valueField.textAlignment = NSTextAlignmentCenter;
    self.valueField.font = [UIFont systemFontOfSize:12.0f];
    
    // 更新ボタン
    self.postBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.postBtn.backgroundColor = [UIColor blackColor];
    [self.postBtn setTitle:@"更新" forState:UIControlStateNormal];
    [self.postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self addSubview:self.keyField];
    [self addSubview:self.valueField];
    [self addSubview:self.postBtn];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    if ([self.reuseIdentifier isEqualToString:NOMAL_CELL_IDENTIFIER] || [self.reuseIdentifier isEqualToString:TOKEN_CELL_IDENTIFIER]) {
        // ノーマルセルとdeviceTokenセル
        self.keyLabel.frame = CGRectMake(0.0f + CellMargin, 0.0f + CellMargin, self.frame.size.width * 0.3f - CellMargin, self.frame.size.height - CellMargin);
        self.valueLabel.frame = CGRectMake(self.frame.size.width * 0.3f + CellMargin, 0.0f + CellMargin, self.frame.size.width * 0.7f - CellMargin * 2.0f, self.frame.size.height - CellMargin);
    } else if ([self.reuseIdentifier isEqualToString:EDIT_CELL_IDENTIFIER]) {
        // value編集セル
        self.keyLabel.frame = CGRectMake(0.0f + CellMargin, 0.0f + CellMargin, self.frame.size.width * 0.3f - CellMargin, self.frame.size.height - CellMargin);
        self.valueField.frame = CGRectMake(self.frame.size.width * 0.3f + CellMargin, 0.0f + CellMargin, self.frame.size.width * 0.7f - CellMargin * 2.0f, TABLE_VIEW_CELL_HEIGHT - CellMargin);
    } else {
        // 最後のセル
        self.keyField.frame = CGRectMake(0.0f + CellMargin, 0.0f + CellMargin, self.frame.size.width * 0.3f - CellMargin, TABLE_VIEW_CELL_HEIGHT - CellMargin);
        self.valueField.frame = CGRectMake(self.frame.size.width * 0.3f + CellMargin, 0.0f + CellMargin, self.frame.size.width * 0.7f - CellMargin * 2.0f, TABLE_VIEW_CELL_HEIGHT - CellMargin);
        self.postBtn.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 100) / 2.0f, self.valueField.frame.size.height + 20.0f, 100.0f, 50.0f);
    }
}

@end
