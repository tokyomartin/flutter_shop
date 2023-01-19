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





请求定位权限（Privacy - Photo Library Usage Description）- 需要获取个人位置进行天气预报是否允许此App获取你的定位？
请求定位权限（Privacy - Photo Library Usage Description）- 需要获取个人位置进行附近店铺的展示，是否允许此App获取你的定位？
请求定位权限（Privacy - Photo Library Usage Description）- 需要获取个人位置搜索附近店铺，是否允许此App获取你的定位？

个人账号申请完毕后果断上传自己的App到AppStore，但鉴于审核方面是小白一枚，一审核就碰到一个十分不该被拒的原因，原因条款为“Guideline 5.1.1 - Legal - Privacy - Data Collection and Storage解决方法”。

  因这个原因被拒的只需要将请求系统权限的原因写得更加明白一些，要将请求权限的目的表明，举个🌰：

1.请求相机权限（Privacy - Location Always Usage Description）- 需要获取个人照片进行编辑是否允许此App获取相册权限？
2.请求定位权限（Privacy - Photo Library Usage Description）- 需要获取个人位置进行天气预报是否允许此App获取你的定位？
更改为以上阐述后隔天就通过审核了。

总结：
  通用格式：需要(干什么)是否允许此App获取你的(对应权限)**.

作者：Jixes
链接：https://www.jianshu.com/p/dd400d640cb3
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。





## 知识架构图

### 在SharePref类中
测试的时候  可以设置DEBUG = true

class SharePref {

  static bool DEBUG = true;


### 开发时需要注意main.dart中
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



### 添加子模块功能
并把大部分功能模块迁移到子模块中
cd lib
下面两个命令有一个是对的
git submodule https://github.com/ecshop-flutter/my_common my_common
或者是
git submodule add  https://github.com/ecshop-flutter/my_common my_common
git status

cd lib/my_common
git remote -v
git branch
git add .
git commit -m "add base common classes, provider and models  to submodule"
git push

cd 根目录
git add .
git commit -m "submodule"
git push