import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../model/category.dart';
import '../model/categoryGoodsList.dart';

// import 'package:provide/provide.dart';

import '../provide/child_category.dart';
import '../provide/category_goods_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../routers/application.dart';

import 'package:provider/provider.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // CategoryBigListModel listCategory = CategoryBigListModel([]);

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('商品分类'),
    ),
    body: Container(
      child: Row(
        children: <Widget>[
          LeftCategoryNav(),
          Column(
            children: <Widget>[
              RightCategoryNav(),
              CategoryGoodsList()
            ],
          )
        ],
      ),
    ),
  );
}
}

//左侧导航菜单
class LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0; //索引

  @override
  void initState() {
    _getCategory();
    
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<ChildCategory>(
      //Provide<ChildCategory>
    
      builder: (context, ChildCategory val, child ){


         _getGoodList(context);
         listIndex=val.categoryIndex;
          
        return Container(
            width: ScreenUtil().setWidth(180),
            decoration: BoxDecoration(
                border: Border(right: BorderSide(width: 1, color: Colors.black12))),
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return _leftInkWel(index);
              },
            ),
          );
      },
    ); 
  }

  Widget _leftInkWel(int index) {
    bool isClick=false;
    isClick=(index==listIndex)?true:false;

    return InkWell(
      onTap: () {
       
         
         var childList = list[index].bxMallSubDto;
         var categoryId= list[index].mallCategoryId;

         Provider.of<ChildCategory>(context, listen: false).changeCategory(categoryId,index);
         Provider.of<ChildCategory>(context, listen: false).getChildCategory(childList,categoryId);

         // Provide.value<ChildCategory>(context).changeCategory(categoryId,index);
         // Provide.value<ChildCategory>(context).getChildCategory(childList,categoryId);

          _getGoodList(context,categoryId:categoryId );
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color: isClick?Color.fromRGBO(236, 238, 239, 1.0):Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  //得到后台大类数据
  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());

      CategoryModel category = CategoryModel.fromJson(data);

      setState(() {
        list = category.data;
      });

      Provider.of<ChildCategory>(context, listen: false).getChildCategory( list[0].bxMallSubDto,'4');

       // Provide.value<ChildCategory>(context).getChildCategory( list[0].bxMallSubDto,'4');

      //print(list[0].bxMallSubDto);

      //list[0].bxMallSubDto.forEach((item) => print(item.mallSubName));
    });
  }
  //得到商品列表数据
   void _getGoodList(context,{String categoryId }) {


  
    var data={
      'categoryId': categoryId==null?Provider.of<ChildCategory>(context, listen: false).categoryId:categoryId,
      'categorySubId': Provider.of<ChildCategory>(context, listen: false).subId,
      'page':1
    };


    
    request('getMallGoods',formData:data ).then((val){
        var  data = json.decode(val.toString());
        CategoryGoodsListModel goodsList=  CategoryGoodsListModel.fromJson(data);
        // Provide.value<CategoryGoodsList>(context).getGoodsList(goodsList.data);

        Provider.of<CategoryGoodsListProvide>(context, listen: false).getGoodsList(goodsList.data);

        // Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
       
    });
  }

}

//右侧小类类别

class RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

 

  
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      // child: Text('${childCategory.childCategoryList.length}'),
    
      child: Consumer<ChildCategory>(
        builder: (context,ChildCategory childCategory, child){
          return Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(570),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 1,color: Colors.black12)
              )
            ),
            child:ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context,index){

                return _rightInkWell(index,childCategory.childCategoryList[index]);
              },
            )
          );
        },
      )
    );
  }

  Widget _rightInkWell(int index,BxMallSubDto item){
    bool isCheck = false;
    isCheck =(index== Provider.of<ChildCategory>(context, listen: false).childIndex)?true:false;
    
    return InkWell(
      onTap: (){
        print (2222222222);
        Provider.of<ChildCategory>(context, listen: false).changeChildIndex(index,item.mallSubId);
         _getGoodList(context,item.mallSubId);
      },
      child: Container(
        padding:EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
        
        child: Text(
          item.mallSubName,
          
          style: TextStyle(
            fontSize:ScreenUtil().setSp(28),
            color:isCheck?Colors.pink:Colors.black ),
        ),
      ),
    );
  }


   //得到商品列表数据
   void _getGoodList(context,String categorySubId) {
     
    var data={
      'categoryId': Provider.of<ChildCategory>(context, listen: false).categoryId,
      'categorySubId':categorySubId,
      'page':1
    };
    
    request('getMallGoods',formData:data ).then((val){
        var  data = json.decode(val.toString());
        CategoryGoodsListModel goodsList=  CategoryGoodsListModel.fromJson(data);
        // Provide.value<CategoryGoodsList>(context).getGoodsList(goodsList.data);
        if(goodsList.data==null){
          Provider.of<CategoryGoodsListProvide>(context, listen: false).getGoodsList([]);

        }else{
          Provider.of<CategoryGoodsListProvide>(context, listen: false).getGoodsList(goodsList.data);
          
        }
    });
  }



}


//商品列表，可以上拉加载

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  // GlobalKey<EasyRefreshState> _easyRefreshKey =new GlobalKey<EasyRefreshState>();
  // GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  GlobalKey _footerKey = GlobalKey();

  EasyRefreshController _controller = EasyRefreshController();

  var scrollController=new ScrollController();
  

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryGoodsListProvide>(

        builder: (context, CategoryGoodsListProvide data, child){
          try{
            if( Provider.of<ChildCategory>(context, listen: false).page==1){
              scrollController.jumpTo(0.0);
            }
          }catch(e){
            print('进入页面第一次初始化：${e}');
          }
                    
          if(data.goodsList.length>0){
             return Expanded(
                child:Container(
                  width: ScreenUtil().setWidth(570) ,
                  child:EasyRefresh(
                    key:_footerKey,
                    controller: _controller,
                    firstRefresh: true,

                    // refreshFooter: ClassicsFooter(
                    //   key:_footerKey,
                    //   bgColor:Colors.white,
                    //   textColor:Colors.pink,
                    //   moreInfoColor: Colors.pink,
                    //   showMore:true,
                    //   noMoreText:Provide.value<ChildCategory>(context).noMoreText,
                    //   moreInfo:'加载中',
                    //   loadReadyText:'上拉加载'
                    // ),

                    child:ListView.builder(
                      controller: scrollController,
                      itemCount: data.goodsList.length,
                      itemBuilder: (context,index){
                        return _ListWidget(data.goodsList,index);
                      },
                    ) ,


                    //loadMore
                    onRefresh: ()async{
                      if(Provider.of<ChildCategory>(context, listen: false).noMoreText=='没有更多了'){
                         Fluttertoast.showToast(
                            msg: "已经到底了",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.pink,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }else{
                        
                         _getMoreList();
                      }
                     
                    },
                  )
                  
                ) ,
              ); 
          }else{
            return  Text('暂时没有数据');
          }
         

       },

    );
  }

  //上拉加载更多的方法
  void _getMoreList(){

    Provider.of<ChildCategory>(context, listen: false).addPage();
     var data={
      'categoryId': Provider.of<ChildCategory>(context, listen: false) .categoryId,
      'categorySubId': Provider.of<ChildCategory>(context, listen: false) .subId,
      'page': Provider.of<ChildCategory>(context, listen: false) .page
    };
    
    request('getMallGoods',formData:data ).then((val){
        var  data = json.decode(val.toString());
        CategoryGoodsListModel goodsList=  CategoryGoodsListModel.fromJson(data);
       
        if(goodsList.data==null){
          Provider.of<ChildCategory>(context, listen: false).changeNoMore('没有更多了');
        }else{

          Provider.of<CategoryGoodsListProvide>(context, listen: false).addGoodsList(goodsList.data);
          
        }
    });


  }

 

  Widget _ListWidget(List newList,int index){

  

    return InkWell(
      onTap: (){
        Application.router.navigateTo(context,"/detail?id=${newList[index].goodsId}");
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0,color: Colors.black12)
          )
        ),
        
        child: Row(
          children: <Widget>[
            _goodsImage(newList,index)
           ,
            Column(
              children: <Widget>[
                _goodsName(newList,index),
                _goodsPrice(newList,index)
              ],
            )
          ],
        ),
      )
    );

  }
  //商品图片
  Widget _goodsImage(List newList,int index){

    return  Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );

  }
  //商品名称方法
  Widget _goodsName(List newList,int index){
    return Container( 
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      );
  }
  //商品价格方法
  Widget _goodsPrice(List newList,int index){
    return  Container( 
      margin: EdgeInsets.only(top:20.0),
      width: ScreenUtil().setWidth(370),
      child:Row(
        children: <Widget>[
            Text(
              '价格:￥${newList[index].presentPrice}',
              style: TextStyle(color:Colors.pink,fontSize:ScreenUtil().setSp(30)),
              ),
            Text(
              
              '￥${newList[index].oriPrice}',
              style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough
              ),
            )
        ]
      )
    );
  }


}

