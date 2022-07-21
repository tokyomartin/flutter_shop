# Flutter的移动电商实战

项目和教程都在更新中............

完全模仿了百姓生活+小程序的项目，数据来自Fiddle提取，有完整的接口API文档。页面包括首页、商品列表页、商品详细页、购物车页面和会员中心。

目前项目还在开发当中，配有完整的视频和文字教程，是你Flutter进阶必备项目。

## 教程文章地址

教程文章地址(60节，超5万字教程，持续更新中)：[https://jspang.com/post/FlutterShop.html](https://jspang.com/post/FlutterShop.html)

## 用到的组件

- dio:用于向后端接口作HTTP请求数据
- flutter_swiper: 轮播插件，制作了商城首页的轮播效果
- flutter_screenutil:用于不同屏幕的适配，一次设计，适配所有屏幕
- url_launcher:用于打开网页和实现原生电话的拨打
- flutter_easyrefresh：下拉刷新或者上拉加载插件，方便好用，可定制。
- provide：谷歌最新推出的Flutter状态管理插件，亲儿子，用的爽。
- fluttertoast：Toast轻提示插件，APP必不可少，IOS和Android通用。


## 图片展示

![商城图片](http://blogimages.jspang.com/Flutter_shop_01.jpg)


## 所有项目知识点梳理

![知识点梳理](http://blogimages.jspang.com/Flutter%E7%A7%BB%E5%8A%A8%E7%94%B5%E5%95%86%E5%AE%9E%E6%88%98-%E7%9F%A5%E8%AF%86%E7%82%B9%E6%A2%B3%E7%90%86.png)


## 更新日志：

- 商品分类页面增加了打开详细页的功能。[2019/4/23]

- 更新首页的分类导航，跳转到分类页面，并且可以跟随变化。[2019/4/22]

- 商品详细页面主要UI布局完成，还有app的路由系统制作完成。[2019/4/4]

- 第一次上传项目到GitHub上，我已经写了35课教程，把首页和商品分类页面制作完成。[2019/3/28]







## 知识架构图


测试的时候  可以设置DEBUG = true

class SharePref {

  static bool DEBUG = true;


开发时需要注意main。dart中
      //ios
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }
      // android
      // _permissionGranted = await location.hasPermission();
      // if (_permissionGranted == PermissionStatus.DENIED) {
      //   _permissionGranted = await location.requestPermission();
      //   if (_permissionGranted != PermissionStatus.GRANTED) {
      //     return null;
      //   }
      // }





