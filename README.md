# JJCyclePicView
图片轮播器,一句搞定,网络,本地,纯原生,内存安全

> 还有文字轮播 https://github.com/luowenqi/JJScrollText

> 可以完成网络图片和本地图片轮播
> 完美解决了网络图片缓存问题,让使用时候消耗更少的流量,加载网络图片速度更快

## 加载本地图片
```
//加载本地的图片,传入图片的名字
NSArray *imagsArray = @[@"1",@"2",@"3",@"4"];
```

## 加载网络图片
```
//加载网络上的图片,传入URL对应的字符串
NSArray *imagsArray = @[
@"http://f.hiphotos.baidu.com/news/w%3D638/sign=6cd13c3dbffd5266a72b3f1793199799/aec379310a55b31906deb2a34aa98226cefc17c4.jpg",
@"http://a.hiphotos.baidu.com/news/w%3D638/sign=0863bd2a38adcbef01347d0594ad2e0e/fcfaaf51f3deb48f54952530f91f3a292cf57864.jpg",
@"http://d.hiphotos.baidu.com/news/w%3D638/sign=efd2dcb69deef01f4d141bc6d8ff99e0/a71ea8d3fd1f4134cc5760ac2c1f95cad0c85efb.jpg",
@"http://g.hiphotos.baidu.com/news/w%3D638/sign=2c23f2c864224f4a5799701031f59044/023b5bb5c9ea15cea80b64e7bf003af33b87b273.jpg",
];
```
## 效果图
![image](https://github.com/luowenqi/JJCyclePicView/blob/master/JJCyclePicView/Screenshot/Untitled2.gif)
