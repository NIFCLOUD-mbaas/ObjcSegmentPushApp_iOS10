//
//  AppSetting.h
//  ObjcSegmentPushApp
//
//  Created by Nifty on 2016/10/18.
//  Copyright © 2016年 Nifty. All rights reserved.
//

#ifndef AppSetting_h
#define AppSetting_h

// TableViewのheaderの高さ
#define TABLE_VIEW_HEADER_HEIGHT 17.0f
// TableViewのkeyラベルの幅
#define TABLE_VIEW_KEY_LABEL_WIDTH [[UIScreen mainScreen] bounds].size.width * 0.3f
// TableViewのvalueラベルの幅
#define TABLE_VIEW_VALUE_LABEL_WIDTH [[UIScreen mainScreen] bounds].size.width * 0.7f
// TableViewのセルの高さ
#define TABLE_VIEW_CELL_HEIGHT 45.0f
// deviceToken用のTableViewのセルの高さ
#define DEVICE_TOKEN_CELL_HEIGHT 55.0f
// TableViewのボタン表示用のセルの高さ
#define TABLE_VIEW_POST_BTN_CELL_HEIGHT 130.0f

// cellIdentifier
#define NOMAL_CELL_IDENTIFIER @"nomalCell"
#define TOKEN_CELL_IDENTIFIER @"tokenCell"
#define EDIT_CELL_IDENTIFIER @"editCell"
#define ADD_CELL_IDENTIFIER @"addCell"

#endif /* AppSetting_h */
