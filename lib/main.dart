import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/user_detail.dart';
import 'package:flutter_shop/pages/pop_view_page.dart';
import 'package:flutter_shop/provide/province.dart';
import 'package:flutter_shop/provide/location.dart'; // 定位服务
import 'package:flutter_shop/provide/user.dart';
import 'package:flutter_shop/provide/user_detail.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';
import './pages/index_page.dart';

import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/details_info.dart';
import './provide/cart.dart';
import './provide/delivery_addr.dart';
import './provide/pay_method.dart';
import './provide/currentIndex.dart';

import 'package:fluro/fluro.dart';
import './routers/routes.dart';
import './routers/application.dart';

import 'package:provider/provider.dart';

// @Deperated
// import 'package:provide/provide.dart';


import './provide/counter.dart';

void main() {
  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();
  var currentIndexProvide = CurrentIndexProvide();
  var counter = Counter();
  var deliveryAddrProvide = DeliveryAddrProvide();
  var payMethodProvide = PayMethodProvide();
  var provinceProvide = ProvinceProvide();
  var userDetailProvide = UserDetailProvide();
  var locationProvide = LocationProvide();

  var userProvide = UserProvider();


  // var providers = Providers();
  // var scope1 = ProviderScope("1");
  // var scope2 = ProviderScope("2");
  //
  //
  // providers
  //   ..provide(Provider<ChildCategory>.value(childCategory))
  //   ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
  //   ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
  //   ..provide(Provider<CartProvide>.value(cartProvide))
  //   ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide), scope: scope1)
  //   ..provide(Provider<Counter>.value(counter));
  //
  // runApp(ProviderNode(child:MyApp(),providers:providers));


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ChildCategory>(
            create: (context) => childCategory),
        ChangeNotifierProvider<CategoryGoodsListProvide>(
            create: (context) => categoryGoodsListProvide),
        ChangeNotifierProvider<DetailsInfoProvide>(
            create: (context) => detailsInfoProvide),
        ChangeNotifierProvider<CartProvide>(create: (context) => cartProvide),
        ChangeNotifierProvider<DeliveryAddrProvide>(
            create: (context) => deliveryAddrProvide),
        ChangeNotifierProvider<PayMethodProvide>(
            create: (context) => payMethodProvide),
        ChangeNotifierProvider<ProvinceProvide>(
            create: (context) => provinceProvide),
        ChangeNotifierProvider<UserDetailProvide>(
            create: (context) => userDetailProvide),
        ChangeNotifierProvider<LocationProvide>(
            create: (context) => locationProvide),
        ChangeNotifierProvider<UserProvider>(create: (context) => userProvide),
        ChangeNotifierProvider<CurrentIndexProvide>(
            create: (context) => CurrentIndexProvide()),
        ChangeNotifierProvider<Counter>(create: (context) => Counter()),
        // ChangeNotifierProvider.value(value: Counter()),
        // //ChangeNotifierProvider(builder: (_) => Counter()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  // 地理定位信息
  LocationData? currentLocation;
  String address = "";


  @override
  Widget build(BuildContext context) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;


    getGpsLocation().then((value) {
      LocationData location = value;
      if (location != null) {
        _getAddress(location.latitude, location.longitude)
            .then((value) {
          currentLocation = location;
          address = value;
          debugPrint("GPS信息 latitude:" + location.latitude.toString());
          debugPrint("GPS信息 longitude:" + location.longitude.toString());
          debugPrint("地址信息:" + value);
          // setState(() {
          //   currentLocation = location;
          //   address = value;
          // });

        });
      }
    });
  //ScreenUtil.instance = ScreenUtil(width: 770, height: 1334, allowFontScaling: true);

    return ScreenUtilInit(
      designSize: const Size(770, 1334),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return  Container(
        child: MaterialApp(
          title: '华人超市+',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Application.router.generator,
          theme: ThemeData(
            primaryColor: Colors.pink,
          ),

          //Normal Index
          home: IndexPage(),
          //home: child,
          //TODO for TEST
          // home: PopViewPage()

        ),

        );
      },
      //child: IndexPage(),
    );
  }


Future<LocationData> getGpsLocation() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      throw '没有GPS服务｜GPS　Locationない';
    }
  }

  //ios
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      throw '没有GPS服务｜GPS　Locationない';
      //return ;
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

  LocationData _locationData;
  _locationData = await location.getLocation();
  return _locationData;
}


Future<String> _getAddress(double? lat, double? lang) async {
  if (lat == null || lang == null) return "";
  GeoCode geoCode = GeoCode();
  Address address =
  await geoCode.reverseGeocoding(latitude: lat, longitude: lang);

  return "${address.streetAddress}, ${address.city}, ${address
      .countryName}, ${address.postal}";
}


}