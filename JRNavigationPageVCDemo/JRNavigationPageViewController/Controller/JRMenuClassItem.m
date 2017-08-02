//
//  JRMenuClassItem.m
//  JRNavigationPageVCDemo
//
//  Created by JerryFans on 2017/8/1.
//  Copyright © 2017年 JerryFans. All rights reserved.
//

#import "JRMenuClassItem.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "JRNavigationPageVCDemo-Swift.h"

@interface JRMenuClassItem()

@property(nonatomic,strong) id  instance;

@end

@implementation JRMenuClassItem

- (id)getInstance{
    return self.instance;
}

- (id)instance{
    
    if (!_instance) {
        if (!self.className) {
            NSAssert(NO, @"没有找到类名");
        }
        const char *className = [self.className cStringUsingEncoding:NSASCIIStringEncoding];
        // 从一个字串返回一个类
        Class newClass = objc_getClass(className);
        if (!newClass)
        {
            // 创建一个类
            Class superClass = [NSObject class];
            newClass = objc_allocateClassPair(superClass, className, 0);
            // 注册你创建的这个类
            objc_registerClassPair(newClass);
        }
        
        if ([newClass isSubclassOfClass:[UIViewController class]]) {
            _instance = [[newClass alloc]init];
            
            if (self.propertyDict) {
                
                u_int count;
                objc_property_t * properties  = class_copyPropertyList(newClass, &count);
                for (int i=0; i<count; i++) {
                    
                    objc_property_t property = properties[i];
                    const char *name = property_getName(property);
                    id value = [self.propertyDict objectForKey:[NSString stringWithUTF8String:name]];
                    if (value) {
                        [_instance setValue:value forKey:[NSString stringWithUTF8String:name]];
                    }
                }
                free(properties);
                
            }
            
        }
        
    }
    
    return _instance;
    
}

@end
