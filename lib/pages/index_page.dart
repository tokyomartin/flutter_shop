import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provide/provide.dart';
import '../provide/currentIndex.dart';

import 'package:provider/provider.dart';


// 框架布局页面
// 可以设置操作，下面的动作按钮
// 首页  -- 分类 -- 购物车 -- 会员中心

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}


class _IndexPageState extends State<IndexPage>  {

  @override
  void initState() {
    super.initState();

    // 苹果app上线时
    // 首页可以不用登录
    // checkLoginStatus();

  }

  checkLoginStatus() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("access_token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
    }

  }


  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.home),
        title:Text('首页')
    ),
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.search),
        title:Text('分类')
    ),
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.shopping_cart),
        title:Text('购物车')
    ),
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.profile_circled),
        title:Text('会员中心')
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];





  // @override
  // Widget build(BuildContext context) {
  //
  //   ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
  //   // var scope1 = ProviderScope("1");
  //
  //   return
  //     Scaffold(
  //     appBar: AppBar(
  //       title: Text('Flutter Demo Home Page'),
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Text('You have pushed the button this many times:'),
  //           //scope: "1",
  //           Consumer<CurrentIndexProvide>(
  //           builder: (context,CurrentIndexProvide model,child)=> Text(
  //               '${model.value}',
  //               // style: Theme.of(context).textTheme.display1,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //      // onPressed: () => Provide.value<Counter>(context).increment(),
  //       tooltip: 'Increment',
  //       child: Icon(Icons.add),
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    // context
   // Container()
    return

      Consumer<CurrentIndexProvide>(
        //           builder:

        builder: (context,CurrentIndexProvide model, child){

          int currentIndex = Provider.of<CurrentIndexProvide>(context, listen: false).currentIndex;

          //int currentIndex= Provide.value<CurrentIndexProvide>(context).currentIndex;

          print(currentIndex);
          debugPrint("test");


          return Scaffold(
            backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
            bottomNavigationBar: BottomNavigationBar(
              type:BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              items:bottomTabs,
              onTap: (index){
                Provider.of<CurrentIndexProvide>(context, listen: false).changeIndex(index);
              },
            ),
            body: IndexedStack(
                index: currentIndex,
                children: tabBodies
            ),
          );
        }
    );
  }


}









//
//
// class IndexPage extends StatelessWidget {
//   final List<BottomNavigationBarItem> bottomTabs = [
//     BottomNavigationBarItem(
//       icon:Icon(CupertinoIcons.home),
//       title:Text('首页')
//     ),
//     BottomNavigationBarItem(
//       icon:Icon(CupertinoIcons.search),
//       title:Text('分类')
//     ),
//     BottomNavigationBarItem(
//       icon:Icon(CupertinoIcons.shopping_cart),
//       title:Text('购物车')
//     ),
//      BottomNavigationBarItem(
//       icon:Icon(CupertinoIcons.profile_circled),
//       title:Text('会员中心')
//     ),
//   ];
//
//    final List<Widget> tabBodies = [
//       HomePage(),
//       CategoryPage(),
//       CartPage(),
//       MemberPage()
//    ];
//
//   @override
//   Widget build(BuildContext context) {
//
//     ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
//
//    // context.
//
//     return Provide<CurrentIndexProvide>(
//
//       builder: (context,child,val){
//         int currentIndex= Provide.value<CurrentIndexProvide>(context).currentIndex;
//         print(currentIndex);
//         debugPrint("test");
//
//
//         return Scaffold(
//             backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//             bottomNavigationBar: BottomNavigationBar(
//               type:BottomNavigationBarType.fixed,
//               currentIndex: currentIndex,
//               items:bottomTabs,
//               onTap: (index){
//                 Provide.value<CurrentIndexProvide>(context).changeIndex(index);
//               },
//             ),
//              body: IndexedStack(
//                     index: currentIndex,
//                     children: tabBodies
//                   ),
//         );
//       }
//     );
//
//   }
// }


// class IndexPage extends StatefulWidget {
//
//   _IndexPageState createState() => _IndexPageState();
// }
//
// class _IndexPageState extends State<IndexPage>{
//
//    PageController _pageController;
//
//
//   final List<BottomNavigationBarItem> bottomTabs = [
//     BottomNavigationBarItem(
//       icon:Icon(CupertinoIcons.home),
//       title:Text('首页')
//     ),
//     BottomNavigationBarItem(
//       icon:Icon(CupertinoIcons.search),
//       title:Text('分类')
//     ),
//     BottomNavigationBarItem(
//       icon:Icon(CupertinoIcons.shopping_cart),
//       title:Text('购物车')
//     ),
//      BottomNavigationBarItem(
//       icon:Icon(CupertinoIcons.profile_circled),
//       title:Text('会员中心')
//     ),
//   ];
//   final List<Widget> tabBodies = [
//     HomePage(),
//     CategoryPage(),
//     CartPage(),
//     MemberPage()
//   ];
//   int currentIndex= 0;
//   var currentPage ;
//   @override
//   void initState() {
//    currentPage=tabBodies[currentIndex];
//    _pageController=new PageController()
//       ..addListener(() {
//         if (currentPage != _pageController.page.round()) {
//           setState(() {
//             currentPage = _pageController.page.round();
//           });
//         }
//   });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//       bottomNavigationBar: BottomNavigationBar(
//         type:BottomNavigationBarType.fixed,
//         currentIndex: currentIndex,
//         items:bottomTabs,
//         onTap: (index){
//           setState(() {
//           //  currentIndex=index;
//           //   currentPage =tabBodies[currentIndex];
//           });
//
//         },
//       ),
//       body:Provide<CurrentIndexProvide>(
//         builder: (context,child,val){
//
//           return IndexedStack(
//               index: 0,
//               children: tabBodies
//             );
//         },
//       )
//     );
//   }
// }

