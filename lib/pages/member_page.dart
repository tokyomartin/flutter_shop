import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_shop/pages/confirmOrder.dart';
// import 'package:flutter_shop/pages/cart_confirm_page.dart';
import 'package:flutter_shop/pages/delivery_addr_page.dart';
import 'package:flutter_shop/pages/map_sample.dart';
import 'package:flutter_shop/screens/search_places_screen.dart';
import 'package:flutter_shop/util/share_pref.dart';
import 'package:flutter_shop/pages/lbs_shop_list_page.dart';

import '../login.dart';
import 'category_list_page.dart';
import '../pages/orderList.dart';


class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('会员中心'),
     ),
     body:ListView(
       children: <Widget>[
          _topHeader(),
          _orderTitle(),
          _orderType(context),
          _actionList(context)
        
       ],
     ) ,
   );
  }

  //头像区域

  Widget _topHeader(){

    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30), 
            child: ClipOval(

                // child:Image.network('http://blogimages.jspang.com/blogtouxiang1.jpg')
              child:
              // NetworkImage('http://29e5534ea20a8.cdn.sohucs.com/c_cut,x_178,y_20,w_1021,h_680,c_zoom,h_103/os/news/4b39a1b8656ef59d99a3a5d827fe5fd1.jpg')
               Image.network('http://29e5534ea20a8.cdn.sohucs.com/c_cut,x_178,y_20,w_1021,h_680,c_zoom,h_103/os/news/4b39a1b8656ef59d99a3a5d827fe5fd1.jpg',
                   errorBuilder: (c, o, s) {
                     return const Icon(
                       Icons.error,
                       color: Colors.red,
                     );
                   })
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              '码农',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color:Colors.white,

              ),
            ),
          )
        ],
      ),
    );

  }

  //我的订单顶部
  Widget _orderTitle(){

    return Container(
      margin: EdgeInsets.only(top:10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom:BorderSide(width: 1,color:Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title:Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );

  }

  Widget orderTypeToGo(BuildContext context, int orderType, String orderTypeName,  IconData iconDataMark) {
    return InkWell(
      onTap: () {
        debugPrint("--订单确认页");
        // Provider.of<CurrentIndexProvide>(context, listen: false).changeIndex(2);
        // Navigator.pop(context);
        // 打开的是购物车确认页
        // Navigator.push(context, MaterialPageRoute(builder: (context){ return CartConfirmPage();}));
        // 打开的是地址管理页
        //return LocationPage(category_id: 25);
        // orderType =1 订单类型
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OrderPage(orderType);
        }));
      },
      child:
      Container(
        width: ScreenUtil().setWidth(187),
        child: Column(
          children: <Widget>[
            Icon(
              iconDataMark,
              //Icons.party_mode,
              size: 30,
            ),
            Text(orderTypeName),
          ],
        ),
      ),
    );
  }


  Widget _orderType(BuildContext context){

    return Container(
      margin: EdgeInsets.only(top:5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top:20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          orderTypeToGo(context, 1, '決済待ち', Icons.party_mode),
          orderTypeToGo(context, 2, '決済完了配送', Icons.query_builder),
         // orderTypeToGo(context, 3, '配送準備'),
          orderTypeToGo(context, 4, '届く確認待ち', Icons.directions_car),
          orderTypeToGo(context, 5, '完了', Icons.content_paste),
          //-----------------
          // Container(
          //   width: ScreenUtil().setWidth(187),
          //   child: Column(
          //     children: <Widget>[
          //       Icon(
          //         Icons.query_builder,
          //         size: 30,
          //       ),
          //       Text('待发货'),
          //     ],
          //   ),
          // ),
          //  //-----------------
          // Container(
          //   width: ScreenUtil().setWidth(187),
          //   child: Column(
          //     children: <Widget>[
          //       Icon(
          //         Icons.directions_car,
          //          size: 30,
          //       ),
          //       Text('待收货'),
          //     ],
          //   ),
          // ),
          // Container(
          //   width: ScreenUtil().setWidth(187),
          //   child: Column(
          //     children: <Widget>[
          //       Icon(
          //         Icons.content_paste,
          //          size: 30,
          //       ),
          //       Text('待评价'),
          //     ],
          //   ),
          // ),


        ],
      ),
    );

  }

  Widget _myListTile(BuildContext context, String title){

    return InkWell(
      onTap: (){

          debugPrint("--打开购物车页面");
        // Provider.of<CurrentIndexProvide>(context, listen: false).changeIndex(2);
        // Navigator.pop(context);
          // 打开的是购物车确认页
          // Navigator.push(context, MaterialPageRoute(builder: (context){ return CartConfirmPage();}));
          // 打开的是地址管理页
          Navigator.push(context, MaterialPageRoute(builder: (context){ return DeliveryAddrPage();}));

      },
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom:BorderSide(width: 1,color:Colors.black12)
              )
          ),
          child: ListTile(
            leading: Icon(Icons.blur_circular),
            title: Text(title),
            trailing: Icon(Icons.arrow_right),
          ),
        ),

    );
    //Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();}))
  }


  Widget _myListConfirm(BuildContext context, String title){

    return InkWell(
      onTap: (){

        debugPrint("--订单确认页");
        // Provider.of<CurrentIndexProvide>(context, listen: false).changeIndex(2);
        // Navigator.pop(context);
        // 打开的是购物车确认页
        // Navigator.push(context, MaterialPageRoute(builder: (context){ return CartConfirmPage();}));
        // 打开的是地址管理页
        //Navigator.push(context, MaterialPageRoute(builder: (context){ return CartToConfirmPage();})); //TODO 已经不使用该页面

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom:BorderSide(width: 1,color:Colors.black12)
            )
        ),
        child: ListTile(
          leading: Icon(Icons.blur_circular),
          title: Text(title),
          trailing: Icon(Icons.arrow_right),
        ),
      ),

    );
    //Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();}))
  }

  //deprecated
  Widget _myListConfirmPage(BuildContext context, String title){

    return InkWell(
      onTap: (){

        debugPrint("--订单确认页2");
        // Provider.of<CurrentIndexProvide>(context, listen: false).changeIndex(2);
        // Navigator.pop(context);
        // 打开的是购物车确认页
        // Navigator.push(context, MaterialPageRoute(builder: (context){ return CartConfirmPage();}));
        // 打开的是地址管理页
        Navigator.push(context, MaterialPageRoute(builder: (context){ return ConfirmOrderPage();}));

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom:BorderSide(width: 1,color:Colors.black12)
            )
        ),
        child: ListTile(
          leading: Icon(Icons.blur_circular),
          title: Text(title),
          trailing: Icon(Icons.arrow_right),
        ),
      ),

    );
    //Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();}))
  }


  // CategoryListPage
  Widget _myListCategory(BuildContext context, String title){

    return InkWell(
      onTap: (){

        debugPrint("--订单确认页");
        // Provider.of<CurrentIndexProvide>(context, listen: false).changeIndex(2);
        // Navigator.pop(context);
        // 打开的是购物车确认页
        // Navigator.push(context, MaterialPageRoute(builder: (context){ return CartConfirmPage();}));
        // 打开的是地址管理页
        Navigator.push(context, MaterialPageRoute(builder: (context){ return CategoryListPage(category_id: 25);}));

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom:BorderSide(width: 1,color:Colors.black12)
            )
        ),
        child: ListTile(
          leading: Icon(Icons.blur_circular),
          title: Text(title),
          trailing: Icon(Icons.arrow_right),
        ),
      ),

    );
    //Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();}))
  }

  // CategoryListPage
  Widget _myListLocationPage(BuildContext context, String title){

    return InkWell(
      onTap: (){

        debugPrint("--订单确认页");
        // Provider.of<CurrentIndexProvide>(context, listen: false).changeIndex(2);
        // Navigator.pop(context);
        // 打开的是购物车确认页
        // Navigator.push(context, MaterialPageRoute(builder: (context){ return CartConfirmPage();}));
        // 打开的是地址管理页
        //return LocationPage(category_id: 25);
        //Navigator.push(context, MaterialPageRoute(builder: (context){ return LocationPage();}));

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom:BorderSide(width: 1,color:Colors.black12)
            )
        ),
        child: ListTile(
          leading: Icon(Icons.blur_circular),
          title: Text(title),
          trailing: Icon(Icons.arrow_right),
        ),
      ),

    );
    //Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();}))
  }


  // CategoryListPage
  Widget _myLbsShopsListPage(BuildContext context, String title){

    return InkWell(
      onTap: (){

        debugPrint("--订单确认页");
        // Provider.of<CurrentIndexProvide>(context, listen: false).changeIndex(2);
        // Navigator.pop(context);
        // 打开的是购物车确认页
        // Navigator.push(context, MaterialPageRoute(builder: (context){ return CartConfirmPage();}));
        // 打开的是地址管理页
        //return LocationPage(category_id: 25);
        Navigator.push(context, MaterialPageRoute(builder: (context){ return LbsShopListPage();}));

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom:BorderSide(width: 1,color:Colors.black12)
            )
        ),
        child: ListTile(
          leading: Icon(Icons.blur_circular),
          title: Text(title),
          trailing: Icon(Icons.arrow_right),
        ),
      ),

    );
    //Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();}))
  }



  // CategoryListPage
  Widget _myGoogleMapPage(BuildContext context, String title){

    return InkWell(
      onTap: (){

        debugPrint("--订单确认页");
        // Provider.of<CurrentIndexProvide>(context, listen: false).changeIndex(2);
        // Navigator.pop(context);
        // 打开的是购物车确认页
        // Navigator.push(context, MaterialPageRoute(builder: (context){ return CartConfirmPage();}));
        // 打开的是地址管理页
        //return LocationPage(category_id: 25);
        Navigator.push(context, MaterialPageRoute(builder: (context){ return MapSample();}));

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom:BorderSide(width: 1,color:Colors.black12)
            )
        ),
        child: ListTile(
          leading: Icon(Icons.blur_circular),
          title: Text(title),
          trailing: Icon(Icons.arrow_right),
        ),
      ),

    );
    //Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();}))
  }

  Widget _mySearchPlacesPage(BuildContext context, String title){

    return InkWell(
      onTap: (){

        debugPrint("--订单确认页");
        // Provider.of<CurrentIndexProvide>(context, listen: false).changeIndex(2);
        // Navigator.pop(context);
        // 打开的是购物车确认页
        // Navigator.push(context, MaterialPageRoute(builder: (context){ return CartConfirmPage();}));
        // 打开的是地址管理页
        //return LocationPage(category_id: 25);
        Navigator.push(context, MaterialPageRoute(builder: (context){ return const SearchPlacesScreen();}));

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom:BorderSide(width: 1,color:Colors.black12)
            )
        ),
        child: ListTile(
          leading: Icon(Icons.blur_circular),
          title: Text(title),
          trailing: Icon(Icons.arrow_right),
        ),
      ),

    );
    //Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();}))
  }


  // CategoryListPage
  Widget _myOrderListPage(BuildContext context, String title){

    return InkWell(
      onTap: (){

        debugPrint("--客户订单页");
        // Provider.of<CurrentIndexProvide>(context, listen: false).changeIndex(2);
        // Navigator.pop(context);
        // 打开的是购物车确认页
        // Navigator.push(context, MaterialPageRoute(builder: (context){ return CartConfirmPage();}));
        // 打开的是地址管理页
        //return LocationPage(category_id: 25);
        // orderType =1 订单类型
        Navigator.push(context, MaterialPageRoute(builder: (context){ return OrderPage(1);}));

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom:BorderSide(width: 1,color:Colors.black12)
            )
        ),
        child: ListTile(
          leading: Icon(Icons.blur_circular),
          title: Text(title),
          trailing: Icon(Icons.arrow_right),
        ),
      ),

    );
    //Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();}))
  }


  // CategoryListPage
  Widget _myListLogin(BuildContext context, String title){

    return InkWell(
      onTap: (){

        debugPrint("--订单确认页");
        // Provider.of<CurrentIndexProvide>(context, listen: false).changeIndex(2);
        // Navigator.pop(context);
        // 打开的是购物车确认页
        // Navigator.push(context, MaterialPageRoute(builder: (context){ return CartConfirmPage();}));
        // 打开的是地址管理页
        Navigator.push(context, MaterialPageRoute(builder: (context){ return Login();}));

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom:BorderSide(width: 1,color:Colors.black12)
            )
        ),
        child: ListTile(
          leading: Icon(Icons.blur_circular),
          title: Text(title),
          trailing: Icon(Icons.arrow_right),
        ),
      ),

    );
    //Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();}))
  }


  // 登录
  Widget _myListLogout(BuildContext context, String title){

    return InkWell(
      onTap: (){

        debugPrint("--退出");
        SharePref.logout(context);

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom:BorderSide(width: 1,color:Colors.black12)
            )
        ),
        child: ListTile(
          leading: Icon(Icons.blur_circular),
          title: Text(title),
          trailing: Icon(Icons.arrow_right),
        ),
      ),

    );

  }




  Widget _actionList(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
            // _myListTile(context, '领取优惠券'),
            // _myListTile(context, '已领取优惠券'),
            _myListTile(context, '地址管理'),
           // TODO @deprecated
          // _myListConfirm(context, '订单确认页'),
           _myOrderListPage(context, '店铺订单'),
           _myListConfirmPage(context, '订单确认页2'),
           _myListCategory(context, '类目商品'),
           _myListLocationPage(context, '附近店铺1'),
           _myLbsShopsListPage(context, '附近店铺2'),
           _myGoogleMapPage(context, 'Google Map'),
          _mySearchPlacesPage(context, 'search place'),
           _myListLogin(context, '登录'),
           _myListLogout(context, '退出'),
            // _myListTile(context, '客服电话'),
            // _myListTile(context, '关于我们'),
        ],
      ),
    );
  }




}
