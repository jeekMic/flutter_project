import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/counter.dart';
import 'package:provide/provide.dart';
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            MyNumber(),
            MyButton(),
          ],
        ),
      ),
    );
  }
}

class MyNumber extends StatefulWidget {
  MyNumber({Key key}) : super(key: key);

  _MyNumberState createState() => _MyNumberState();
}

class _MyNumberState extends State<MyNumber> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 200),
        child: Provide<Counter>(
         builder:(context,child,counter){
            return Text("${counter.value}",style: TextStyle(fontSize: ScreenUtil().setSp(40)));
         }
       ),
    );
  }
}
class MyButton extends StatelessWidget {
  const MyButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text("点击"),
        onPressed: (){
          print("点击了按钮");
          Provide.value<Counter>(context).increment();
        },
      ),
    );
  }
}