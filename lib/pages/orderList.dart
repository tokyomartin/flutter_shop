import 'dart:async';
import 'dart:core';

import 'package:dio/dio.dart';
import '../config/api_service.dart';
import '../model/sales_results_model.dart';
import '../util/m_net.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

// import '../../router/application.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../model/order.dart';
import '../model/order_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';

// import 'package:native_app/model/add_cart.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// 获取订单列表
Future getOrderList(int page, int limit, int? type) async {
  print('当前页码：' +
      page.toString() +
      'limit：' +
      limit.toString() +
      'type：' +
      type.toString());// orderType orderStatus


      int shopId = 1001;

      String strUrl = ApiService.mgr_orders_search_url + 'shopId=${shopId}&num=${num}&page=${page}&order_status=${type}';
      var data = await MNet.getData(strUrl);
  debugPrint("------订单列表-----");
  //debugPrint(data.toString());
  debugPrint(data['code'].toString());
  debugPrint(data['message'].toString());
  debugPrint(data['data_count'].toString());

  return data;

  // 请求服务器API
  // try {
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token');
  //
  //   var url = webApi['UserOrderList'];
  //   Map<String, dynamic> headers = new Map();
  //   headers['Cookie'] = token;
  //   Options options = new Options(headers: headers);
  //   Response response = await Dio().get("$url",
  //       options: options,
  //       queryParameters: {'page': page, 'limit': limit, 'type': type});
  //   print(response.data);
  //   return response.data;
  // } catch (e) {
  //   print(e);
  // }


}

// 订单状态
String orderStatus(int status) {
  // if (status == 0 ) {
  //   return '全部订单';
  // } else
  if (status == 1 ) {
    return '待付款|決済待ち';
  } else if (status == 2) {
    return '決済完了|配送待ち';
  } else if (status == 3) {
    return '出库中'; //配送準備
  } else if (status == 4) {
    return '倉庫発送|お客さん確認待ち'; // '待收货'; 配送准备
  }
  // else if (status == 41) {
  //   return '配送中';//'待评价';
  // }
  else if (status == 5) {
    return '荷物届く|完了';
  } else if (status == 6) {
    return '評価完了';
  } else if (status == 7) {
    return '払い戻すに申請';
  } else if (status == 8) {
    return '完成';
  } else if (status == 9) {
    return '注文取消';
  }else if (status == 10) {
    return '決済error';
  }else{
    return 'ERROR';
  }
}


bool isWaitToPay(int status) {
  if (status == 0 ||status == 1 ||status == 2) {
    return true;
  }
  return false;
}
//TODO no used
bool isWaitToPay1(int status) {
  if (status == 0 ||status == 1 ||status == 2) {
    return true;
  }
  return false;
}
//TODO no used
bool isWaitToPay2(int status) {
  if (status == 0 ||status == 1 ||status == 2) {
    return true;
  }
  return false;
}
bool isWaitToSend(int status) {
  if(status == 2)
    return true;
  else
    return false;
}
bool isSending(int status) {
  if(status == 3)
    return true;
  else
    return false;
}
bool isOnTheWayHome(int status) {
  if(status == 4)
    return true;
  else
    return false;
}

bool isFinished(int status) {
  if(status == 5)
    return true;
  else
    return false;
}
bool isCancel(int status) {
  if(status == 9)
    return true;
  else
    return false;
}

// 订单列表布局
Widget orderListUI(OrderModel order, BuildContext context) {

  List<Widget> child = [];

  if(order.salesResultsList == null || order.salesResultsList.isEmpty == true ){
    return Text("没有商品信息");
  }
  int len = order.salesResultsList.length;
  for (var i = 0; i < len; i++) {

    SalesResultsModel salesResults = order.salesResultsList[i];
    child.add(Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          InkWell(
              onTap: () {

                // 订单点击后的事件 点击后跳转页面 订单详细页
                // Application.router
                //     .navigateTo(context, "/orderDetail/${order.order.id}");
              },
              child: Row(
                children: <Widget>[

                  Image.network('http://29e5534ea20a8.cdn.sohucs.com/c_cut,x_178,y_20,w_1021,h_680,c_zoom,h_103/os/news/4b39a1b8656ef59d99a3a5d827fe5fd1.jpg',
                      errorBuilder: (c, o, s) {
                        return const Icon(
                          Icons.error,
                          color: Colors.red,
                        );
                      })

                  // 图片缓存
                  // CachedNetworkImage(
                  //   imageUrl: item.thumbnail,
                  //   width: 100.0,
                  //   height: 100.0,
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
                  // )
                  ,

                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            salesResults.product_name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            order.salesResultsList[i].cn_product_name?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 14.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '￥${order.salesResultsList[i].payment_sub_total}',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 22.0),
                              ),
                              Text(
                                '${order.salesResultsList[i].product_purchase_amount} 個',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 14.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Container(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              isCancel(int.parse(salesResults.order_status)) //TODO  取消订单 9
                  ? InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      onTap: () {},
                      child: Container(
                        height: 36.0,
                        width: 82.0,
                        margin: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(color: Colors.grey), //Colors.grey[400]
                        ),
                        child: Center(
                          child: Text('取消订单'),
                        ),
                      ),
                    )
                  : Container(),
              isWaitToPay(int.parse(salesResults.order_status))
                  ? InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      onTap: () {},
                      child: Container(
                        height: 36.0,
                        width: 82.0,
                        margin: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: Center(
                          child: Text(
                            '继续支付',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              isWaitToSend(int.parse(salesResults.order_status))
                  ? InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      onTap: () {},
                      child: Container(
                        height: 36.0,
                        width: 82.0,
                        margin: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: Center(
                          child: Text('确认收货',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                  : Container(),
              isFinished(int.parse(salesResults.order_status))
                  ? InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      onTap: () {},
                      child: Container(
                        height: 36.0,
                        width: 82.0,
                        margin: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(color: Colors.grey), //Colors.grey[400]
                        ),
                        child: Center(
                          child: Text('去评价'),
                        ),
                      ),
                    )
                  : Container()
            ],
          )
        ],
      ),
    ));
  }
  Widget list = Column(children: child);

  return list;
}

/// 质感设计样式   订单列表页 入口
class OrderPage extends StatefulWidget {

  int orderType;

  final List<Map<String, dynamic>> _tabValues = [
    {'title': '全部','route': '0'},
    {'title': '待付款|決済待ち','route': '1'},  //待付款|決済待ち
    {'title': '決済完了|配送待ち','route': '2'},   //決済完了|配送待ち
    {'title': '出库中|配送準備','route': '3'},   //出库中|配送準備
    {'title': '待收货|確認待ち','route': '4'},    //待收货|確認待ち
    {'title': '荷物届く|完了','route': '5'},    //荷物届く|完了  待评价
    {'title': '評価完了','route': '6'},    //
    {'title': '退款｜払い戻すに申請','route': '7'},    //
    {'title': '关闭｜閉める','route': '8'},    // 完成　閉める
    {'title': '注文取消','route': '9'},    // 完成 決済error
    {'title': '決済error','route': '10'},    // 完成 決済error
  ];



  OrderPage(
        this.orderType
      );

  @override
  OrderPageState createState() => OrderPageState(this.orderType);

  // @override
  // OrderPageState createState(){
  //
  //   //debugPrint('▼ Widget的CreatState！');
  //   return OrderPageState(orderType);
  //
  // }
}

class OrderPageState extends State<OrderPage> {

  OrderPageState(
      this.orderType
  );

  // OrderPageState(int orderType) {
  //   // TODO: implement
  //   print('orderList OrderPageState State的构造方法');
  //   this.orderType = orderType;
  //   throw UnimplementedError();
  // }

  // TODO 修改Tab内容  TAB页
  static List<Map<String, dynamic>> _tabValues = [
    {'title': '全部','route': '0'},
    {'title': '待付款|決済待ち','route': '1'},  //待付款|決済待ち
    {'title': '決済完了|配送待ち','route': '2'},   //決済完了|配送待ち
    {'title': '出库中|配送準備','route': '3'},   //出库中|配送準備
    {'title': '待收货|確認待ち','route': '4'},    //待收货|確認待ち
    {'title': '荷物届く|完了','route': '5'},    //荷物届く|完了  待评价
    {'title': '評価完了','route': '6'},    //
    {'title': '退款｜払い戻すに申請','route': '7'},    //
    {'title': '关闭｜閉める','route': '8'},    // 完成　閉める
    {'title': '注文取消','route': '9'},    // 完成 決済error
    {'title': '決済error','route': '10'},    // 完成 決済error
  ];



  //TAB 控件
 // TabController _controller;
  // 是否正在加载
  bool loading = false;
  // 条数
  int total = 0;
  // 当前页数
  int pageNo = 1;
  // 订单类型
  int orderType = 0;
  // 每次获取条数
  int limit = 10;
  // 当前tab
  int currentTab = 0;
  // 订单列表
  List<OrderModel> orderList = <OrderModel>[];



  TabController controller  = new TabController(
    length: _tabValues.length,
    initialIndex: 0, //orderType // index 就是订单类型 order status的订单类型
    vsync: ScrollableState(),
  );


  @override
  void initState() {

    super.initState();
    debugPrint('▼ State的initState方法！');



    // 设置当前tab
    // this.setState(
    //         (){
    //   currentTab = orderType;
    // });

      // controller = new TabController(
      //   length: _tabValues.length,
      //   initialIndex: orderType, //index 就是订单类型 order status的订单类型
      //   vsync: ScrollableState(),
      // );

    // tab切换回调
    controller.addListener(
            () {
      print('Tab当前索引 ${controller.index}' );
      OrderListModel? resultData;
      if(mounted) {
        this.setState(() {
          orderList = [];
          total = 0;
        });
      }

      //index 就是订单类型 order status 请求订单数据
      getOrderList(1, this.limit, controller.index).then((data) {
        try {

          print("OrderPageState ▶︎▶︎▶︎initState ▶︎▶︎▶︎ getOrderList　订单数据--加载解析");

          resultData = OrderListModel.fromJson(data);
        } catch (err) {

          print("订单数据--加载解析错误");
          // Common addCart = Common.fromJson(data);
          // 弹出消息窗口
          // showDialog(
          //     context: context,
          //     child: AlertDialog(
          //       title: Text('提示'),
          //       content: Text("提示消息内容"),
          //       actions: <Widget>[
          //         new FlatButton(
          //           child: new Text('确定'),
          //           onPressed: () {
          //             // 跳转登录画面
          //             // Navigator.of(context).pop();
          //             // Application.router.navigateTo(context, "/login");
          //           },
          //         ),
          //       ],
          //     ));

          print(err);
          return;
        }
        this.setState(() {

          print("OrderPageState ▶︎▶︎▶︎initState ▶︎▶︎▶︎ setState　订单数据--加载解析");

          currentTab = controller.index;
          //TODO 这里是订单详细表中的数据  可能需要改
          orderList = resultData?.data ?? <OrderModel>[];
          total = resultData?.data?.length ?? 0;
          // total = resultData.data_count;

          pageNo = 1;
        });
      });
    });

    OrderListModel? resultData;
    // 获取列表
    getOrderList(this.pageNo, this.limit, orderType).then((data) {
      try {
        print("准备解析订单列表");
        resultData = OrderListModel.fromJson(data);
        loading = true;
      } catch (err) {
        print("解析错误");
        loading = false;
        // Common addCart = Common.fromJson(data);
        // showDialog(
        //     context: context,
        //     child: AlertDialog(
        //       title: Text('提示'),
        //       content: Text(addCart.msg == null ? '' : addCart.msg),
        //       actions: <Widget>[
        //         new FlatButton(
        //           child: new Text('确定'),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //             Application.router.navigateTo(context, "/login");
        //           },
        //         ),
        //       ],
        //     ));


        print(err);
        return;
      }
      this.setState(() {
        orderList = resultData?.data ?? <OrderModel>[];
        loading = loading;
        total = resultData?.data?.length ?? 0;
      });
    });

  } //END initstate

  @override
  void dispose() {
// TODO: implement dispose
    super.dispose();
    print('State的dispose方法');
  }

  @override
  void didChangeDependencies() {
// TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('didChangeDependencies方法');
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            '订单管理',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            tabs: _tabValues.map((tabItem) {  //TODO 这里得改改
              return Text(
                tabItem['title'],
                style: TextStyle(fontSize: 18.0),
              );
            }).toList(),
            controller: controller,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[200],
            indicatorWeight: 2.0,
            indicatorPadding: EdgeInsets.only(
              top: 5.0,
            ),
            labelStyle: TextStyle(height: 4.0),
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: _tabValues.map((tabItem) {
            return currentTab == int.parse(tabItem['route']) ? EasyRefresh.custom(
              header: MaterialHeader(),
              footer: MaterialFooter(),
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    total = this.limit;
                  });
                });
              },
              onLoad: () async {

                // // 请求API数据
                OrderListModel resultData;
                int currentPage = this.pageNo + 1;
                print("this.pageNo : " + this.pageNo.toString());
                print("当前加载页码: " + currentPage.toString());

                getOrderList(currentPage, this.limit, orderType)
                    .then((data) {
                  try {
                    print("加载解析Success!");

                    resultData = new OrderListModel.fromJson(data);

                  } catch (err) {

                    print("加载解析错误");
                    // Common addCart = Common.fromJson(data);
                    // showDialog(
                    //     context: context,
                    //     child: AlertDialog(
                    //       title: Text('提示'),
                    //       content: Text(addCart.msg == null ? '' : addCart.msg),
                    //       actions: <Widget>[
                    //         new FlatButton(
                    //           child: new Text('确定'),
                    //           onPressed: () {
                    //             Navigator.of(context).pop();
                    //             Application.router
                    //                 .navigateTo(context, "/login");
                    //           },
                    //         ),
                    //       ],
                    //     ));
                    print(err);


                    return;
                  }

                  //TODO 加载订单数据
                 this.orderList.addAll(resultData.data);
                 if(mounted) {
                   this.setState(() {
                     orderList = this.orderList;
                     int dataLen = resultData.data.length;
                     total = total + dataLen;
                     pageNo = currentPage;
                   });
                 }
                }
                );

              },
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Text(
                                      orderStatus(
                                          orderList[index].order_status ?? 0),
                                      style: TextStyle(
                                          color: Colors.orange[600],
                                          fontSize: 16.0),
                                    ),

                                  ],
                                ),

                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '订单号：${orderList[index].order_id}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      '￥${orderList[index].payment_amount}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),


                                  ],
                                ),

                              ),
                              // 邮寄地址 基本信息
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '会員号：${orderList[index].member_id}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      '会員：${orderList[index].member_delivery_address!= null?orderList[index].member_delivery_address?.last_name: ""}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      '电话：${orderList[index].member_delivery_address!= null?orderList[index].member_delivery_address?.last_name_kana: ""}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),

                                  ],
                                ),

                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${orderList[index].member_delivery_address?.prefecture}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      '${orderList[index].member_delivery_address!= null?orderList[index].member_delivery_address?.city: ""}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      'ADDR：${orderList[index].member_delivery_address!= null?orderList[index].member_delivery_address?.address1: ""}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),

                                  ],
                                ),

                              ),

                              Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '电话：${orderList[index].member_delivery_address?.phone_number}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      'POST：${orderList[index].member_delivery_address!= null?orderList[index].member_delivery_address?.post_code_front: ""}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      '-${orderList[index].member_delivery_address!= null?orderList[index].member_delivery_address?.post_code_back: ""}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),

                                  ],
                                ),

                              ),

                              orderListUI(orderList[index], context),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: total,
                  ),
                ),
              ],
            ): Center(
              child: SizedBox(
                width: 30.0,
                height: 30.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            );
          }).toList(),
        ));
  }
}
