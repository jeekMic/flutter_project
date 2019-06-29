import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';
class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController textEditingController = new TextEditingController();
  String showText = "正在获取数据";
  @override
  void initState() {
    // getHomePageContent().then((val){
    //       showText = val;
    // });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
        
        children: <Widget>[
          RaisedButton(
            child: Text("鐐瑰嚮鏌ヨ�㈡暟鎹�"),
            padding: EdgeInsets.only(top: 100),
            onPressed: (){
              //  _require();
               textEditingController.text = showText;
            },
          ),
        TextField(
        maxLines: 15,
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: "璇疯緭鍏ヤ俊鎭�"
            
        ),
      ),
        ],
    );
  }
  void _require(){
  getHttpData().then((vale){
    setState(() {
     showText = vale;
    });
    print(vale);
      });
    }
Future  getHttpData() async{
  Dio dio = new Dio();
  var formData ={'lon':'115.12932', 'lat':'35.541'};
  Response response = await dio.post("http://v.jspang.com:8088/baixing/wxmini/homePageContent",data: formData);
  print("hb====${response.data}");
  return response.data;
    }
}


