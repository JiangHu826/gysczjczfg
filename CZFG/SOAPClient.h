//
//  SOAPClient.h
//  CZFG
//
//  Created by lihong on 14/11/10.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import <Foundation/Foundation.h>

@class SOAPResponse;

typedef void (^SOAPClientCompletedBlock)(NSData *data);
typedef void (^SOAPClientErrorBlock)(NSError *error);

/// 基于SOAP1.1的SOAP客户端
@interface SOAPClient : NSObject

- (SOAPClient *)initWithMethod:(NSString *)method
                        xmlns:(NSString *)xmlns
                        params:(NSDictionary *)params
                    requestUrl:(NSString *)url
                completedBlock:(SOAPClientCompletedBlock)cBlock
                    errorBlock:(SOAPClientErrorBlock)eBlock;

- (void)startAsyncRequest;

@end
