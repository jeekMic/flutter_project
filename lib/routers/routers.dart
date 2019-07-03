import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes{
  static String root = "/";
  static String detailsPage = "/detail";
  static void configureRouter(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print("已经进入");
      }
    );
    router.define(detailsPage,handler:detailshandler);


  }

}