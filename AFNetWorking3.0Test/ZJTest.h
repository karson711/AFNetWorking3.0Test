//
//  ZJTest.h
//  AFNetWorking3.0Test
//
//  Created by kunge on 16/3/21.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJTest : NSObject
/**
 *  {"message":"OK","status":"2000000","data":"规则"}
 */

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *data;

@end
