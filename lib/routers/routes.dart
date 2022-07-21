import 'package:flutter/material.dart';
import './router_handler.dart';
import 'package:fluro/fluro.dart';

class Routes{
  static String root='/';
  static String detailsPage = '/detail';
  static String productListPage = '/productlist';


  static void configureRoutes(FluroRouter  router){
    router.notFoundHandler= new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('ERROR====>ROUTE WAS NOT FONUND!!!');
      }
    );

    router.define(detailsPage,handler:detailsHandler);
    router.define(productListPage,handler:detailsHandler);

  }

}