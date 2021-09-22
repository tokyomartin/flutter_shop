import 'package:flutter/material.dart';
import './pages/index_page.dart';

import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/details_info.dart';
import './provide/cart.dart';
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

  // var providers = Providers();
  //
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
        ChangeNotifierProvider<DetailsInfoProvide>(create: (context) => DetailsInfoProvide()),
        ChangeNotifierProvider<CartProvide>(create: (context) => CartProvide()),
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
        title:'百姓生活+',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Application.router.generator,
        theme: ThemeData(
          primaryColor:Colors.pink,
        ),
        home:IndexPage()

      ),
    );
  }
}