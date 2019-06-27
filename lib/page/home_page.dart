import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shop/config/httpHeader.dart';
import 'package:flutter_shop/utils/imagesUtils.dart';
import '../service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = "正在读取数据";
  List<Map> swiper;
  List<Map> bavigatorList;
  @override
  void initState() {
    getHomePageContent().then((val){
      setState(() {
       homePageContent = val.toString(); 
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(title: Text("百姓生活家"),),
         body: FutureBuilder(
            future: getHomePageContent(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                var data = json.decode(snapshot.data.toString());
                swiper = (data['data']['slides'] as List).cast();
                bavigatorList = (data['data']['category'] as List).cast();
                String adPicture = (data["data"]["advertesPicture"]["PICTURE_ADDRESS"]);
                String leaderImage = data['data']['shopInfo']['leaderImage'];
                String leaderPhone = data['data']['shopInfo']['leaderPhone'];
                // List<Map> swiper = swiperimage;
                return Column(
                  children: <Widget>[
                    SwiperDiy(swiperDataList: swiper),
                    TopNavigator(bavigatorList:bavigatorList),
                    AdBanner(adPicture: adPicture,),
                    LeaderPhone(leaderImage: leaderImage,leaderPhone: leaderPhone,)
                  ],
                );
              }else{
                return Center(
                  child: Text("加载数据"),
                );
              }
            },
         ),
       ),
    );
  }
}

//轮播图组件
class SwiperDiy extends StatelessWidget{
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}): super(key: key);
  
@override
Widget build(BuildContext context) {
  print("设备的像素密度: ${ScreenUtil.pixelRatio}");
  print("设备的像素密度: ${ScreenUtil.screenWidth}");
  print("设备的像素密度: ${ScreenUtil.screenHeight}");

  return Container(
      height: ScreenUtil().setHeight(333),
      width:ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return new Image.network("${swiperDataList[index]['image']}",fit: BoxFit.fill);
        },
        itemCount: 3,
        pagination: new SwiperPagination(),
        controller: new SwiperController(),
        autoplay: true,
      ),
  );
}


}

class TopNavigator extends StatelessWidget {
  final List bavigatorList;
  const TopNavigator({Key key,this.bavigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context,item){
      return InkWell(
        child: Column(
          children: <Widget>[
            Image.network(item["image"], width:ScreenUtil().setWidth(95)),
            Text(item['mallCategoryName'])
          ],
        ),
        onTap: (){
          print("\n点击了导航"+item.toString());
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    if(this.bavigatorList.length>10){
      this.bavigatorList.removeRange(10,this.bavigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: bavigatorList.map((item){
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}


class AdBanner extends StatelessWidget {
  final String adPicture;
  AdBanner({Key key,this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;//电话
  LeaderPhone({Key key,String this.leaderImage,String this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
      onTap: (){},
      child: Image.network(leaderImage),
      ),
    );
  }

  void _lanucher() async{
    String url = "tel:"+leaderPhone;
    if(await canLaunch(url)){
        await launch(url);
    }else{
      throw "url不能进行访问,异常";
    }
}

// class HomePage extends StatefulWidget {
//   HomePage({Key key}) : super(key: key);

//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String showText = "还没有内容";
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        child: Scaffold(
//          appBar: AppBar(title: Text("请求远程数据"),),
//          body: SingleChildScrollView(
//            child: Column(
//              children: <Widget>[
//                RaisedButton(
//                  child: Text("请求数据"),
//                  onPressed: (){
//                    _jike();
//                  },
//                ),
//                Text(showText),
//              ],
//            ),
//          ),
//        ),
//     );
//   }
//   void _jike(){
//     print("开始请求数据");
//     getHttp().then((val){
//         setState(() {
//           // showText = val["data"]["name"];
//           showText = val.toString();
//         });
//     });
//   }
//   Future getHttp() async{
//     try{
//         Response response;
//         Dio dio = new Dio();
//         dio.options.headers = httpHeader;
//         response = await dio.get("https://time.geekbang.org/serv/v1/column/newAll");
//         print(response);
//         return response.data;
//     }catch(e){
//       return print(e);
//     }
//   }
}