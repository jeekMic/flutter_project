import 'package:flutter/material.dart';
import '../model/detail.dart';
import '../service/service_method.dart';
import 'dart:convert';
class DetailsInfoProvider with ChangeNotifier{
    bool isLeft = true;
    bool isRight = true;
    //tabbar的切换方法
    changeLeftAndRight(String changeState){
      if(changeState=="left"){
        isLeft = true;
        isRight  =false;
      }else{
        isLeft = false;
        isRight  =true; 
      }
    }
    DeatilModel goods_info = null;
    //从后台设置数据
    setGoodInfo(String id){
      var formData = {"goodId":id};
      request("getGoodDetailById",formData: formData).then((val){
        var responseData = json.decode(val.toString());
        print("DetailsInfoProvider===>.....");
        print("responseData");
        goods_info = DeatilModel.fromJson(responseData);
        notifyListeners();
      });
    }
}