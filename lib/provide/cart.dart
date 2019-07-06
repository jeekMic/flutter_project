import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier{
  String cartString = "[]";
  save (goodId,goodsName,count,price) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString  = sp.getString("cartInfo");
    var temp = cartString==null?[]:json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int ival = 0;
    tempList.forEach((item){
        if(item['goodsId']==goodId){
          tempList[ival]["count"] = item['count']+1;
        }
        ival++; 
    });
    if(!isHave){
      tempList.add({
        'goodsId':goodId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
      });
    }
     cartString = json.encode(tempList).toString();
     print(cartString);
     notifyListeners();
  }


  remove() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("cartInfo");
    print("清空完成");
    notifyListeners();
  }
 
}