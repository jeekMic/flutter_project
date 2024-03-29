import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shop/config/httpHeader.dart';
import 'package:flutter_shop/utils/imagesUtils.dart';
import '../service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../routers/application.dart';
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  int page = 1;
  List<Map> hotGoodsList = [];
  GlobalKey<RefreshFooterState> _footerkey = new GlobalKey<RefreshFooterState>();
@override
bool get wantKeepAlive => true;

  String homePageContent = "正在读取数据";
  List<Map> swiper;
  List<Map> bavigatorList;
  @override
  void initState() {
    super.initState();
    print("======初始化");
    _getHotGoods();
    print("======初始化");
  }

  @override
  Widget build(BuildContext context) {
    var formData = {'lon':'115.12932', 'lat':'35.541'};
    return Container(
       child: Scaffold(
         appBar: AppBar(title: Text("百姓生活家"),),
         body: FutureBuilder(
            future: request("homePageContent",formData:formData),
            builder: (context,snapshot){
              if(snapshot.hasData){
                var data = json.decode(snapshot.data.toString());
                print("is null=========");
                print(data);
                swiper = (data['data']['slides'] as List).cast();
                bavigatorList = (data['data']['category'] as List).cast();
                String adPicture = (data["data"]["advertesPicture"]["PICTURE_ADDRESS"]);
                String leaderImage = data['data']['shopInfo']['leaderImage'];
                String leaderPhone = data['data']['shopInfo']['leaderPhone'];
                List<Map> recommendList = (data['data']['recommend'] as List).cast();
                String floortitle = data['data']['floor1Pic']['PICTURE_ADDRESS'];
                String floortitle2 = data['data']['floor2Pic']['PICTURE_ADDRESS'];
                String floortitle3 = data['data']['floor3Pic']['PICTURE_ADDRESS'];
                List<Map> floor1 = (data['data']['floor1'] as List).cast();
                List<Map> floor3 = (data['data']['floor3'] as List).cast();
                List<Map> floor2 = (data['data']['floor2'] as List).cast();
                // List<Map> swiper = swiperimage;
                //use SingleChildScrollView() can avoid the content overflow screen
                return EasyRefresh(
                  // refreshHeader: ClassicsFooter(

                  // ),
                  refreshFooter: ClassicsFooter(
                    key: _footerkey,
                      bgColor: Colors.white,
                      textColor: Colors.pink,
                      moreInfoColor: Colors.pink,
                      showMore: true,
                      noMoreText: '',
                      moreInfo: "加载中...",
                      loadReadyText: "上拉加载",
                  ),
                  child: ListView(
                    children: <Widget>[
                    SwiperDiy(swiperDataList: swiper),
                    TopNavigator(bavigatorList:bavigatorList),
                    AdBanner(adPicture: adPicture,),
                    LeaderPhone(leaderImage: leaderImage,leaderPhone: leaderPhone,),
                    Recommend(recommendList: recommendList,),
                    FloorTitle(path:floortitle),
                    FloorContent(floorGoodslist: floor1,),
                    FloorTitle(path:floortitle2),
                    FloorContent(floorGoodslist: floor2,),
                    FloorTitle(path:floortitle3),
                    FloorContent(floorGoodslist: floor3,),      
                    _hotGoods(),
                    // HotGoods(),
                  ],
                  ),
                  loadMore: () async{
                    print("加载更多");
                    var formData = {"page":page};
                    await request("homePaeBelowContent",formData:formData).then((val){
                      var data = json.decode(val.toString());
                      List<Map> newGoodsList = (data['data'] as List).cast();
                      setState(() {
                       hotGoodsList.addAll(newGoodsList);
                       page++; 
                      });
                    });
                  },
                  onRefresh:()async{

                  },
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
  void _getHotGoods() async{
    var formData = {"page":page};
    // request("homePaeBelowContent",formData:formData).then((val){
    //   print("------------------------");
    //   print(val);
    // });


    await request("homePaeBelowContent",formData:formData).then((val){
      print("_getHotGoods======${val}");
      var data = json.decode(val.toString());
      print("_getHotGoods======${data}");
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
       hotGoodsList.addAll(newGoodsList);
       print(newGoodsList);
       print("----------------${hotGoodsList.length}");
       page++;
      });
    });
  }
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text("火爆专区"),
  );

  Widget _wrapList(){
    print("========> ${hotGoodsList.length}");
    if(hotGoodsList.length!=0){
      List<Widget> list = hotGoodsList.map((val){
          return InkWell(
            onTap: (){
              Application.router.navigateTo(context, "/detail?id=${val['goodsId']}");
            },
            child: Container(
              width: ScreenUtil().setWidth(372),
              color: Colors.white,
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(bottom: 3.0),
              child: Column(
                children: <Widget>[
                  Image.network(val['image'],width:ScreenUtil().setWidth(370),),
                  Text(
                    val['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                  ),
                  Column(
                    children: <Widget>[
                      Text('￥${val['mallPrice']}'),
                      Text('￥${val['price']}',style: TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough),)
                    ],
                  ),
                ],
              ),

            ),
          );
      }).toList();
      return Wrap(
        spacing: 2,
        children: list,
      );
    }else{
      print("数据为空");
      return Text("");
    }
  }

  Widget _hotGoods(){

    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
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
          return InkWell(
            onTap: (){
              Application.router.navigateTo(context, "/detail?id=${swiperDataList[index]['goodsId']}");
            },
            child: new Image.network("${swiperDataList[index]['image']}",fit: BoxFit.fill),
          ); 
          
          
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
        physics: NeverScrollableScrollPhysics(),
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
      onTap: (){
        _lanucher();
      },
      child: Image.network(leaderImage),
      ),
    );
  }

  void _lanucher() async{
    String url = "tel:"+leaderPhone;
    String url2 = "http://www.baidu.com";
    if(await canLaunch(url)){
        await launch(url);
    }else{
      throw "url不能进行访问,异常";
    }
}


}
// commodity recommendation page
class Recommend extends StatelessWidget {
  //the data list from json
  final List recommendList;
  Recommend({Key key,this.recommendList}) : super(key: key);
  //title
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(width:0.5,color: Colors.black12)
        ),
      ),
      child: Text("商品推荐",style: TextStyle(color: Colors.pink),),
    );
  }
  //recommodity single item
  Widget _item(context,index){
    return InkWell(
      onTap: (){
        Application.router.navigateTo(context, '/detail?id=${recommendList[index]['goodsId']}');
      },
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding:EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5,color: Colors.black12),
          ),
  
            ),
        child: SingleChildScrollView(
          child: Column(
          children: <Widget>[
            Image.network(recommendList[index]["image"]),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text('￥${recommendList[index]['price']}',
                style: TextStyle(
                  //删除线
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey
                ),
              ),
          ],
        ),
        )
      
      ),
    );
  }
 // row list
 Widget _recommendList(){
   return Container(
     height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index){
            return _item(context,index);
        },
      ),
   );
 }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top:10),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList()
        ],
      ),
      
    );
  }
}

class FloorTitle extends StatelessWidget {
  final String path;
  FloorTitle({Key key,this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(path),
    );
  }
}
class FloorContent extends StatelessWidget {
  final List floorGoodslist;
  FloorContent({Key key,this.floorGoodslist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context),
        ],
      ),
    );
  }
  Widget _firstRow(context){
    return Row(
      children: <Widget>[
              _goodsItem(context,floorGoodslist[0]),
            Column(
            children: <Widget>[
              _goodsItem(context,floorGoodslist[1]),
              _goodsItem(context,floorGoodslist[2]),
                              ],
            )
      ],
    );
  }

  Widget _otherGoods(context){
    return Row(
      children: <Widget>[
        _goodsItem(context,floorGoodslist[3]),
        _goodsItem(context,floorGoodslist[4]),
      ],
    );
  }
  Widget _goodsItem(context,Map goods){
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){
          Application.router.navigateTo(context, "/detail?id=${goods['goodsId']}");
        },
        child:Image.network(goods['image']),
      ),
    );
  }
}


class HotGoods extends StatefulWidget {
  HotGoods({Key key}) : super(key: key);

  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
@override
  void initState() {
    var formData = {'lon':'115.12932', 'lat':'35.541'};
    // TODO: implement initState
    super.initState();
    request("homePaeBelowContent",formData:formData).then((val){
      print("------------------------");
      print(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("hb"),
    );
  }
}