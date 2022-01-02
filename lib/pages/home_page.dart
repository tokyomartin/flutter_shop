import 'package:flutter/material.dart';
import 'package:flutter_shop/config/api_service.dart';
import 'package:flutter_shop/util/m_net.dart';
// import '../service/service_method.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

import 'category_list_page.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  int page_size = 4;
  int page = 1;
  // List<Map> hotGoodsList =[];
  Map hotGoodsList ={};

  Future _goodsListFuture;



  
  @override
  bool get wantKeepAlive =>true;

  @override
  void initState() {
    debugPrint("111test");
    super.initState();

    //TODO for test
    // _goodsListFuture = _getHotGoods(25, 8, 1);
     _goodsListFuture = _getHotGoodsList();

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
    var formData = {'lon':'115.02932','lat':'35.76189'};

    // Future<dynamic> futureEntry =  MNet.getData(ApiService.homepage_url);
    // futureEntry.then((dynamic result) {}
    // );

    Future _gerData() async {
      var response = MNet.getResponse(ApiService.homepage_url);
      return response;
    }

    return  Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      appBar: AppBar(title: Text('华人超市+'),),
      body:
       FutureBuilder(

         // homePageContext
       // future:request('homePageCategory',formData:formData),
       //  future: _gerData(),
       //  future: _getHotGoodsList(),
       //    future:   _getHotGoods(25, 8, 1),
           future :   _goodsListFuture,
        builder: (context,snapshot){

          debugPrint("------------homePageCategory");
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

                    debugPrint("HomePageData:" + myData.toString());

                   // _getHotGoods(25, 8, 1);
                   //  _getHotGoods(26, 8, 1);
                   //     var strData = '''
                   //  ''';
                   //
                   //     var data =json.decode(strData);
                    // debugPrint("1.3 加载首页数据");
                    //
                    // List<Map> swiperDataList = (data['data']['slides'] as List).cast(); // 顶部轮播组件数
                    // List<Map> navigatorList =(data['data']['category'] as List).cast(); //类别列表
                    // String advertesPicture = data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
                    // String  leaderImage= data['data']['shopInfo']['leaderImage'];  //店长图片
                    // String  leaderPhone = data['data']['shopInfo']['leaderPhone']; //店长电话
                    // List<Map> recommendList = (data['data']['recommend'] as List).cast(); // 商品推荐
                    // String floor1Title =data['data']['floor1Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
                    // String floor2Title =data['data']['floor2Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
                    // String floor3Title =data['data']['floor3Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
                    // List<Map> floor1 = (data['data']['floor1'] as List).cast(); //楼层1商品和图片
                    // List<Map> floor2 = (data['data']['floor2'] as List).cast(); //楼层1商品和图片
                    // List<Map> floor3 = (data['data']['floor3'] as List).cast(); //楼层1商品和图片

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

                            // AdBanner(advertesPicture:advertesPicture), //广告图片
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

                          //  _hotGoodsWidget("熟食（更多...）",23),
                            _hotGoodsWidget("肉类（更多...）",24),
                        //    _hotGoodsWidget("新品（更多...）",25),
                            _hotGoodsWidget("爆品（更多...）",26),
                            _hotGoodsWidget("瓜果蔬菜（更多...）",27),
                       //     _hotGoodsWidget("腐乳（更多...）",28),
                       //      _hotGoodsWidget("输入酒（更多...）",29),
                      //      _hotGoodsWidget("饮料（更多...）",30),
                     //       _hotGoodsWidget("腌制品(皮蛋酸菜类)（更多...）",31),
                     //       _hotGoodsWidget("干货（更多...）",32),
                            _hotGoodsWidget("面类（更多...）",33),
                     //      _hotGoodsWidget(" 点心（更多...）",34),
                            _hotGoodsWidget("零食（更多...）",35),
                            _hotGoodsWidget("海鲜（更多...）",36),
                      //      _hotGoodsWidget("食材（原材料）（更多...）",37),
                      //      _hotGoodsWidget("辣条（更多...）",38),
                            // _hotGoodsWidget("冻品（更多...）",39),
                            // _hotGoodsWidget("罐头（更多...）",40),
                            // _hotGoodsWidget("冲调类（更多...）",41),
                       //     _hotGoodsWidget("调料（更多...）",42),
                      //      _hotGoodsWidget("火锅（更多...）",43),

                          ],
                        ) ,

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

    _getHotGoodsList() async{

   //  await _getHotGoods(23, this.page_size, 1); //熟食
     await _getHotGoods(24, this.page_size, 1); //肉类
    // await _getHotGoods(25, this.page_size, 1);  //新品
     await _getHotGoods(26, this.page_size, 1);    //爆品
     await _getHotGoods(27, this.page_size, 1);    //瓜果蔬菜
  //   await _getHotGoods(28, this.page_size, 1);

     //输入酒
  //    await _getHotGoods(29, this.page_size, 1);
  //   await _getHotGoods(30, this.page_size, 1);   //饮料
   //  await _getHotGoods(31, this.page_size, 1);
    // await _getHotGoods(32, this.page_size, 1);
     await _getHotGoods(33, this.page_size, 1);  //面类
    // await _getHotGoods(34, this.page_size, 1);
     await _getHotGoods(35, this.page_size, 1); //零食
     await _getHotGoods(36, this.page_size, 1);  //海鲜
    // await _getHotGoods(37, this.page_size, 1);
   //  await _getHotGoods(38, this.page_size, 1);  //辣条
  //   await _getHotGoods(39, this.page_size, 1);
   //  await _getHotGoods(40, this.page_size, 1);
   //  await _getHotGoods(41, this.page_size, 1);
   //  await _getHotGoods(42, this.page_size, 1);   //调料
   //  await _getHotGoods(43, this.page_size, 1);   //火锅

     return true;

  }

  //火爆商品接口
   _getHotGoods(category_id, num, page) async{

    var formPage={'categoryId': category_id, 'num': num, 'page': page};

     // request('homePageBelowConten',formData:formPage)
     String strUrl = ApiService.mall_goods_top_url + 'category_id=${category_id}&num=${num}&page=${page}';


     var data = await MNet.getData(strUrl);

       //var data=json.decode(val.toString());
       debugPrint("首页HOT GOODS商品列表");
       debugPrint(data.toString());

       List<Map> newGoodsList = (data['data'] as List ).cast();
       hotGoodsList[category_id] = newGoodsList;


    // setState(() {
    //      //hotGoodsList[1] = newGoodsList;
    //      hotGoodsList[category_id] = newGoodsList;
    //      // hotGoodsList.addAll(newGoodsList);
    //      // page++;
    //    });

  }

  //火爆专区标题
  Widget hotTitle(title, category_id){

    return InkWell(
        onTap:(){
          debugPrint("首页 hotTitle----CategoryListPage");
          // Application.router.navigateTo(context,"/detail?id=${val['goodsId']}");
          // Application.router.navigateTo(context,"/detail?id=${val['id']}");
          Navigator.push(context,
              MaterialPageRoute(builder: (context){
                return CategoryListPage(category_id: category_id);

                // settings: RouteSettings(
                //   arguments: todos[index],
                // ),
          }
          )
          );

        },
        child:
        Container(
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
        )

    );

    // return Container(
    //   margin: EdgeInsets.only(top: 10.0),
    //   padding:EdgeInsets.all(5.0),
    //   alignment:Alignment.center,
    //   decoration: BoxDecoration(
    //       color: Colors.white,
    //       border:Border(
    //           bottom: BorderSide(width:0.5 ,color:Colors.black12)
    //       )
    //   ),
    //   //'火爆专区'
    //   child: Text(title),
    // );

  }

  getHotGoodsList(category_id){
    return hotGoodsList[category_id];
  }

  //火爆专区子项
  Widget _wrapList(category_id){

    List<Map> hotGoodsListItem = hotGoodsList[category_id];

    if(hotGoodsListItem!= null && hotGoodsListItem.length!=0){

      List<Widget> listWidget = hotGoodsListItem.map((val){
          
          return InkWell(
            onTap:(){

              // Application.router.navigateTo(context,"/detail?id=${val['goodsId']}");
              Application.router.navigateTo(context,"/detail?id=${val['id']}");
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
                  errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                    return Text('Your error widget...');
                    }
                  ),
                  // Image.network("http://29e5534ea20a8.cdn.sohucs.com/c_cut,x_178,y_20,w_1021,h_680,c_zoom,h_103/os/news/4b39a1b8656ef59d99a3a5d827fe5fd1.jpg" ,width: ScreenUtil().setWidth(375),),
                  Text(
                   // val['name'],
                    val['product_name'],
                    // "test_name1",
                    maxLines: 1,
                    overflow:TextOverflow.ellipsis ,
                    style: TextStyle(color:Colors.pink,fontSize: ScreenUtil().setSp(26)),
                  ),
                  Row(
                    children: <Widget>[
                     // Text('￥${val['mallPrice']}'),
                      Text('￥${val['general_price']}'),
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
      return Text(' ');
    }
  }

  //火爆专区组合
  Widget _hotGoodsWidget(title, category_id){

    return Container(
          
          child:Column(
            children: <Widget>[
              hotTitle(title, category_id),
               _wrapList(category_id),
            ],
          )   
    );
  }


}
// 首页轮播组件编写
class SwiperDiy extends StatelessWidget{

   

  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);

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
              
             
               Application.router.navigateTo(context,"/detail?id=${swiperDataList[index]['goodsId']}");

            },
            child:  Image.network("${swiperDataList[index]['image']}",
                errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                  return Text('Your error widget...');
                },
                fit:BoxFit.fill),
          );
         
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}


//首页导航组件
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({Key key, this.navigatorList}) : super(key: key);
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
              errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                return Text('Your error widget...');
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

    if(navigatorList.length>10){
      navigatorList.removeRange(10, navigatorList.length);
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
        children: navigatorList.map((item){
          tempIndex++;
          return _gridViewItemUI(context, item,tempIndex);
          
        }).toList(),
      ),
    );
  }
}

  

//广告图片
class AdBanner extends StatelessWidget {
  final String advertesPicture;

  AdBanner({Key key, this.advertesPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    debugPrint("1.7");

    return Container(
      margin: EdgeInsets.only(top:5.0),
      color:Colors.white,
      child: Image.network(advertesPicture,

          errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
    return Text('Your error widget...');
    }
    ),
    );
  }
}

class LeaderPhone extends StatelessWidget {
  final String leaderImage; //店长图片
  final String leaderPhone; //店长电话

  LeaderPhone({Key key, this.leaderImage,this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    debugPrint("1.8");

    return Container(
      child: InkWell(
        onTap:_launchURL,
        child: Image.network(leaderImage
            ,
            errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
              return Text('Your error widget...');
            }
        ),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:'+leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

//商品推荐
class Recommend extends StatelessWidget {
  final List  recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

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
          itemCount: recommendList.length,
          itemBuilder: (context,index){
            return _item(index,context);
          },
        ),
      );
  }

  Widget _item(index,context){
    return InkWell(
      onTap: (){
         Application.router.navigateTo(context,"/detail?id=${recommendList[index]['goodsId']}");
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
            Image.network(recommendList[index]['image']
                ,
                errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                  return Text('Your error widget...');
                }
            ),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
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
  final String picture_address; // 图片地址
  FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    debugPrint("1.10");

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address
          ,
          errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
            return Text('Your error widget...');
          }
      ),
    );
  }
}

//楼层商品组件
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent({Key key, this.floorGoodsList}) : super(key: key);

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
        _goodsItem(context,floorGoodsList[0]),
        Column(
          children: <Widget>[
           _goodsItem(context,floorGoodsList[1]),
           _goodsItem(context,floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods(context){
    return Row(
      children: <Widget>[
       _goodsItem(context,floorGoodsList[3]),
       _goodsItem(context,floorGoodsList[4]),
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
            errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
            return Text('Your error widget...');
            }
        ),
      ),
    );
  }

}



  
