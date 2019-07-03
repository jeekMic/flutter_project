import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../page/detail_page.dart';

Handler detailshandler = Handler(
  handlerFunc: (BuildContext context,Map<String, List<String>> param){
    String goodsId = param["id"].first;
    print("index> Detail goodsId id ${goodsId}");
    return DetailsPage(goodsId:goodsId);
  }
);
