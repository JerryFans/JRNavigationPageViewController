//
//  JRMenuClassItem.h
//  JRNavigationPageVCDemo
//
//  Created by JerryFans on 2017/8/1.
//  Copyright © 2017年 JerryFans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRMenuClassItem : NSObject

/**< the UIViewController Class Name */
@property(nonatomic,strong) NSString  *className;

@property(nonatomic,strong) NSDictionary  *propertyDict;

@property(nonatomic,strong,getter=getInstance) id  getInstance;

@end
