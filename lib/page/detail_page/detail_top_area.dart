import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/detal_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DetailTopArea extends StatelessWidget {
  const DetailTopArea({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvider>(
        builder: (context,child,val){
          var goodInfo = Provide.value<DetailsInfoProvider>(context).goods_info.data.goodInfo;
          if(goodInfo !=null){
              return Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    _goodsImage(goodInfo.image1),
                    _goodsName(goodInfo.goodsName),
                    _goodsNum(goodInfo.goodsSerialNumber),
                    _goodsPrice(goodInfo.presentPrice,goodInfo.oriPrice),
                  ],
                ),
              );
          }else{
            return Text("正在加载中");
          }
        },
    );

  }
  //商品图片
  Widget _goodsImage(url){
    return Image.network(url,
     width: ScreenUtil().setWidth(740),
    );
  }
  //商品名称
  Widget _goodsName(name){
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        style:TextStyle(
          fontSize:ScreenUtil().setSp(30),
        ),
      ),
    );
  }
  //商品编号
  Widget _goodsNum(number){
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Text(
        '编号：${number}',
        style:TextStyle(
          color:Colors.black12
        ),
      ),
    );
  }
  Widget _goodsPrice(presentPrice,olrPrice){
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥${presentPrice}',
            style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: ScreenUtil().setSp(40),
            ),
          ),

          Text(
            ' 市场价格：￥${olrPrice}',
            style: TextStyle(
              color: Colors.black26,
              fontSize: ScreenUtil().setSp(30),
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}