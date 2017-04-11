//
//  CustomCell.h
//  ObjcSegmentPushApp
//
//  Created by FUJITSU CLOUD TECHNOLOGIES on 2016/10/18.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (nonatomic) UILabel *keyLabel;
@property (nonatomic) UILabel *valueLabel;

@property (nonatomic) UITextField *keyField;
@property (nonatomic) UITextField *valueField;
@property (nonatomic) UIButton *postBtn;

- (void)setCellWithKey:(NSString *)keyStr value:(id)valueStr;
- (void)setCellWithKey:(NSString *)keyStr editValue:(id)valueStr;
- (void)setAddRecordCell;

@end
