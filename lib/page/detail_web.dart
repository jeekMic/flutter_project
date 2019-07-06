import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/detal_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailHtml extends StatelessWidget {
  DetailHtml({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Provide<DetailsInfoProvider>(
      builder: (context,child,val){
    var goodInfo = Provide.value<DetailsInfoProvider>(context).goods_info.data.goodInfo;
    var goodsDetail = Provide.value<DetailsInfoProvider>(context).goods_info.data.goodInfo.goodsDetail.replaceAll("%", "").replaceAll("auto", "80");
    print("DetailHtml============${goodInfo.goodsName}");
        var isLeft = Provide.value<DetailsInfoProvider>(context).isLeft;
        if(isLeft){
          return Container(
            child: Html(
              data: goodsDetail,
            ),
          );
        }else{
          return Container(
              width: ScreenUtil().setHeight(750),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text("暂时没有数据"),
          );
        }
      },
    );
    
  
  }
}