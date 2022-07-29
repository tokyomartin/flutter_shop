import 'dart:async';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cartInfo.dart';
import 'package:flutter_shop/model/delivery_addr.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:flutter_shop/util/share_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../config/api_service.dart';
import '../util/m_net.dart';

//import 'package:native_app/model/user_address.dart';
//import 'package:native_app/model/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'delivery_addr_page.dart';

// import 'package:cached_image_network/cached_image_network.dart';

// 获取收货地址
Future getUserAddress() async {
  try {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('token');
    // var url = webApi['AddressList'];
    // Map<String, dynamic> headers = new Map();
    // headers['Cookie'] = token;
    // Options options = new Options(headers: headers);
    // Response response = await Dio().post("$url", options: options);
    // print(response.data);
    // return response.data;
  } catch (e) {
    print(e);
  }
}

// 获取商品清单
Future getCartList() async {
  try {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('token');
    // var url = webApi['CartSelectList'];
    // Map<String, dynamic> headers = new Map();
    // headers['Cookie'] = token;
    // Options options = new Options(headers: headers);
    // Response response = await Dio().get("$url", options: options);
    // print(response.data);
    // return response.data;
  } catch (e) {
    print(e);
  }
}

/// 质感设计样式
class ConfirmOrderPage extends StatefulWidget {
  const ConfirmOrderPage();
  @override
  ConfirmOrderPageState createState() => ConfirmOrderPageState();
}

class ConfirmOrderPageState extends State<ConfirmOrderPage> {
  ConfirmOrderPageState();

  //TODO 个人收货地址列表
  List<DeliveryAddrMode> addressList = [];


  ValueNotifier<String> delivery_address = ValueNotifier<String>("");
  //TODO 选择的收货地址
  //DeliveryAddrMode currentAddress;

  // 商品清单
  List<CartInfoMode> cartList = [];
  //List<CartInfoMode> cartList = Provider.of<CartProvide>(context, listen: false).cartList;

  // 商品总价
  double total = 0;

  @override
  void initState() {
    super.initState();

    // UserAddress userAddressData; // 收货地址数据
    //
    // getUserAddress().then((data) {
    //   try {
    //     userAddressData = UserAddress.fromJson(data);
    //   } catch (err) {
    //     print(err);
    //   }
    //   userAddressData.data.forEach((item) {
    //     // 默认收货地址
    //     if (item.isDefault == 1) {
    //       this.setState(() {
    //         currentAddress = item;
    //       });
    //     }
    //   });
    // });

    // 调用购物车接口
    // Cart cartData; // 商品清单
    //
    // getCartList().then((data) {
    //   try {
    //     cartData = Cart.fromJson(data);
    //   } catch (err) {
    //     print(err);
    //   }
    //   double totals = 0;
    //   cartData.data
    //       .map((item) => {
    //             if (item.cart.status == 1)
    //               {
    //                 if (item.attrList.id == 0)
    //                   {
    //                     totals += double.parse(item.productPrice.toString()) *
    //                         item.cart.cartNumber,
    //                   }
    //                 else
    //                   {
    //                     totals += double.parse(
    //                             item.attrList.productPrice.toString()) *
    //                         item.cart.cartNumber,
    //                   }
    //               }
    //           })
    //       .toList();
    //   this.setState(() {
    //     cartList = cartData.data;
    //     total = totals;
    //   });
    // });


  }

// 显示的价格
  String showPrice(CartInfoMode item) {
    var price = '';
    price = item.price.toString();
    return price;
  }

  listUI(BuildContext context) {
    List<Widget> itemList = [];

    cartList = Provider.of<CartProvide>(context, listen: false).cartList;

    cartList.map((item) {
      itemList.add(
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[100]))),
          margin: EdgeInsets.only(bottom: 20.0, right: 8.0,left: 8.0),
          padding: EdgeInsets.only(
            bottom: 8.0
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      child:
                Image.network(item.small_pic,
                    errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                      return Text('Your error widget...');
                    }),  //item.small_pic

                      // CachedNetworkImage(
                      //   width: 100.0,
                      //   height: 100.0,
                      //   imageUrl: item.small_pic,
                      //   placeholder: (context, url) => new Icon(
                      //     Icons.image,
                      //     color: Colors.grey[300],
                      //     size: 100.0,
                      //   ),
                      //   errorWidget: (context, url, error) => new Icon(
                      //     Icons.image,
                      //     color: Colors.grey[300],
                      //     size: 100.0,
                      //   ),
                      // ),
                      width: 100.0,
                      height: 100.0,
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        margin: EdgeInsets.only(
                          left: 8.0
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(item.product_name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 18.0)),
                            item.product_name != ''
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    margin:
                                        EdgeInsets.only(top: 5.0, bottom: 5.0),
                                    padding: EdgeInsets.only(
                                        left: 5.0,
                                        right: 5.0,
                                        top: 3.0,
                                        bottom: 3.0),
                                    child: Text(
                                      item.product_name,
                                      style: TextStyle(color: Colors.grey[500]),
                                      maxLines: 2,
                                    ),
                                  )
                                : Container(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "￥" + showPrice(item),
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 22.0),
                                ),
                                Text("x" + item.quantity.toString()),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }).toList();
    return itemList;
  }

  Widget listItemAddress(BuildContext context, String title){

    return Material(
      child: InkWell(
        onTap: () async {
          // Application.router.navigateTo(context, "/orderMap").then((onValue){
          //   print(onValue);
          // });
          debugPrint("--订单确认页面");

          // 打开的是地址管理页
          final result = await  Navigator.push(context, MaterialPageRoute(builder: (context){ return DeliveryAddrPage();}));

          // Scaffold.of(context).showSnackBar(SnackBar(content:Text('$result')));

          var addr = result.split(':');
          var prefix = addr[0].trim();
          var address = addr[1].trim();

          // _delivery_address_id.value = result;
          delivery_address.value = address;

          debugPrint("-------  _myListTile-----result-----");
          debugPrint(result);

        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
              top: 15.0, bottom: 15.0, left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(Icons.room),
             // currentAddress != null
              delivery_address != null
                  ? Expanded(child: Container(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
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
                      valueListenable:  delivery_address,
                      // 如果child 的构建成本很高，并且不依赖于通知程序的值，则child参数非常有用。
                      // child: goodJob,
                    ),

                    Text(
                      "配送地址2：" +
                      delivery_address.value,
                      // currentAddress.prefecture +
                      //     currentAddress.city +
                      //     currentAddress.address1,
                          //currentAddress.detail,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Container(
                      height: 10.0,
                    ),
                    // Text(
                    //     currentAddress.first_name +
                    //         ' ' +
                    //         currentAddress.phone_number,
                    //     style: TextStyle(
                    //         fontSize: 16.0, color: Colors.grey))
                  ],
                ),
              ),)
                  : Text(title),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );


  }

  Widget listItem(BuildContext context, String fieldName, var fieldValue){
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text( fieldName, style: TextStyle(fontSize: 16.0),),
          Text('${fieldValue.toString()}',style: TextStyle(fontSize: 16.0,color: Colors.red),),
        ],
      ),
    );
  }

  Widget listItemDollarFlag(BuildContext context, String fieldName, var fieldValue){
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text( fieldName, style: TextStyle(fontSize: 16.0),),
          Text('￥ ${fieldValue.toString()}',style: TextStyle(fontSize: 16.0,color: Colors.red),),
        ],
      ),
    );
  }


  Widget myListToOrder(BuildContext context, String title){

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

        params['delivery_address_id'] = delivery_address.value;

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

            //val['code']

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
                msg:  val['message'],//"订单提交失败！请联系客服！",
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
      child:
      Text(
        '注文|提交订单', //'去支付'　お支払い,
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),

      // Container(
      //   decoration: BoxDecoration(
      //       color: Colors.white,
      //       border: Border(
      //           bottom:BorderSide(width: 1,color:Colors.black12)
      //       )
      //   ),
      //   child:
      //   ElevatedButton.icon(
      //     icon: Icon(Icons.send),
      //     label: Text(title),
      //     // onPressed: _onPressed,
      //   ),
      //
      //
      //   // ListTile(
      //   //   leading: Icon(Icons.blur_circular),
      //   //   title: Text(title),
      //   //   trailing: Icon(Icons.arrow_right),
      //   // ),
      // ),


    );

    //Navigator.push(context, MaterialPageRoute(builder: (context){ return Register();}))

  }



  @override
  Widget build(BuildContext context) {

    double allPrice = Provider.of<CartProvide>(context, listen: false).allPrice;
    int allGoodsCount =  Provider.of<CartProvide>(context, listen: false).allGoodsCount;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.white,
          pinned: true,
          elevation: 1.0,
          title: Text(
            '确认订单',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[],
        ),
        SliverPadding(
            padding: const EdgeInsets.all(0.0),
            sliver: new SliverList(
                delegate: new SliverChildListDelegate(<Widget>[
              Container(
                height: 2.0,
                color: Colors.grey[200],
              ),
              listItemAddress(context, "添加收货地址"),  // 列表
              Container(
                height: 10.0,
                color: Colors.grey[200],
              ),
              Container(
                child: Text('商品清单'),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[300]))),
              ),
              Column(
                children: listUI(context),
              ),
              Container(
                height: 10.0,
                color: Colors.grey[200],
              ),
              Column(
                children: <Widget>[

                  listItem(context, '商品总数', allGoodsCount),
                  listItemDollarFlag(context, '商品总额', allPrice),

                  // Container(
                  //   padding: EdgeInsets.all(10.0),
                  //   child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     Text('商品总额',style: TextStyle(fontSize: 16.0),),
                  //     Text('￥${allPrice.toString()}',style: TextStyle(fontSize: 16.0,color: Colors.red),),
                  //   ],
                  // ),
                  // ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('配送费',style: TextStyle(fontSize: 16.0),),
                      Text('￥0',style: TextStyle(fontSize: 16.0,color: Colors.red),),
                    ],
                  ),
                  ),

                  // Container(
                  //   padding: EdgeInsets.all(10.0),
                  //   child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     Text('实付款',style: TextStyle(fontSize: 16.0),),
                  //     Text('￥${total.toString()}',style: TextStyle(fontSize: 16.0,color: Colors.red),),
                  //   ],
                  // ),
                  // )
                  
                ],
              )
            ])))
      ]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 40,
        height: 42.0,
        child:
        myListToOrder(context, '提交订单'),
        // Text(
        //   '去支付',
        //   style: TextStyle(fontSize: 18.0, color: Colors.white),
        // ),
      ),
    );
  }
}
