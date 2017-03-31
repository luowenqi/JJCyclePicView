//
//  ViewController.m
//  JJCyclePicView
//
//  Created by 罗文琦 on 2017/3/31.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "ViewController.h"
#import "JJCyclePicView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self initializationUI];
}


- (void)initializationUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //加载网络上的图片,传入URL
//    NSArray *imagsArray = @[
//                            @"http://f.hiphotos.baidu.com/news/w%3D638/sign=6cd13c3dbffd5266a72b3f1793199799/aec379310a55b31906deb2a34aa98226cefc17c4.jpg",
//                            @"http://a.hiphotos.baidu.com/news/w%3D638/sign=0863bd2a38adcbef01347d0594ad2e0e/fcfaaf51f3deb48f54952530f91f3a292cf57864.jpg",
//                            @"http://d.hiphotos.baidu.com/news/w%3D638/sign=efd2dcb69deef01f4d141bc6d8ff99e0/a71ea8d3fd1f4134cc5760ac2c1f95cad0c85efb.jpg",
//                            @"http://g.hiphotos.baidu.com/news/w%3D638/sign=2c23f2c864224f4a5799701031f59044/023b5bb5c9ea15cea80b64e7bf003af33b87b273.jpg",
//                            ];
    
    //加载本地的图片,传入图片的名字
    NSArray *imagsArray = @[@"1",@"2",@"3",@"4"];
    
    
    //后面的直接复制
    JJCyclePicView *scrollView = [[JJCyclePicView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width ,300)];
    [scrollView initializationUIWithDataArray:imagsArray];
    [scrollView setAnimationDuration:1.5];
    [self.view addSubview:scrollView];
}

@end
