//
//  YBHttpRequestManager.m
//  YBNet
//
//  Created by asance on 2017/4/27.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "YBHttpRequestManager.h"
#import "AESEncrypt.h"
#import "UIImage+Alpha.h"

const NSString *HttpUploadParamsKey = @"HttpUploadParamsKey";
const NSString *HttpUploadImagesKey = @"HttpUploadImagesKey";

const NSString *HttpUploadFileNameDesKey = @"HttpUploadFileNameDesKey";
const NSString *HttpUploadFileDataDesKey = @"HttpUploadFileDataDesKey";
const NSString *HttpUploadMimeTypeDesKey = @"HttpUploadMimeTypeDesKey";

@implementation YBHttpRequestManager

+ (instancetype)shareInstance{
    static YBHttpRequestManager *distance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        distance = [[YBHttpRequestManager alloc] init];
        distance.logSwitch = YES;
    });
    return distance;
}

- (void)Get:(NSString *)url params:(NSDictionary *)param success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure{
    if(self.logSwitch){
        NSLog(@"GET: %@",url);
        NSLog(@"PARAMS: %@", param);
    }
    
    NSArray *array = [url componentsSeparatedByString:@"?"];
    NSString *url_new = array[0];
    
    NSMutableURLRequest *request = [self GetRequest];
    [request setURL:[NSURL URLWithString:url_new]];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30.0f;
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            if(self.logSwitch){
                NSLog(@"%@-%@",@(error.code),error.localizedDescription);
            }
            NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if(self.logSwitch){
                NSLog(@"error: %@",str);
            }
            failure(error);
        } else {
            if([responseObject isKindOfClass:[NSData class]]){
#if HTTP_REQUEST_ENCRYPT_OPEN
                NSDictionary *object = [AESEncrypt dictionaryAES128CBCDecryptForUTF8Data:responseObject
                                                                                     key:HTTP_REQUEST_ENCRYPT_KEY
                                                                                      iv:HTTP_REQUEST_ENCRYPT_IV];
                
                success(object);
#else
                success(responseObject);
#endif
            }
            else{
                success(responseObject);
            }
        }
    }];
    [dataTask resume];
}
- (void)PartyGet:(NSString *)url params:(NSDictionary *)param success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure{
    if(self.logSwitch){
        NSLog(@"GET: %@",url);
        NSLog(@"PARAMS: %@", param);
    }
    NSString *url_new = url;
    
    NSMutableURLRequest *request = [self GetRequest];
    [request setURL:[NSURL URLWithString:url_new]];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30.0f;
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            if(self.logSwitch){
                NSLog(@"%@-%@",@(error.code),error.localizedDescription);
            }
            NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if(self.logSwitch){
                NSLog(@"error: %@",str);
            }
            failure(error);
        } else {
            if([responseObject isKindOfClass:[NSData class]]){
                //party should not encrypt
                success(responseObject);
            }
            else{
                success(responseObject);
            }
        }
    }];
    [dataTask resume];
}
- (void)Post:(NSString *)url params:(NSDictionary *)param success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure{
    if(self.logSwitch){
        NSLog(@"POST: %@", url);
        NSLog(@"PARAMS: %@", param);
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSMutableURLRequest *request = [self PostRequest];
    [request setURL:[NSURL URLWithString:url]];
    if(param) [request setHTTPBody:[self httpBody:param]];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30.0f;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    // 设置证书模式
#if OPEN_SSL_CER_CRT_CHECK
    //NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ybserver" ofType:@"cer"];
    //NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    //manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[[NSSet alloc] initWithObjects:cerData, nil]];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
#endif
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (error) {
            if(self.logSwitch){
                NSLog(@"%@-%@",@(error.code),error.localizedDescription);
            }
            NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if(self.logSwitch){
                NSLog(@"error: %@",str);
            }
            failure(error);
        } else {
            if([responseObject isKindOfClass:[NSData class]]){
#if HTTP_REQUEST_ENCRYPT_OPEN
                NSDictionary *object = [AESEncrypt dictionaryAES128CBCDecryptForUTF8Data:responseObject
                                                                                     key:HTTP_REQUEST_ENCRYPT_KEY
                                                                                      iv:HTTP_REQUEST_ENCRYPT_IV];
                success(object);
#else
                success(responseObject);
#endif
            }
            else{
                success(responseObject);
            }
        }
    }];
    [dataTask resume];
}

- (void)Upload:(NSString *)url params:(NSDictionary *)param images:(NSArray *)images progress:(HttpUploadProgress)progress success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if(self.logSwitch){
        NSLog(@"POST: %@", url);
        NSLog(@"PARAMS: %@", param);
        NSLog(@"%@-%@-%@",self.UUID,@"ios",self.authorization);
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 120.0f;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"terminal"];
    if(self.UUID.length){
        [manager.requestSerializer setValue:self.UUID forHTTPHeaderField:@"clientId"];
    }
    if(self.authorization.length){
        [manager.requestSerializer setValue:self.authorization forHTTPHeaderField:@"authorization"];
    }
    
    NSURLSessionDataTask *dataTask = [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for(NSInteger i=0;i<images.count;i++){
            
            id dict = [images objectAtIndex:i];
            if(NO==[dict isKindOfClass:[NSDictionary class]]) continue;
            
            NSString *name = [dict objectForKey:HttpUploadFileNameDesKey];
            NSString *mimeType = [dict objectForKey:HttpUploadMimeTypeDesKey];
            //mimeType = @"multipart/form-data";
            NSString *fileName = [NSString stringWithFormat:@"%@.jpeg", name];
            id image = [dict objectForKey:HttpUploadFileDataDesKey];
            
            if(0==[name length]) continue;
            if(nil==image) continue;
            
            NSData *imageData = nil;
            if([image isKindOfClass:[NSData class]]){
                imageData = image;
            }
            else if ([image isKindOfClass:[UIImage class]]){
                imageData = [image compressToLength:(60*1024)];;
            }
            else{
                continue;
            }
            //上传的时候name要跟接口参数保持一致
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileName
                                    mimeType:mimeType];//@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        CGFloat progres = ((CGFloat)uploadProgress.completedUnitCount/(CGFloat)uploadProgress.totalUnitCount);
        if(self.logSwitch){
            NSLog(@"upload head image progress:%@, %.2f",uploadProgress,progres);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if([responseObject isKindOfClass:[NSData class]]){
#if HTTP_REQUEST_ENCRYPT_OPEN
            NSDictionary *object = [AESEncrypt dictionaryAES128CBCDecryptForUTF8Data:responseObject
                                                                                 key:HTTP_REQUEST_ENCRYPT_KEY
                                                                                  iv:HTTP_REQUEST_ENCRYPT_IV];
            success(object);
#else
            success(responseObject);
#endif
        }
        else{
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if(self.logSwitch){
                NSLog(@"error: %@",str);
            }
            failure(error);
        }
    }];
    [dataTask resume];
    
}

#pragma mark - Getter Setter
- (NSMutableURLRequest *)GetRequest{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"ios" forHTTPHeaderField:@"terminal"];
    if(self.UUID.length){
        [request setValue:self.UUID forHTTPHeaderField:@"clientId"];
    }
    if(self.authorization.length){
        [request setValue:self.authorization forHTTPHeaderField:@"authorization"];
    }
    if(self.logSwitch){
        NSLog(@"%@-%@-%@",self.UUID,@"ios",self.authorization);
    }
    return request;
}

- (NSMutableURLRequest *)PostRequest{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"ios" forHTTPHeaderField:@"terminal"];
    if(self.UUID.length){
        [request setValue:self.UUID forHTTPHeaderField:@"clientId"];
    }
    if(self.authorization.length){
        [request setValue:self.authorization forHTTPHeaderField:@"authorization"];
    }
    if(self.logSwitch){
        NSLog(@"%@-%@-%@",self.UUID,@"ios",self.authorization);
    }
    return request;
}

- (NSData *)httpBody:(NSDictionary *)params{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    
#if HTTP_REQUEST_ENCRYPT_OPEN
    //对字符串进行加密
    NSData *encryptData = [AESEncrypt dataAES128CBCEncryptForUTF8Data:jsonData key:HTTP_REQUEST_ENCRYPT_KEY iv:HTTP_REQUEST_ENCRYPT_IV];
    return encryptData;
#endif
    
    return jsonData;
}

@end
