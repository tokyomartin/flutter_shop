import 'package:flutter/material.dart';
import 'package:flutter_shop/model/user_detail.dart';
import 'package:flutter_shop/pages/PopViewPage.dart';
import 'package:flutter_shop/provide/province.dart';
import 'package:flutter_shop/provide/user.dart';
import 'package:flutter_shop/provide/user_detail.dart';
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

void main(){

  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide  = CartProvide();
  var currentIndexProvide  = CurrentIndexProvide();
  var counter = Counter();
  var deliveryAddrProvide = DeliveryAddrProvide();
  var payMethodProvide = PayMethodProvide();
  var provinceProvide = ProvinceProvide();
  var userDetailProvide =  UserDetailProvide();

  var userProvide =  UserProvider();

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
        ChangeNotifierProvider<ChildCategory>(create: (context) => childCategory),
        ChangeNotifierProvider<CategoryGoodsListProvide>(create: (context) => categoryGoodsListProvide),
        ChangeNotifierProvider<DetailsInfoProvide>(create: (context) => detailsInfoProvide),
        ChangeNotifierProvider<CartProvide>(create: (context) => cartProvide),
        ChangeNotifierProvider<DeliveryAddrProvide>(create: (context) => deliveryAddrProvide),
        ChangeNotifierProvider<PayMethodProvide>(create: (context) => payMethodProvide),
        ChangeNotifierProvider<ProvinceProvide>(create: (context) => provinceProvide),
        ChangeNotifierProvider<UserDetailProvide>(create: (context) => userDetailProvide),
        ChangeNotifierProvider<UserProvider>(create: (context) => userProvide),
        ChangeNotifierProvider<CurrentIndexProvide>(create: (context) => CurrentIndexProvide()),
        ChangeNotifierProvider<Counter>(create: (context) => Counter()),
        // ChangeNotifierProvider.value(value: Counter()),
        // //ChangeNotifierProvider(builder: (_) => Counter()),
      ],
      child: MyApp(),
    ),
  );


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router=router;
    

    return Container(
      
      child: MaterialApp(
        title:'华人超市+',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Application.router.generator,
        theme: ThemeData(
          primaryColor:Colors.pink,
        ),

          //Normal Index
            home:IndexPage()
          //TODO for TEST
          // home: PopViewPage()

      ),
    );
  }
}