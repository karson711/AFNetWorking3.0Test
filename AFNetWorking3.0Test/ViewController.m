//
//  ViewController.m
//  AFNetWorking3.0Test
//
//  Created by kunge on 16/3/21.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import "ViewController.h"
#import "ZJNetWorkManger.h"
#import "ZJTest.h"

@interface ViewController ()

@property(nonatomic,strong)ZJTest *test;

@end

@implementation ViewController

-(ZJTest *)test{
    if (!_test) {
        _test = [[ZJTest alloc] init];
    }
    return _test;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    [self testRequest];
    
}

/**
 *  ZJTest 为获取到数据对应的model
 */
- (void)testRequest{
    
    NSString *url = @"http://119.29.0.81:7098/plant/app/shop/getBeanInfo.json";
    
    [[ZJNetWorkManger manager] zj_POST:url parameters:nil responseClass:[ZJTest class] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZJLog(@"responseObject=%@", responseObject);
        self.test = (ZJTest *)responseObject;
        ZJLog(@"data====%@",self.test.data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJLog(@"task=%@, error=%@", task, error);
    }];
}


@end
