import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/counter.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> testList = []; 
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[

            Container(
              height: 500.0,
              child: ListView.builder(
                itemCount: testList.length,
                itemBuilder: (context,index){
                  return ListTile(
                    title: Text(testList[index]),
                  );
                },
              ),
            ),
            RaisedButton(
              onPressed: (){
                _add();
              },
              child: Text("增加"),
            ),
            RaisedButton(
              onPressed: (){
                _delete();
              },
              child: Text("清空"),
            ),
          ],
        ),
    );
  }

  void _add() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String  temp = "安得广厦千万间";
     testList.add(temp);
     prefs.setStringList("df", testList);
     _show();
  
   }

//查询
void _show() async{
  SharedPreferences sp = await SharedPreferences.getInstance();
      if(sp.getStringList("df")!=null){
          setState((){
            testList = sp.getStringList("df");
          });
      }
  }

  //删除
 void _delete() async{
  SharedPreferences sp = await SharedPreferences.getInstance();
    // sp.clear();
    sp.remove("df");
    setState((){
      testList =[];
    });
  }
}