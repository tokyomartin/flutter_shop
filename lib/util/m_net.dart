import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MNet {
   static final debug = true;
   static final Dio dio = Dio();

   static Future <T>  getData<T>(String url, {
     String method="get",
     Map<String, dynamic>? params
} )  async{

     if(debug) debugPrint("load api  $url");

     final options = Options(method: method);

     try{
          Response response = await dio.get(url, queryParameters: params, options: options);
          return response.data;  // 这个返回的是Map 不是Json数据，Dio已经处理过转成了Map
     }on DioError catch(e){

       debugPrint(e.message);
         return Future.error(e);
     }
  }

  static dynamic getResponse(String url, {
    String method="get",
    Map<String, dynamic>? params
  } ) async{

    if(debug) debugPrint("load api  $url");
    final options = Options(method: method);
      return  await dio.get(url, queryParameters: params, options: options);

  }


   static Future <T>  getPostData<T>(String url, [Map<String, dynamic>? params] )  async{

     if(debug) debugPrint("load api  $url");

     final options = Options(method: "post");

     try{
       Response response = await dio.post(url, data: params, options: options);
       return response.data;  // 这个返回的是Map 不是Json数据，Dio已经处理过转成了Map
     }on DioError catch(e){

       debugPrint(e.message);
       return Future.error(e);
     }
   }

   static Future <T>  oauthPost<T>(String url, [Map<String, dynamic>? params] )  async{

     if(debug) debugPrint("load api  $url");

     final options = Options(method: "post");

     SharedPreferences prefs = await SharedPreferences.getInstance();

     var access_token = "";
     if(prefs.getString("access_token") != null) {
       // data['member_id'] = int.parse(sharedPreferences.getString("member_id"));
       access_token =  prefs.getString("access_token") ?? '';
     }else{
       // 没有获取token
     }

     //TODO TEST
     // access_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNzc4OGY1ODFkMjAwZWExNGEwZmE3MzE1YzUxYjlmNWRjMjg2MzViN2FmNTIzOWE4ZmQyNDBjN2U0OWUwODA2OTQzYjE3ZmM3YmI4NGU5NTUiLCJpYXQiOjE2MzMyMzg1MTUsIm5iZiI6MTYzMzIzODUxNSwiZXhwIjoxNjY0Nzc0NTE1LCJzdWIiOiIxMDAwNzAwNyIsInNjb3BlcyI6W119.KQnbf1egv8jqydWZbxlUrbM0-dVeup8nnLYWJxb0Hj915MUh0uA5OeedCceNJojqm89lnXCbIYd6H2EaFmtJP2OuQbmOQDe2RU6LR9ptCBvUIbo69V70JzBFJYVL2pn7WwHI7FT0Cu1BENPcNOS5kzAn2NLYA-ay-9Pz7R8PS0VHEIObIKqk7Wn6gOccFtpwOjYrezlmq9enkcW7_cIsOjJAbAaiijBsEWzkwMje8VlJMdePuLHpfSH02xRD8hKSek6IxysauJWyZw4WrasfjVePlU-5vVeY19C_o8d1MqeC7q5QLLMewLLU_qJf7l0soYQnkmOYx_2ytUSal82JYONMm2oKuPttA5apWtJojb0vlHbGTD9QKF4PldtXVu-RNolfAB3_1shYNMTvZ44kmkflvMj9L8TQ22CHpKNoKU1_9_u2edJJ9YDd5WtAbBqFtyIP5hpbOcV6dEK1Te_dtZQzumUBb7A1thN10bg4KjhwkLzHaz_fi80UDad2fjAX8rni5rVqBTX4r-RwAajd_BuP44CuiEINYb6k8s7jb5ATSDzigSshtvA2GJJK_RuXRPpP4Li6aZowLNQ5tiGUD-qWbMdDLwBb_okB8cF9vNiwPt28RGCd438TSt7bK-5CpxzO2el7r39nWAb0zS25dMQcgFuvrPfqsR8894pnLO8";


     dio.options.headers['content-Type'] = 'application/json';
     dio.options.headers["authorization"]="Bearer ${access_token}";

     try{
       Response response = await dio.post(url, data: params, options: options);
       return response.data;  // 这个返回的是Map 不是Json数据，Dio已经处理过转成了Map
     }on DioError catch(e){

       debugPrint(e.message);
       return Future.error(e);
     }
   }

   static Future <T>  oauthGet<T>(String url, [Map<String, dynamic>? params] )  async{

     if(debug) debugPrint("load api  $url");

     final options = Options(method: "get");

     SharedPreferences prefs = await SharedPreferences.getInstance();

     var access_token = "";
     if(prefs.getString("access_token") != null) {
       // data['member_id'] = int.parse(sharedPreferences.getString("member_id"));
       access_token =  prefs.getString("access_token") ?? '';
     }else{
       // 没有获取token
     }
     // debugPrint("----------access_token1-----------");
     // debugPrint(access_token);


    //  //TODO TEST
    //  var access_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZDc5MTg3Zjg3OGUwZGFkNzdjMDZiOGRjY2E0ODhmODdjZDI1MjIyM2Y2YzM4YWQ2Mjk5NmE0M2M4OWEzMzljNmM2OWIyYTc3MDgzYjQ5OTEiLCJpYXQiOjE2MzMxMTYyOTcsIm5iZiI6MTYzMzExNjI5NywiZXhwIjoxNjY0NjUyMjk3LCJzdWIiOiIxMDAwNzAwNyIsInNjb3BlcyI6W119.YT2ytbU0qqHesYifhJQ9YP_8DXSevG-_tgsttSNSNmdMivycbEorQkh6N7pC-s4pSm_cHm73VnDPmW65DDg12J9hNkHN209AKMLrOXffpJsH2C0nKXuRe68-sGMV5wqqbPNbhf5RDCz73XvqnuBTq8U0QLNBmRoXDXmIupM8j7oip_qDJcqu1JlZhkogC_lZCPrjdnhgm06KPu9aPLZC3cOt0Eapl7Hbz4hC8Z_F8fAwe5oCwspr1AZGG5VqEvfDJD34BlCQh79KGind9mGxL55EdeeEq4hs8ezfMcL3ChBXG7smJWXNpe7XPm_0Qo1TIE_gbnXsexz7XWHVWDwO_Kb5N_zdQRYqMbqBW2pU_eHr3XTiD5HWjaabt0NjoExtk0XzVoNZH6Svd_AysfgqiBPMLV52bptr7ajOjoaIt1GLY9KbqytaeXHd2ukQ_prqk2J5JVha_Vmf_OW8qzKzDPEaKVXjUL73ySJvFBy_iDRKq2hvyQ1ouzuIA0bcwjR7M5svoHbQoU7KKRsEhjFySs-Q63p_KcuXD4KmPuPHsNkW6fLeAhW0ol6s4trntnT1Koo1M6MWcZKYhPxbsGajfJFZvyVvLgbFEP9jhED5wUjGI8pLTUL1A-iGdTERGj4uxVyO7QPyoDl9KtsOqqLa8T-46RTluduv8yCXRlnsHoU";


     dio.options.headers['content-Type'] = 'application/json';
     // dio.options.headers['Content-Type'] = ContentType("application","x-www-form-urlencoded") as String;
     //dio.options.headers['Content-Type'] = ContentType("application","application/json");
     dio.options.headers["authorization"]="Bearer ${access_token}";

     // headers: {
     //   'Content-Type': 'application/json',
     // 'Accept': 'application/json',
     // 'Authorization': 'Bearer $token',
     // }

     try{
       Response response = await dio.get(url, queryParameters: params, options: options);
       return response.data;  // 这个返回的是Map 不是Json数据，Dio已经处理过转成了Map
     }on DioError catch(e){

       debugPrint(e.message);
       return Future.error(e);
     }
   }




}