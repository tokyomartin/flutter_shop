import 'package:flutter/material.dart';
import 'package:flutter_shop/config/api_service.dart';
import 'package:flutter_shop/pages/shop_product_list_page.dart';
import 'package:flutter_shop/util/m_net.dart';
// import '../service/service_method.dart';


import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../routers/application.dart';

//--------
// import 'package:provide/provide.dart';

import '../provide/child_category.dart';
import '../provide/currentIndex.dart';
import '../model/category.dart';
import 'package:provider/provider.dart';
import 'package:common_utils/common_utils.dart';

// 类目商品列表   显示该类别下面的商品的列表
class LbsShopListPage extends StatefulWidget {

  int pageSize = 2; //请求的数量
  // int category_id = 1;

  int shopId = 1001; //暂时是请求数据的列表数组下标  暂时不是店铺ID
  double lat = 100;
  double long = 200;


  LbsShopListPage({Key? key}) : super(key: key);

  _LbsShopListPageState createState() => _LbsShopListPageState();

}

class _LbsShopListPageState extends State<LbsShopListPage> with AutomaticKeepAliveClientMixin {

  // _CategoryListPageState({Key key, @required this.category_id});

  // int category_id = 25;

  // List<Map> hotGoodsList =[];
  Map goodsList ={};

  Future? _goodsListFuture;

  int myPage = 1; // 显示第几页



  
  @override
  bool get wantKeepAlive =>true;

  @override
  void initState() {

    debugPrint("-------LbsShopListPage state");
    // debugPrint(widget.categoryId.toString());
    debugPrint(widget.shopId.toString());
    debugPrint("-------LbsShopListPage lat: " + widget.lat.toString());
    debugPrint("-------LbsShopListPage long: " + widget.long.toString());
    super.initState();

    //TODO for test
    // _goodsListFuture = _getHotGoods(25, 8, 1);
     _goodsListFuture = _getShopList(widget.shopId, widget.pageSize);

  }

  EasyRefreshController _controller = EasyRefreshController();

  // GlobalKey<EasyRefreshState> _easyRefreshKey =new GlobalKey<EasyRefreshState>();
  // GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  //Todo change FormState
   // GlobalKey _footerKey = GlobalKey();
  GlobalKey<FormState> _footerKey = GlobalKey<FormState>();


//   //初始化设置 LogUtil
//   LogUtil.init(true);
// //输出日志



    
      


  @override
  Widget build(BuildContext context) {

    super.build(context);

    //获取路由参数
    var args = ModalRoute.of(context)?.settings.arguments;

    debugPrint("------arguments:" + args.toString());


    // var formData = {'lon':'115.02932','lat':'35.76189'};
    // Future<dynamic> futureEntry =  MNet.getData(ApiService.homepage_url);
    //
    // futureEntry.then((dynamic result) {}
    //
    // );


    Future _gerData() async {
      var response = MNet.getResponse(ApiService.homepage_url);
      return response;
    }




    return  Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      appBar: AppBar(title: Text('附近商店'),),
      body:
       FutureBuilder(

         // homePageContext
       // future:request('homePageCategory',formData:formData),
       //  future: _gerData(),
       //  future: _getHotGoodsList(),
       //    future:   _getHotGoods(25, 8, 1),
           future :   _goodsListFuture,
        builder: (context,snapshot){

          debugPrint("------------CategoryListPage");
          debugPrint(snapshot.toString());
          debugPrint(snapshot.connectionState.toString());
          debugPrint(snapshot.data.toString());

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // 请求失败，显示错误
              return Text("Error: ${snapshot.error}");
            } else {
              // 请求成功，显示数据
              //return Text("Contents: ${snapshot.data}");
              debugPrint(snapshot.data.toString());

                  if(snapshot.hasData){
                    debugPrint("has Data");
                    //var myData=json.decode(snapshot.data.toString());

                    var myData= snapshot.data.toString();

                    debugPrint("Data:" + myData.toString());

                   // _getHotGoods(25, 8, 1);
                   //  _getHotGoods(26, 8, 1);


                    debugPrint("1.4 加载首页数据END");

                    return EasyRefresh(
                        key:_footerKey,
                        controller: _controller,
                        firstRefresh: true,



                        // refreshFooter: ClassicsFooter(
                        //   key:_footerKey,
                        //   bgColor:Colors.white,
                        //   textColor: Colors.pink,
                        //   moreInfoColor: Colors.pink,
                        //   showMore: true,
                        //   noMoreText: '',
                        //   moreInfo: '加载中',
                        //   loadReadyText:'上拉加载....'
                        //
                        // ),

                        child: ListView(
                          children: <Widget>[
                            // SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
                            // TopNavigator(navigatorList:navigatorList),   //导航组件

                            // AdBanner(advertesPicture:advertesPicture), //广 b    告图片
                            // LeaderPhone(leaderImage:leaderImage,leaderPhone: leaderPhone),  //广告组件
                            // Recommend(recommendList:recommendList),
                            // FloorTitle(picture_address:floor1Title),
                            // FloorContent(floorGoodsList:floor1),
                            //TODO
                            // FloorTitle(picture_address:floor2Title),
                            // FloorContent(floorGoodsList:floor2),
                            // FloorTitle(picture_address:floor3Title),
                            // FloorContent(floorGoodsList:floor3),
                            //_getHotGoodsList(),
                            // _hotGoodsWidget("火爆专区",25),
                            _hotGoodsWidget("火爆专区", widget.shopId),
                            // _hotGoodsWidget("火爆专区", widget.category_id),
                           // _hotGoodsWidget("精品专区",26),

                          ],
                        ) ,

                      //loadMore
                      // onRefresh: ()async{
                      //   if(Provider.of<ChildCategory>(context, listen: false).noMoreText=='没有更多了'){
                      //     Fluttertoast.showToast(
                      //         msg: "已经到底了",
                      //         toastLength: Toast.LENGTH_SHORT,
                      //         gravity: ToastGravity.CENTER,
                      //         //timeInSecForIos: 1,
                      //         backgroundColor: Colors.pink,
                      //         textColor: Colors.white,
                      //         fontSize: 16.0
                      //     );
                      //   }else{
                      //
                      //     _getMoreList();
                      //   }
                      // },
                        onLoad: () async {
                          await Future.delayed(Duration(seconds: 1), () {
                            if(Provider.of<ChildCategory>(context, listen: false).noMoreText=='没有更多了'){
                              Fluttertoast.showToast(
                                  msg: "已经到底了",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  //timeInSecForIos: 1,
                                  backgroundColor: Colors.pink,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }else{

                              _getMoreList();
                            }
                          });
                        },


                        // loadMore
                        // onRefresh: _getHotGoodsList
                    );

                    //}
                }else{
                return Center(
                child: Text('加载中'),
                );
              }


            }
          } else {
            // 请求未结束，显示loading
            return CircularProgressIndicator();
          }

        },
      )
    );

  }


//   ()async{
//   print('开始加载更多');
//   var formPage={'page': page};
//   //TODO
//   // await request('homePageBelowConten',formData:formPage).then ...
//   MNet.getData(ApiService.mall_goods_top_url)
//       .then((val){
//
//   debugPrint("首页HOT GOODS商品列表");
//   debugPrint(val.toString());
//
//   //var data=json.decode(val.toString());
//   var data=val;
//   List<Map> newGoodsList = (data['data'] as List ).cast();
//   setState(() {
//   hotGoodsList.addAll(newGoodsList);
//   page++;
//   });
//   });
// },

    _getShopList(category_id, page_size) async{

     await _getHotGoods(category_id, page_size, 1);
     myPage++;
     return true;

  }
     _getMoreList() async{

       debugPrint("_getMoreShop call");
      // await _getMoreGoods(widget.category_id, widget.page_size, myPage);
       await _getMoreGoods(widget.shopId, widget.pageSize, myPage);

      return true;

    }

  //火爆商品接口
   _getHotGoods(shopId, pageSize, pageNo) async{

    // var formPage={'shopId': shopId, 'num': num, 'page': page};

     // request('homePageBelowConten',formData:formPage)
     String strUrl = ApiService.shop_list_by_geohash_url + 'shopId=${shopId}&lat=${widget.lat}&long=${widget.long}&page_size=${pageSize}&page_no=${pageNo}';


     var data = await MNet.getData(strUrl);

       //var data=json.decode(val.toString());
       debugPrint("店铺列表");
       debugPrint(data.toString());

       List<Map> newGoodsList = (data['data'] as List ).cast();
       goodsList[shopId] = newGoodsList;
       myPage = 1;
         // goodsList[category_id].addAll(newGoodsList);
  }

  //火爆商品接口
  _getMoreGoods(shopId, pageSize, pageNo) async{

    // var formPage={'shopId': shopId, 'num': num, 'page': page};

    String strUrl = ApiService.shop_list_by_geohash_url + 'shopId=${shopId}&lat=${widget.lat}&long=${widget.long}&page_size=${pageSize}&page_no=${pageNo}';
    var data = await MNet.getData(strUrl);
    //var data=json.decode(val.toString());
    debugPrint("店铺列表");
    debugPrint(data.toString());
    List<Map> newGoodsList = (data['data'] as List ).cast();
    // goodsList[category_id] = newGoodsList;
    setState(() {
          goodsList[shopId].addAll(newGoodsList);
          myPage++;
       });
  }

  //火爆专区标题
  Widget hotTitle(title){

    return Container(
      margin: EdgeInsets.only(top: 10.0),

      padding:EdgeInsets.all(5.0),
      alignment:Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border:Border(
              bottom: BorderSide(width:0.5 ,color:Colors.black12)
          )
      ),
      //'火爆专区'
      child: Text(title),
    );

  }

  getHotGoodsList(shopId){
    return goodsList[shopId];
  }

  //火爆专区子项
  Widget _wrapList(shopId){

    List<Map> hotGoodsListItem = goodsList[shopId];

    if(hotGoodsListItem!= null && hotGoodsListItem.length!=0){

      List<Widget> listWidget = hotGoodsListItem.map((val){
          
          return InkWell(
              onTap:(){
                debugPrint("首页 hotTitle----ShopProductListPage");
                // Application.router.navigateTo(context,"/detail?id=${val['id']}");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return ShopProductListPage(shopId: val['id']);
                    }
                    )
                );
              },

            child: 
            Container(
              width: ScreenUtil().setWidth(372),
              color:Colors.white,
              padding: EdgeInsets.all(5.0),
              margin:EdgeInsets.only(bottom:3.0),
              child: Column(
                children: <Widget>[
                  // Image.network(val['image'],width: ScreenUtil().setWidth(375),),
                  Image.network(val['small_pic'],
                  width: ScreenUtil().setWidth(375),
                  errorBuilder: (c, o, s) {
                return const Icon(
                  Icons.error,
                  color: Colors.red,
                );
              }
                  ),
                  // Image.network("http://29e5534ea20a8.cdn.sohucs.com/c_cut,x_178,y_20,w_1021,h_680,c_zoom,h_103/os/news/4b39a1b8656ef59d99a3a5d827fe5fd1.jpg" ,width: ScreenUtil().setWidth(375),),
                  Text(
                   // val['name'],
                    val['company_name'],
                    // "test_name1",
                    maxLines: 1,
                    overflow:TextOverflow.ellipsis ,
                    style: TextStyle(color:Colors.pink,fontSize: ScreenUtil().setSp(26)),
                  ),
                  Text(
                    // val['name'],
                    "(" + val['distKm'] + "公里)" ,
                    // "test_name1",
                    maxLines: 1,
                    overflow:TextOverflow.ellipsis ,
                    style: TextStyle(color:Colors.pink,fontSize: ScreenUtil().setSp(26)),
                  ),
                  Row(
                    children: <Widget>[
                     // Text('￥${val['mallPrice']}'),
                      Text('${val['address1']}'),
                      // Text('￥100'),
                      // Text( '￥${val['price']}',style: TextStyle(color:Colors.black26,decoration: TextDecoration.lineThrough),  )
                      Text( '￥',style: TextStyle(color:Colors.black26,decoration: TextDecoration.lineThrough),
                      // Text( '￥200',style: TextStyle(color:Colors.black26,decoration: TextDecoration.lineThrough),
                      )

                    ],
                  )
                ],
              ), 
            )
           
          );

      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    }else{
      return Text('数据为空');
    }
  }

  //火爆专区组合
  Widget _hotGoodsWidget(title, category_id){

    return Container(
          
          child:Column(
            children: <Widget>[
              hotTitle(title),
               _wrapList(category_id),
            ],
          )   
    );
  }


}
// 首页轮播组件编写
class SwiperDiy extends StatelessWidget{

   

  final List? swiperDataList;
  SwiperDiy({Key? key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {

    debugPrint("1.5");
     
    return Container(
      color:Colors.white,
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return InkWell(
            onTap: (){
              
             
               Application.router.navigateTo(context,"/detail?id=${swiperDataList?[index]['goodsId']}");

            },
            child:  Image.network("${swiperDataList?[index]['image']}",
                errorBuilder: (c, o, s) {
                  return const Icon(
                    Icons.error,
                    color: Colors.red,
                  );
                },
                fit:BoxFit.fill),
          );
         
        },
        itemCount: swiperDataList?.length ?? 0,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}


//首页导航组件
class TopNavigator extends StatelessWidget {
  final List? navigatorList;
  TopNavigator({Key? key, this.navigatorList}) : super(key: key);
  Widget _gridViewItemUI(BuildContext context,item,index){

    debugPrint("1.6");
    // print('------------------${item}');
    return InkWell(
      onTap: (){
        _goCategory(context,index,item['mallCategoryId']);
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width:ScreenUtil().setWidth(95)
              ,
              errorBuilder: (c, o, s) {
                return const Icon(
                  Icons.error,
                  color: Colors.red,
                );
              }
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  void _goCategory(context,int index,String categroyId) async {

    //TODO await request('getCategory')
     MNet.getData(ApiService.homepage_url).then((val) {

      //var data = json.decode(val.toString());
      //CategoryModel category = CategoryModel.fromJson(data);
      //List   list = category.data;
       List   list = val;

      Provider.of<ChildCategory>(context, listen: false).changeCategory(categroyId,index);
      Provider.of<ChildCategory>(context, listen: false).getChildCategory( list[index].bxMallSubDto,categroyId);
      Provider.of<CurrentIndexProvide>(context, listen: false).changeIndex(1);

      // Provide.value<ChildCategory>(context).changeCategory(categroyId,index);
      // Provide.value<ChildCategory>(context).getChildCategory( list[index].bxMallSubDto,categroyId);
      // Provide.value<CurrentIndexProvide>(context).changeIndex(1);

    });
  }

  @override
  Widget build(BuildContext context) {

    int len = navigatorList?.length ?? 0;
    if(navigatorList != null && len > 10){
      navigatorList?.removeRange(10, len);
    }
    var tempIndex=-1;
    return Container(
       color:Colors.white,
      margin: EdgeInsets.only(top: 5.0),
      height: ScreenUtil().setHeight(320),
      padding:EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorList?.map((item){
          tempIndex++;
          return _gridViewItemUI(context, item,tempIndex);
          
        }).toList() ?? <Widget>[],
      ),
    );
  }
}

  

//广告图片
class AdBanner extends StatelessWidget {
  final String? advertesPicture;

  AdBanner({Key? key, this.advertesPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    debugPrint("1.7");

    return Container(
      margin: EdgeInsets.only(top:5.0),
      color:Colors.white,
      child: Image.network(advertesPicture?? '',
          errorBuilder: (c, o, s) {
            return const Icon(
              Icons.error,
              color: Colors.red,
            );
          }
    ),
    );
  }
}

class LeaderPhone extends StatelessWidget {
  final String? leaderImage; //店长图片
  final String? leaderPhone; //店长电话

  LeaderPhone({Key? key, this.leaderImage,this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    debugPrint("1.8");

    return Container(
      child: InkWell(
        onTap:_launchURL,
        child: Image.network(leaderImage??'',
            errorBuilder: (c, o, s) {
              return const Icon(
                Icons.error,
                color: Colors.red,
              );
            }
        ),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:'+leaderPhone!;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

//商品推荐
class Recommend extends StatelessWidget {
  final List?  recommendList;

  Recommend({Key? key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    debugPrint("1.9");

    return  Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            _titleWidget(),
            _recommedList(context)
          ],
        ),
      );
   
  }

//推荐商品标题
  Widget _titleWidget(){
     return Container(
       alignment: Alignment.centerLeft,
       padding: EdgeInsets.fromLTRB(10.0, 2.0, 0,5.0),
       decoration: BoxDecoration(
         color:Colors.white,
         border: Border(
           bottom: BorderSide(width:0.5,color:Colors.black12)
         )
       ),
       child:Text(
         '商品推荐',
         style:TextStyle(color:Colors.pink)
         )
     );
  }

  Widget _recommedList(BuildContext context){

      return  Container(
        height: ScreenUtil().setHeight(380),
       
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList?.length,
          itemBuilder: (context,index){
            return _item(index,context);
          },
        ),
      );
  }

  Widget _item(index,context){
    return InkWell(
      onTap: (){
         Application.router.navigateTo(context,"/detail?id=${recommendList?[index]['goodsId']}");
      },
      child: Container(
       
        width: ScreenUtil().setWidth(280),
        padding: EdgeInsets.all(8.0),
        decoration:BoxDecoration(
          color:Colors.white,
          border:Border(
            left: BorderSide(width:0.5,color:Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList?[index]['image']
                ,
                errorBuilder: (c, o, s) {
                  return const Icon(
                    Icons.error,
                    color: Colors.red,
                  );
                }
            ),
            Text('￥${recommendList?[index]['mallPrice']}'),
            Text(
              '￥${recommendList?[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color:Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }
}



//楼层标题
class FloorTitle extends StatelessWidget {
  final String? picture_address; // 图片地址
  FloorTitle({Key? key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    debugPrint("1.10");

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address!
          ,
          errorBuilder: (c, o, s) {
            return const Icon(
              Icons.error,
              color: Colors.red,
            );
          }
      ),
    );
  }
}

//楼层商品组件
class FloorContent extends StatelessWidget {
  final List? floorGoodsList;

  FloorContent({Key? key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    debugPrint("1.11");

    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context)
        ],
      ),
    );
  }

  Widget _firstRow(context){
    return Row(
      children: <Widget>[
        _goodsItem(context,floorGoodsList?[0]),
        Column(
          children: <Widget>[
           _goodsItem(context,floorGoodsList?[1]),
           _goodsItem(context,floorGoodsList?[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods(context){
    return Row(
      children: <Widget>[
       _goodsItem(context,floorGoodsList?[3]),
       _goodsItem(context,floorGoodsList?[4]),
      ],
    );
  }

  Widget _goodsItem(context,Map goods){

    return Container(
      width:ScreenUtil().setWidth(375),
      child: InkWell(
        onTap:(){
          Application.router.navigateTo(context, "/detail?id=${goods['goodsId']}");
        },
        child: Image.network(goods['small_pic'],
            errorBuilder: (c, o, s) {
              return const Icon(
                Icons.error,
                color: Colors.red,
              );
            }
        ),
      ),
    );
  }

}



  
