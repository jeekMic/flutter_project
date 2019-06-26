import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import 'package:path_provider/path_provider.dart';
//获取首页主题的内容
Future getHomePageContent() async{
  try{
  Response response;
  Dio dio = new Dio();
  dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
  var formData ={'lon':'115.12932', 'lat':'35.541'};
  response = await dio.post(servicePath["homePageContent"],data: formData);
  print("=============>1");
  if(response.statusCode==200){
    print("=============>2");

    print(response.data);

    return response.data;
  }else{
    return "moni数据";
  }
  }catch(e){
      return "moni数据";
  }

}