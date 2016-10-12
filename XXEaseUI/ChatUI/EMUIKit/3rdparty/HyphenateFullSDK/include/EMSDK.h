/*!
 *  \~chinese
 *  @header EMSDK.h
 *  @abstract SDK的头文件
 *  @author Hyphenate
 *  @version 3.00
 *
 *  \~english
 *  @header EMSDK.h
 *  @abstract Headers of SDK
 *  @author Hyphenate
 *  @version 3.00
 */

#ifndef EMSDK_h
#define EMSDK_h

#if TARGET_OS_IPHONE

#import "EMClient.h"
#import "EMClientDelegate.h"

#else


#if __has_include(<HyphenateSDK/EMClient.h>)
#import <HyphenateSDK/EMClient.h>
#else
#import "EMClient.h"
#endif


#if __has_include(<HyphenateSDK/EMClientDelegate.h>)
#import <HyphenateSDK/EMClientDelegate.h>
#else
#import "EMClientDelegate.h"
#endif

#endif


#endif /* EMSDK_h */
