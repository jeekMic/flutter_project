import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import 'package:path_provider/path_provider.dart';


 Future request(url,{formData}) async{
  try{
      Response response;
      Dio dio = new Dio();
      dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
      if(formData==null){
        response =await dio.post(servicePath[url]);
      }else{
        response = await dio.post(servicePath[url],data:formData);
      }
  
      if(response.statusCode==200){
          print("数据获取成功==");
        return response.data;
      }else{
          print("数据获取失败===========");
        return "moni";
      }
  }catch(e){

  }
}