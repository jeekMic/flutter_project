import 'package:flutter/material.dart';
import 'package:flutter_shop/page/detail_page/deatil_bottom.dart';
import 'package:flutter_shop/provide/detal_info.dart';
import 'package:provide/provide.dart';
import './detail_page/detail_top_area.dart';
import './detail_page/detail_explain.dart';
import './detail_page/details_tabbar.dart';
import 'detail_web.dart';
class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage({Key key,this.goodsId}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("详情页"),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context,snapshot){
            if(snapshot.hasData){
              return Stack(
                children: <Widget>[
                 ListView(
                  children: <Widget>[
                      DetailTopArea(),
                      DetailsExplain(),
                      DetailsTabbar(),
                      DetailHtml()
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailsBottom(),
                )
              ],
              );

            }else{
              return Text("没有数据");
            }
        },
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async{
      await Provide.value<DetailsInfoProvider>(context).setGoodInfo(goodsId);
      return "完成";
  }
}