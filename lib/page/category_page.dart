import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';
class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController textEditingController = new TextEditingController();
  String showText = "收到数据信息";
  @override
  void initState() {
    getHomePageContent().then((val){
          showText = val;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
        
        children: <Widget>[
          RaisedButton(
            child: Text("点击查询数据"),
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
            hintText: "请输入信息"
            
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


