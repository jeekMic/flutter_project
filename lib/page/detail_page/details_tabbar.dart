import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/detal_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DetailsTabbar extends StatelessWidget {
  const DetailsTabbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvider>(
      builder: (context,child,val){
        var isLeft = Provide.value<DetailsInfoProvider>(context).isLeft;
        var isRight = Provide.value<DetailsInfoProvider>(context).isRight;
        return Container(
          margin: EdgeInsets.only(top:15.0),
          child: Row(
            children: <Widget>[
              _myTabbarLeft(context,isLeft),
              _myTabbarRight(context, isRight)
            ],
          ),
        );
      },
    );
  }
  Widget _myTabbarLeft(BuildContext context, bool isRight){
    return InkWell(
      onTap: (){
        Provide.value<DetailsInfoProvider>(context).changeLeftAndRight("right");
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isRight?Colors.pink:Colors.black12
            )
          )
        ),
        child: Text("评论",
          style: TextStyle(
            color: isRight?Colors.pink:Colors.black12
          ),
        ),
      ),
    );
  }
}


  Widget _myTabbarRight(BuildContext context, bool isleft){
    return InkWell(
      onTap: (){
        Provide.value<DetailsInfoProvider>(context).changeLeftAndRight("left");
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isleft?Colors.pink:Colors.black12
            )
          )
        ),
        child: Text("详情",
          style: TextStyle(
            color: isleft?Colors.pink:Colors.black12
          ),
        ),
      ),
    );
  }
}
