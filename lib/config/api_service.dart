import 'dart:convert';



class ApiService {

  static const debug = true;

  //PRODUCTION

 // static const base_path = 'https://www.dg006.com/api/';
  //TEST
static const base_path = 'http://yueapps.com/api/';

  static const base_url = '${base_path}v1/';


 // static const base_url = 'https://192.168.3.12:443/api/';
 //  static const base_url = 'https://dg006.com/yaoqishan/api/';
  //https://dg006.com:443/api/get_video_info.json?videoId=30    OK
  //https://dg006.com/yaoqishan/api/video_list.json?mediaId=1
  //video_list.json?mediaId=1

  // http://yueapps.com/api/auth/login

  //用户登录
  static const login_url = '${base_path}auth/login';
  //google账户登录
  static const google_signup_url = '${base_path}auth/googleSignUp';

  static const user_signup_url = '${base_path}auth/signup';


  //TODO HOMEPAGE 暂时没使用
  static const homepage_url = '${base_url}categoryList';

  //CATEGORY PAGE 目录API
  static const category_url = '${base_url}categoryList';

  //http://127.0.0.1/api/v1/productList?category_id=25&num=5
  //TODO MALL Goods 获取商品分类的商品列表
  static const mall_goods_url = '${base_url}productList?category_id=25&num=5';

  //TODO 商品详细信息列表
  static const mall_good_detail_url = '${base_url}productDetail?product_id=';

  //TODO 商城首页热卖商品拉取
  static const mall_goods_top_url = '${base_url}productList?';

  // 'getMallGoods': serviceUrl+'wxmini/getMallGoods', //商品分类的商品列表
  // 'getGoodDetailById':serviceUrl+'wxmini/getGoodDetailById', //商品详细信息列表
  // 'homePageBelowConten': serviceUrl+'wxmini/homePageBelowConten', //商城首页热卖商品拉取


  // 添加商品到购物车
  static const String mall_add_cart_url = '${base_url}cart/addCartInfo';
  static const String mall_get_cart_info_url = '${base_url}getCartInfo';
  static const String mall_del_cart_info_url = '${base_url}deleteCartInfo';
  static const String mall_update_cart_info_url = '${base_url}cart/updateCartInfo';


  //TODO 获取用户地址列表
  static const user_delivery_addr_url = '${base_url}deliveryAddress';
  //TODO 提交用户地址
  static const String mall_delivery_addr_add_url = '${base_url}updateDeliveryAddress';
  //TODO 设置默认的地址
  static const String mall_delivery_addr_set_default_url = '${base_url}defaultDeliveryAddress';
  //TODO 获取用户默认的地址
  static const String mall_delivery_addr_get_default_url = '${base_url}getDefaultDeliveryAddress';
  //TODO 提交订单
  static const String cart_order_url = '${base_url}order/cartOrder';

  //TODO 城市列表
  static const mall_province_list_url = '${base_url}province/getList';


///*****  通过地理位置获取附近商家列表  ***/
  static const shop_list_by_geohash_url = '${base_url}location/getList';

  //获取播放列表video_list.json?mediaId=1&pageNum=1&pageSize=10
  static const feed_url = '${base_url}video_list.json?mediaId=1&pageNum=';




  //获取单个媒体文件
  //static const feed_url = '${base_url}get_video_info.json?videoId=30';
  // static const feed_url = '${base_url}v2/feed?num=1';

  //获取播放列表video_list.json?mediaId=1&pageNum=1&pageSize=10



  //获取播放列表tv_list.json?mediaId=1&country=CN      后面参数暂时没有，不需要 &pageNum=1&pageSize=10
  static const country_tv_list_url = '${base_url}tv_list.json?mediaId=1&country=';

  //获取播放列表get_country_list.json
  static const country_list_url = '${base_url}get_country_list.json?pageNum=';

  //获取省列表
  static const province_list_url = '${base_url}province/province_list.json';

  //获取播放列表tv_list.json?mediaId=1&province=北京市      后面参数暂时没有，不需要 &pageNum=1&pageSize=10
  static const province_tv_list_url = '${base_url}province_tv_list.json?mediaId=1&province=';


  //获取最新的版本号
  static const version_url = '${base_url}version/versionInfo.json';
  //DEMO 测试版本
  // static const version_url = 'https://gitee.com/xuexiangjys/XUpdate/raw/master/jsonapi/update_test.json';


  static const follow_url = '${base_url}v4/tabs/follow';

  static const community_url = '${base_url}v7/community/tab/rec';

  static const rank_url = '${base_url}v4/rankList';

  static const video_category_url = '${base_url}v4/categories';

  static const video_related_url = '${base_url}v4/video/related?id=';

  static const keyword_url = '${base_url}v3/queries/hot';

  static const topics_url = '${base_url}v3/specialTopics';

  static const topics_detail_url = '${base_url}v3/lightTopics/internal/';

  static const news_url =
      '${base_url}v7/information/list?vc=6030000&deviceModel=';

  static const search_url = "${base_url}v1/search?query=";

  static const category_video_url = '${base_url}v4/categories/videoList?';



}
