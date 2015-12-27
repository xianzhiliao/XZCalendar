//
//  DimensMacros.h
//  GrapeLife
//  定义尺寸类的宏
//  Created by HuangDabiao on 15/5/18.
//  Copyright (c) 2015年 HuangDabiao. All rights reserved.
//

#ifndef GrapeLife_DimensMacros_h
#define GrapeLife_DimensMacros_h

/** 是否存在热点 */
#define IS_HOTSPOT_CONNECTED ([UIApplication sharedApplication].statusBarFrame.size.height==40?YES:NO)

/** navigation bar纵向高度 */
#define NAVBAR_HEIGHT 64

/** tarbar高度 */
#define TABBAR_HEIGHT 49.0f

/** 状态栏高度 */
#define STATUS_BAR_HEIGHT (IS_HOTSPOT_CONNECTED ? 0 : 20)

/** 视图模块之间间隔 */
#define MARGIN_OF_BLOCK 8

/** 默认头部高度 */
#define HEADER_COMMON_HEIGHT ScalePercent_MUL(29)

/** 加载更多高度 */
#define LOAD_MORE_VIEW_HEIGHT ScalePercent_MUL(39)

/** 线条高度 */
#define LINE_HEIGHT                 (1.0/[UIScreen mainScreen].scale)

/** 默认单元格高度 */
#define CELL_HEIGHT_DEFAULT         42.0

/** 按钮默认高度 */
#define BUTTON_HEIGHT_DEFAULT       44.0

/** 按钮高度(小) */
#define BUTTON_HEIGHT_SMALL         40.0

/** 按钮上边距 */
#define MARGIN_TOP_BUTTON           15.0

/** 默认左边距 */
#define MARGIN_LEFT_DEFAULT         10.0
/** 默认右边距 */
#define MARGIN_RIGHT_DEFAULT        10.0
/** 默认上边距 */
#define MARGIN_TOP_DEFAULT          10.0
/** 默认下边距 */
#define MARGIN_BOTTOM_DEFAULT       10.0

/** 默认水平间距 */
#define SPACE_HORIZONTAL_DEFAULT    10.0
/** 默认垂直间距 */
#define SPACE_VERTICAL_DEFAULT      10.0

/** 缩放比率 */
#define ScalePercent (SCREEN_WIDTH / 320)
#define ScalePercent_MUL(x) (int)(ScalePercent * x)

// 手机屏幕尺寸
#define iPhone5_Size ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4_Size ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6_Size ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6P_Size ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//屏幕 rect
#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT (IS_HOTSPOT_CONNECTED ? ([UIScreen mainScreen].bounds.size.height) - 20 : ([UIScreen mainScreen].bounds.size.height))

#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVBAR_HEIGHT)

/** UIWindow */
#define KEY_WINDOW_VIEW [[UIApplication sharedApplication] keyWindow]

//屏幕分辨率
#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))

#define SIZE_TEXT_MIN                               11.0f
#define SIZE_TEXT_SMALLSmall                        12.0f
#define SIZE_TEXT_CONTENT_NORMAL                    13.0f
#define SIZE_TEXT_TITLE_MINI                        14.0f
#define SIZE_TEXT_TITLE_NORMAL                      15.0f
#define SIZE_TEXT_LARGE                             16.0f
#define SIZE_TEXT_HUGE                              17.0f

/** 最小字号 */
#define PT_FONTSIZE_MININUM       10.0f
/** 小字号 */
#define PT_FONTSIZE_SMALL         12.0f
/** 中等字号 */
#define PT_FONTSIZE_MEDIUM        14.0f
/** 中等字号2 */
#define PT_FONTSIZE_MEDIUM2       15.0f
/** 大字号 */
#define PT_FONTSIZE_LARGE         16.0f
/** 最大字号 */
#define PT_FONTSIZE_MAXIMUM       18.0f
/** 最最大字号 */
#define PT_FONTSIZE_MAXMAXIMUM    24.0f

/** 导航条标题 */
#define FONTSIZE_BARTITLE       PT_FONTSIZE_MAXIMUM
/** 导航条次级标题 */
#define FONTSIZE_BARSUBTITLE    PT_FONTSIZE_SMALL
/** 主标题 */
#define FONTSIZE_MAINTITLE      PT_FONTSIZE_MAXIMUM
/** 标题 */
#define FONTSIZE_TITLE          PT_FONTSIZE_LARGE
/** 次级标题 */
#define FONTSIZE_SUBTITLE       PT_FONTSIZE_MEDIUM
/** 内容 */
#define FONTSIZE_CONTENT        PT_FONTSIZE_SMALL
/** 文本 */
#define FONTSIZE_TEXT           PT_FONTSIZE_MEDIUM2
/** 按钮 */
#define FONTSIZE_BUTTON         PT_FONTSIZE_LARGE
/** 图片按钮 */
#define FONTSIZE_IMAGEBUTTON    PT_FONTSIZE_SMALL
/** 标签 */
#define FONTSIZE_TAG            PT_FONTSIZE_MININUM
/** 分区标题 */
#define FONTSIZE_SECTION_TITLE  PT_FONTSIZE_SMALL
/** 特殊大文字 */
#define FONTSIZE_MAXMAX         PT_FONTSIZE_MAXMAXIMUM

#pragma mark - 字体颜色
/** 颜色，RGB数值，从0～255.0 */
#define RGB_ACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
/** 白色 */
#define PT_COLOR_WHITE         RGB_ACOLOR(255, 255, 255, 1.0)
/** 红色 弃用 */
//#define PT_COLOR_RED           RGB_ACOLOR(255, 102, 83, 1.0)
/** 橙红色 */
#define PT_COLOR_RED1          RGB_ACOLOR(251, 102, 51, 1.0)
/** 橙红色高亮 */
#define PT_COLOR_RED1_HIGHLIGHT          RGB_ACOLOR(229, 92, 46, 1.0)
/** 橙色1 */
#define PT_COLOR_ORANGE        RGB_ACOLOR(255, 128, 37, 1.0)
/** 橙色2 */
#define PT_COLOR_ORANGE1       RGB_ACOLOR(255, 174, 70, 1.0)
/** 浅橙色 */
#define PT_COLOR_LIGHTORANGE   RGB_ACOLOR(255, 251, 236, 1.0)
/** 绿色 */
#define PT_COLOR_GREEN         RGB_ACOLOR(70, 197, 120, 1.0)
/** 绿色半透明 */
#define PT_COLOR_GREEN_ALPHA   RGB_ACOLOR(70, 197, 120, 0.5)
/** 深绿色 */
#define PT_COLOR_DARKGREEN     RGB_ACOLOR(63, 177, 108, 1.0)
/** 浅绿色 */
#define PT_COLOR_LIGHTGREEN    RGB_ACOLOR(237, 247, 242, 1.0)
/** 黑色 */
#define PT_COLOR_BLACK         RGB_ACOLOR(51, 51, 51, 1.0)
/** 深灰色 */
#define PT_COLOR_DARKGRAY      RGB_ACOLOR(102, 102, 102, 1.0)
/** 灰色 */
#define PT_COLOR_GRAY          RGB_ACOLOR(153, 153, 153, 1.0)
/** 浅灰色1号 */
#define PT_COLOR_LIGHTGRAY1    RGB_ACOLOR(224, 224, 224, 1.0)
/** 浅灰色2号 */
#define PT_COLOR_LIGHTGRAY2    RGB_ACOLOR(240, 240, 240, 1.0)
/** 浅灰色3号 */
#define PT_COLOR_LIGHTGRAY3    RGB_ACOLOR(210, 210, 210, 1.0)
/** 蓝色 */
#define PT_COLOR_BLUE          RGB_ACOLOR(12, 163, 233, 1.0)
/** 浅蓝色 */
#define PT_COLOR_LIGHTBLUE     RGB_ACOLOR(0, 198, 255, 1.0)
/** 灰白色 */
#define PT_COLOR_GRAYWHITE     RGB_ACOLOR(249, 249, 249, 1.0)
/** 深蓝色 */
#define PT_COLOR_NAVYBLUE      RGB_ACOLOR(26.0, 74.0, 127.0, 1.0)

/** 背景颜色 */
#define COLOR_VIEW_BACKGROUND           PT_COLOR_WHITE
/** 背景颜色(灰) */
#define COLOR_VIEW_BACKGROUND_GRAY      PT_COLOR_LIGHTGRAY2
/** 默认图片颜色 */
#define COLOR_IMAGEVIEW_DEFAULT         PT_COLOR_LIGHTGRAY3
/** 主色调 */
#define COLOR_MAIN                      PT_COLOR_GREEN
/** 主色调半透明（按钮不可点击颜色） */
#define COLOR_MAIN_HALFALPHA            PT_COLOR_GREEN_ALPHA
/** 主色调(选中颜色) */
#define COLOR_MAIN_HIGHLIGHTED          PT_COLOR_DARKGREEN
/** 主色调(浅色) */
#define COLOR_MAIN_LIGHTED              PT_COLOR_LIGHTGREEN
/** 标题颜色 */
#define COLOR_TEXT_TITLE                PT_COLOR_BLACK
/** 副标题颜色 */
#define COLOR_TEXT_SUBTITLE             PT_COLOR_GRAY
/** 默认文本颜色 */
#define COLOR_TEXT_DEFAULT              PT_COLOR_DARKGRAY
/** 文本颜色(红) 弃用 */
//#define COLOR_TEXT_RED                  PT_COLOR_RED
/** 文本颜色(橙红) */
#define COLOR_TEXT_RED1                 PT_COLOR_RED1
/** 文本颜色(橙) */
#define COLOR_TEXT_ORANGE               PT_COLOR_ORANGE
/** 文本颜色(蓝) */
#define COLOR_TEXT_BLUE                 PT_COLOR_BLUE
/** 线条,描边,边框颜色 */
#define COLOR_LINE                      PT_COLOR_LIGHTGRAY1
/** 警告文本颜色 */
#define COLOR_WARNING                   PT_COLOR_ORANGE1
/** 警告背景颜色 */
#define COLOR_WARNING_BG                PT_COLOR_LIGHTORANGE
/** 帮助文本颜色 */
#define COLOR_HELP                      PT_COLOR_LIGHTBLUE
/** nav背景颜色*/
#define COLOR_NAVOGATION_BG             PT_COLOR_GRAYWHITE
/** 系统功能(深蓝色)*/
#define COLOR_FUNCTION                  PT_COLOR_NAVYBLUE
/******************* 弃用  *******************/
/** view背景颜色(深) */
#define COLOR_VIEW_BACKGROUND_DARK   PT_COLOR_LIGHTGRAY2
/** view背景颜色(深) 透明度 */
#define COLOR_VIEW_BACKGROUND_DARK_ALPHA(alpha) RGB_ACOLOR(240, 240, 240, alpha)
/** 字体颜色(浅) */
#define COLOR_TEXT_LIGHT        PT_COLOR_GRAY
/** 字体颜色(深) */
#define COLOR_TEXT_DARK         PT_COLOR_BLACK
/** 功能块选中颜色 */
#define COLOR_VIEW_SELECTED     PT_COLOR_LIGHTGRAY1
/** 导航栏字体浅色 */
#define COLOR_TEXT_NAVI_LIGHT   [UIColor colorWithWhite:1.0 alpha:0.6]
/** 默认主色调 透明度 */
#define COLOR_MAIN_ALPHA(alpha) RGB_ACOLOR(70, 197, 120, alpha)
#endif
