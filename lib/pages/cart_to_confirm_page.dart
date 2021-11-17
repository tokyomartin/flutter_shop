import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/api_service.dart';
// import 'package:flutter_shop/pages/cart_confirm_page.dart';
import 'package:flutter_shop/pages/delivery_addr_page.dart';
import 'package:flutter_shop/pages/pay_method_page.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:flutter_shop/util/m_net.dart';
import 'package:flutter_shop/util/share_pref.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fluttertoast/fluttertoast.dart';



  class CartToConfirmPage extends StatefulWidget {

  // const CartToConfirmPage({Key? key, required this.title}) : super(key: key);
    var allPrice;
    var delivery_address_id = 0;

  @override
  State<CartToConfirmPage> createState() => _CartToConfirmPageState();
  }

class _CartToConfirmPageState  extends State<CartToConfirmPage>  {

  // var allPrice;
  // var delivery_address_id = 0;

   ValueNotifier<String> _delivery_address = ValueNotifier<String>("");

  // final Widget goodJob = const Text('Good job! ');

   @override
   void initState() {
     debugPrint("CartToConfirmPage");
     super.initState();

     //TODO for test
     // _goodsListFuture = _getHotGoods(25, 8, 1);
     _getDefaultDeliveryAddr();

   }


   //火爆商品接口
   _getDefaultDeliveryAddr() async{

     // var formPage={'categoryId': category_id, 'num': num, 'page': page};
     //
     // // request('homePageBelowConten',formData:formPage)
     // String strUrl = ApiService.mall_goods_top_url + 'category_id=${category_id}&num=${num}&page=${page}';

     var member_id = "";
     final Map<String, dynamic> params = new Map<String, dynamic>();

     member_id = await SharePref.getSharePrefMemberId(context);
     // debugPrint(member_id);

     //TODO DEMO
     params['member_id'] = member_id.toString();
     // params['pay_method'] = 4;

     //oauthPost
     await MNet.getPostData(ApiService.mall_delivery_addr_get_default_url, params).then((val) async {
       debugPrint("params");
       debugPrint("1.1  接口");
       debugPrint(val.toString());

       if(val['result'] == 'true'){

         var address = val['data'];

         widget.delivery_address_id = address['id'];

         _delivery_address.value = address['prefecture'] +  address['city'] +  address['address1'];

         // Fluttertoast.showToast(
         //     msg: "提交订单成功！",
         //     toastLength: Toast.LENGTH_SHORT,
         //     gravity: ToastGravity.CENTER,
         //     timeInSecForIosWeb: 1,
         //     backgroundColor: Colors.red,
         //     textColor: Colors.white,
         //     fontSize: 16.0
         // );

       }else{

         Fluttertoast.showToast(
             msg: "获取配送地址失败，请选择配送地址",
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
             backgroundColor: Colors.red,
             textColor: Colors.white,
             fontSize: 16.0
         );

       }
     });

   }


  @override
  Widget build(BuildContext context) {

    widget.allPrice = Provider.of<CartProvide>(context, listen: false).allPrice;

   return Scaffold(
     appBar: AppBar(
       title: Text('订单确认'),
     ),
     body:ListView(
       children: <Widget>[
          // _topHeader(),
          // _orderTitle(),
          // _orderType(),
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
                 errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                 return Text('Your error widget...');
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

  Widget _orderType(){

    return Container(
      margin: EdgeInsets.only(top:5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top:20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.party_mode,
                  size: 30,
                ),
                Text('待付款'),
              ],
            ),
          ),
          //-----------------
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.query_builder,
                  size: 30,
                ),
                Text('待发货'),
              ],
            ),
          ),
           //-----------------
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                   size: 30,
                ),
                Text('待收货'),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,
                   size: 30,
                ),
                Text('待评价'),
              ],
            ),
          ),
        ],
      ),
    );

  }

  Widget _myListTile(BuildContext context, String title) {

    return InkWell(
      onTap: () async{

          debugPrint("--订单确认页面");

          // 打开的是地址管理页
           final result = await  Navigator.push(context, MaterialPageRoute(builder: (context){ return DeliveryAddrPage();}));

          // Scaffold.of(context).showSnackBar(SnackBar(content:Text('$result')));

          var addr = result.split(':');
          var prefix = addr[0].trim();
          var address = addr[1].trim();

          // _delivery_address_id.value = result;
          _delivery_address.value = address;

          debugPrint("-------  _myListTile-----result-----");
          debugPrint(result);



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


  Widget _myListPayMethod(BuildContext context, String title){

    return InkWell(
      onTap: (){

        debugPrint("--订单确认页面");
        // Provider.of<CurrentIndexProvide>(context, listen: false).changeIndex(2);
        // Navigator.pop(context);
        // 打开的是购物车确认页
        // Navigator.push(context, MaterialPageRoute(builder: (context){ return CartConfirmPage();}));
        // 打开的是地址管理页
        Navigator.push(context, MaterialPageRoute(builder: (context){ return PayMethodPage();}));

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

  Widget _myListToOrder(BuildContext context, String title){

    return InkWell(
      onTap: () async {

        var member_id = "";
        final Map<String, dynamic> params = new Map<String, dynamic>();

        member_id = await SharePref.getSharePrefMemberId(context);
        // debugPrint(member_id);

        //TODO DEMO
        params['member_id'] = member_id.toString();
        params['pay_method'] = 4;

        // params['delivery_address_id'] = widget.delivery_address_id;

        params['delivery_address_id'] = _delivery_address.value;

        params['card_seq'] = 1;

        // // 请求书
        // $request_flag = $request->input('request_flag');
        // // 发注书
        // $offer_flag = $request->input('offer_flag');

        //oauthPost
        await MNet.getPostData(ApiService.cart_order_url, params).then((val) async {
          debugPrint("params");
          debugPrint("1.2 _myListToOrder 提交到订单接口");
          debugPrint(val.toString());

          if(val['result'] == 'true'){

            Fluttertoast.showToast(
                msg: "提交订单成功！",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );

            Provider.of<CartProvide>(context, listen: false).getCartInfo(  context);

            Navigator.pop(context);

          }else{

            Fluttertoast.showToast(
                msg: "订单提交失败！请联系客服！",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );

          }


        });

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom:BorderSide(width: 1,color:Colors.black12)
            )
        ),
        child:
        ElevatedButton.icon(
          icon: Icon(Icons.send),
          label: Text(title),
          // onPressed: _onPressed,
        ),


        // ListTile(
        //   leading: Icon(Icons.blur_circular),
        //   title: Text(title),
        //   trailing: Icon(Icons.arrow_right),
        // ),
      ),

    );

    //Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();}))

  }



  Widget _myListCentent(BuildContext context, String title){

    return InkWell(
      onTap: (){

        debugPrint("--_myListCententDelivery");


      },
      child: Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 14),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Color(0xFFFFC600),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                '# ${title}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    //Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();}))

  }

  Widget _myListCententRebuild(BuildContext context ){

    return InkWell(
      onTap: (){

        debugPrint("--_myListCententRebuild");


      },
      child: Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Color(0xFFFFC600),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              ValueListenableBuilder<String>(
                builder: (BuildContext context, String value, Widget child) {
                  // 只有在更新计数器时才会调用此生成器。
                  return Row(
                    children: <Widget>[
                      Text('配送地址：'),
                      Text('$value'),
                  // child
                    ]
                  );
                },
                valueListenable:  _delivery_address,
                // 如果child 的构建成本很高，并且不依赖于通知程序的值，则child参数非常有用。
                // child: goodJob,
              )

          ],
        ),
      ),
    );

    //Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();}))

  }




  Widget _myListTitleCentent(BuildContext context, String title, String info){

    return InkWell(
      onTap: (){

        debugPrint("--_myListCententDelivery");


      },
      child: Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 14),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Color(0xFFFFC600),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                '# ${title}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),

            Text(
              info,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),

    );

    //Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();}))

  }


  Widget _actionList(BuildContext context){



    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
            // _myListTile(context, '领取优惠券'),
            // _myListTile(context, '已领取优惠券'),
            _myListTile(context, '订单请求金额'),
            _myListCentent(context,  "合计: " + widget.allPrice.toString() + "円"),
            _myListTile(context, '配送地址修改'),
            
            _myListCententRebuild(context),

            _myListPayMethod(context, '支付方法修改'),
            _myListCentent(context,  "货到付款"),
            // _myListCentent(context, '支付方法信息', "微信扫码支付"),
          _myListTitleCentent(context, '配送料', "订单满5000円无料, 低于5000円运费600円！"),
          _myListToOrder(context, '提交订单'),

          // _myListTile(context, '客服电话'),
            // _myListTile(context, '关于我们'),
        ],
      ),
    );
  }




}