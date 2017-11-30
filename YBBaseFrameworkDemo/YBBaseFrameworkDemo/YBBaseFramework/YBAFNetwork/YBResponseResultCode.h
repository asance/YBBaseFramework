//
//  YBResponseResultCode.h
//  YBNetAgent
//
//  Created by asance on 2017/5/8.
//  Copyright © 2017年 asance. All rights reserved.
//

#ifdef __OBJC__

#define HTTP_RESPONSE_ERROR_NODATA                  (-1)
#define HTTP_RESPONSE_SUCCESS                       (200)
#define HTTP_RESPONSE_ERROR_NETWORK_UNABLE          (1009)
#define HTTP_RESPONSE_ERROR_SERVER_UNABLE           (1004)

#define YB_RESPONSE_SUCCESS                         (10000)
#define YB_RESPONSE_ERROR_INLINE_TEST               (10005)
#define YB_RESPONSE_ERROR_CODE_INPUT                (10006)
#define YB_RESPONSE_ERROR_CODE_UNABLE               (10007)
#define YB_RESPONSE_ERROR_MOBILE_FORMAT             (10008)
#define YB_RESPONSE_ERROR_AMOUNT_UNABLE             (10009)

#define YB_RESPONSE_ERROR_NULL                      (-900)
#define YB_RESPONSE_ERROR_NO_MORE_DATA              (-901)
#define YB_RESPONSE_ERROR_ILLEGAL_URL               (-902)
#define YB_RESPONSE_ERROR_ILLEGAL_PARAMS            (-903)
#define YB_RESPONSE_ERROR_NO_RESPONSE               (-904)

#define YB_KEY_ERROR                                (@"YBKeyError")
#define YB_KEY_PARAMS                               (@"YBKeyParams")
#define YB_KEY_APISEL                               (@"YBKeyAPISEL")
#define YB_KEY_DATA                                 (@"YBKeyData")
#define YB_NO_MORE_DATA                             (@"YBNoMoreData")
#define YB_NO_RESPONSE_DATA                         (@"YBNoResponseData")

#endif
