import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import 'package:path_provider/path_provider.dart';
//home page data access interface
Future 
getHomePageContent() async{
  try{
  Response response;
  Dio dio = new Dio();
  dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
  var formData ={'lon':'115.12932', 'lat':'35.541'};
  response = await dio.post(servicePath["homePageContent"],data: formData);
  //if the response code equal 200 so the require is success
  if(response.statusCode==200){
    return response.data;
  }else{
    return "simulated data";
  }
  }catch(e){
      return "simulated data";
  }

}