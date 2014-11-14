//
//  SOAPClient.m
//  CZFG
//
//  Created by lihong on 14/11/10.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import "SOAPClient.h"

@interface SOAPClient() <NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *xmlns;
@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSDictionary *parmas;
@property (nonatomic, strong) NSString *soapRequestBody;
@property (nonatomic, copy) SOAPClientErrorBlock errorBlock;
@property (nonatomic, copy) SOAPClientCompletedBlock completedBlock;
@end

@implementation SOAPClient

- (SOAPClient *)initWithMethod:(NSString *)method
                         xmlns:(NSString *)xmlns
                        params:(NSDictionary *)params
                    requestUrl:(NSString *)url
                completedBlock:(SOAPClientCompletedBlock)cBlock
                    errorBlock:(SOAPClientErrorBlock)eBlock
{
    self = [super init];
    if(self)
    {
        self.url = url;
        self.xmlns = xmlns;
        self.method = method;
        self.parmas = params;
        self.errorBlock = eBlock;
        self.completedBlock = cBlock;
    }
    
    return self;
}

- (NSString *)soapRequestBody
{
    if(_soapRequestBody) return _soapRequestBody;
    
    NSMutableString *soapRequestBody = [NSMutableString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body>"];
    [soapRequestBody appendFormat:@"<%@ xmlns=\"%@/\">",self.method,self.xmlns];
    for (NSString *key in self.parmas)
    {
        [soapRequestBody appendFormat:@"<%@>%@</%@>",key,self.parmas[key],key];
    }
    [soapRequestBody appendFormat:@"</%@></soap:Body></soap:Envelope>",self.method];
    
    _soapRequestBody = soapRequestBody;
    return _soapRequestBody;
}

- (void)startAsyncRequest
{
    NSString *soapAction = [NSString stringWithFormat:@"%@/%@",self.xmlns,self.method];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [request addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:soapAction forHTTPHeaderField:@"SOAPAction"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [self.soapRequestBody dataUsingEncoding:NSUTF8StringEncoding]];
   
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(data == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.errorBlock(connectionError);
            });
            return;
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.completedBlock(data);
        });
    }];
}

@end
