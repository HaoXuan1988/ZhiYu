//
//  UIFont+HXExtension.h
//  HXNetworkDemo
//
//  Created by 吕浩轩 on 16/4/11.
//  Copyright © 2016年 吕浩轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (HXExtension)
/**
 *  打印并显示所有字体
 */
+(void)showAllFonts;

/**
 *  先致 默认字体
 */
+(UIFont *)xz_defaultFontOfSize:(CGFloat)size;

/**
 *  先致 默认粗体
 */
+(UIFont *)xz_boldFontOfSize:(CGFloat)size;




/**
 *  苹方-简 细体 (先致 默认字体)
 */
+(UIFont *)PingFangSC_LightFontOfSize:(CGFloat)size;

/**
 *  苹方-简 中黑体 (先致 默认加黑的字体) (系统默认加黑)
 */
+(UIFont *)PingFangSC_MediumFontOfSize:(CGFloat)size;

/**
 *  苹方-简 常规体 (系统默认)
 */
+(UIFont *)PingFangSC_RegularFontOfSize:(CGFloat)size;

/**
 *  苹方-简 极细体
 */
+(UIFont *)PingFangSC_UltralightFontOfSize:(CGFloat)size;

/**
 *  苹方-简 纤细体
 */
+(UIFont *)PingFangSC_ThinFontOfSize:(CGFloat)size;

/**
 *  苹方-简 中粗体
 */
+(UIFont *)PingFangSC_SemiboldFontOfSize:(CGFloat)size;




/**
 *  宋体(字体缺失)
 */
+(UIFont *)songTypefaceFontOfSize:(CGFloat)size;

/**
 *  微软雅黑：正常字体
 */
+(UIFont *)microsoftYaHeiFontOfSize:(CGFloat)size;


/**
 *  微软雅黑：加粗字体(字体缺失)
 */
+(UIFont *)boldMicrosoftYaHeiFontOfSize:(CGFloat)size;


/**
 *  DroidSansFallback
 */
+(UIFont *)customFontNamedDroidSansFallbackWithFontOfSize:(CGFloat)size;
@end
