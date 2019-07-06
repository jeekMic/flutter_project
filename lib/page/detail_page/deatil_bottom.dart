import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
import '../../provide/detal_info.dart';

class DetailsBottom extends StatelessWidget {
  const DetailsBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provide.value<DetailsInfoProvider>(context).goods_info.data.goodInfo;
    var goodId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count  = 1;
    var price = goodsInfo.presentPrice;
    var image = goodsInfo.image1;
    return Container(
      child: Container(
        width: ScreenUtil().setWidth(750),
        color: Colors.white,
        height: ScreenUtil().setHeight(80),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: (){},
              child: Container(
                width: ScreenUtil().setWidth(110),
                alignment: Alignment.center,
                child: Icon(
                  Icons.shopping_cart,
                  size:35,
                  color:Colors.red
                ),
              ),
            ),
            InkWell(
              onTap: () async{
                  await Provide.value<CartProvide>(context).save(goodId, goodsName, count, price);
              },
              child: Container(
                  width: ScreenUtil().setWidth(320),
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(80),
                  color: Colors.green,
                  child: Text(
                    "加入购物车",
                    style:TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28))
                    
                  ),
              ),
            ),            InkWell(
              onTap: () async{
                  await Provide.value<CartProvide>(context).remove();
              },
              child: Container(
                  width: ScreenUtil().setWidth(320),
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(80),
                  color: Colors.red,
                  child: Text(
                    "立即购买",
                    style:TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28))
                    
                  ),
              ),
            )
          ],
        )
      ),
    );
  }
}