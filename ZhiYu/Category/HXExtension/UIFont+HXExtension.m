//
//  UIFont+HXExtension.m
//  HXNetworkDemo
//
//  Created by 吕浩轩 on 16/4/11.
//  Copyright © 2016年 吕浩轩. All rights reserved.
//

#import "UIFont+HXExtension.h"

@implementation UIFont (HXExtension)

#pragma mark  打印并显示所有字体
+(void)showAllFonts{
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
}


/**
 *  先致 默认字体
 */
+(UIFont *)xz_defaultFontOfSize:(CGFloat)size{
    return [self systemFontOfSize:size];
}

/**
 *  先致 默认粗体
 */
+(UIFont *)xz_boldFontOfSize:(CGFloat)size{
    return [self boldSystemFontOfSize:size];
}



#pragma mark - 苹方-简 细体 (先致 默认字体)
+(UIFont *)PingFangSC_LightFontOfSize:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Light" size:size];
}

#pragma mark  苹方-简 中黑体 (先致 默认加黑的字体)
+(UIFont *)PingFangSC_MediumFontOfSize:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
}

#pragma mark  苹方-简 常规体
+(UIFont *)PingFangSC_RegularFontOfSize:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}

#pragma mark  苹方-简 极细体
+(UIFont *)PingFangSC_UltralightFontOfSize:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Ultralight" size:size];
}

#pragma mark  苹方-简 纤细体
+(UIFont *)PingFangSC_ThinFontOfSize:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Thin" size:size];
}

#pragma mark  苹方-简 中粗体
+(UIFont *)PingFangSC_SemiboldFontOfSize:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
}




#pragma mark  宋体
+(UIFont *)songTypefaceFontOfSize:(CGFloat)size{
    return [UIFont fontWithName:@"经典宋体简" size:size];
}


#pragma mark  微软雅黑
+(UIFont *)microsoftYaHeiFontOfSize:(CGFloat)size{
    return [UIFont fontWithName:@"MicrosoftYaHei" size:size];
}


#pragma mark  微软雅黑：加粗字体
+(UIFont *)boldMicrosoftYaHeiFontOfSize:(CGFloat)size{
    return [UIFont fontWithName:@"MicrosoftYaHei-Bold" size:size];
}


#pragma mark  DroidSansFallback
+(UIFont *)customFontNamedDroidSansFallbackWithFontOfSize:(CGFloat)size{
    return [UIFont fontWithName:@"DroidSansFallback" size:size];
}


@end
