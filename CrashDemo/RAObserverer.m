//
//  RAObserverer.m
//  HookNetwork2
//
//  Created by changhongliang on 2017/12/19.
//  Copyright © 2017年 richinfo. All rights reserved.
//

#import "RAObserverer.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <UIKit/UIKit.h>

@implementation RAObserverer
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [NSURLConnection class];
        SEL selector = @selector(initWithRequest:delegate:);
        SEL swizzledSelector = @selector(test_initWithRequest:delegate:);
        Method originalinitWithRequest = class_getInstanceMethod(class, selector);
        NSURLConnection* (^swizzleBlock)(NSURLConnection *,SEL,NSURLRequest*,id )= ^(NSURLConnection *slf,SEL swizzledSelector,NSURLRequest *request,id delegate) {
            return ((NSURLConnection*(*)(NSURLConnection*,SEL,NSURLRequest*,id))objc_msgSend)(slf,swizzledSelector,request,delegate);
            
        };
        
        IMP implementation = imp_implementationWithBlock(swizzleBlock);
        class_addMethod(class, swizzledSelector, implementation, method_getTypeEncoding(originalinitWithRequest));
        Method newConnectionWithRequestClassMethod = class_getInstanceMethod(class, swizzledSelector);
        method_exchangeImplementations(originalinitWithRequest, newConnectionWithRequestClassMethod);
    });
}




@end
