//
//  YBLogDefine.h
//  DDKuaiqian
//
//  Created by asance on 2017/11/29.
//  Copyright © 2017年 asance. All rights reserved.
//

#ifndef YBLogDefine_h
#define YBLogDefine_h
#ifdef __OBJC__

#if DEBUG
#define YBLog(...) NSLog(__VA_ARGS__)
#else
#define YBLog(...)
#endif

#endif
#endif /* YBLogDefine_h */
