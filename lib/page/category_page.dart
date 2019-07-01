import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/service/service_method.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';
class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController textEditingController = new TextEditingController();
  String showText = "正在获取数据";
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  // _getCatory();
    return Scaffold(
      appBar: AppBar(title: Text("商品分类"),),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategory(),
            Column(
              children: <Widget>[
                 RightCategoryNav()
              ],
            ),

          ],
        ),
      ),
    );
  }

}


//左侧类别导航
class LeftCategory extends StatefulWidget {

  LeftCategory({Key key}) : super(key: key);

  _LeftCategoryState createState() => _LeftCategoryState();
}



class _LeftCategoryState extends State<LeftCategory> {
  List  list = [];
  var listindex = 0;
  @override
  void initState() {
    // TODO: implement initState
    _getCatory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       width: ScreenUtil().setWidth(180),
       decoration: BoxDecoration(
         border: Border(
           right: BorderSide(width: 1,color: Colors.black12)
         )
       ),
       child: ListView.builder(
         itemCount: list.length,
         itemBuilder: (context,index){
           return _leftInkWell(index);
         },
       ),
    );
  }

  Widget _leftInkWell(int index){
    bool isClicked  = false;
    isClicked= (index == listindex)?true:false;
    return InkWell(
      onTap: (){
        setState(() {
         listindex = index; 
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).setChildCategory(childList);
        print("you has click the left nvvigation at ${index}");
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10,top: 20),
        decoration: BoxDecoration(
          color: isClicked?Color.fromRGBO(236,236,236,1.0):Colors.white,
          border: Border(
              bottom: BorderSide(width: 1,color: Colors.black12)
          ),
        ),
        child: Text(list[index].mallCategoryName,style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(25)),),
      ),
    );
  }
  void  _getCatory() async{
    await request('getCategory').then((val){
      var data = json.decode(val.toString());
      print("分类页面的数据");
      print(data);
      CategoryModel cateLeft = CategoryModel.fromJson(data);
      setState(() {
        list = cateLeft.data;
      });
      Provide.value<ChildCategory>(context).setChildCategory(list[0].bxMallSubDto);
      //list.data.forEach((item)=> print(item.mallCategoryName));
    });
  }
  
}
//右侧UI
class RightCategoryNav extends StatefulWidget {
  RightCategoryNav({Key key}) : super(key: key);

  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  //List list = ['名酒','宝丰','北京二锅头','大明','舍得','茅台','五粮液','洋河蓝色经典'];
  @override
  Widget build(BuildContext context) {
    
    return Provide<ChildCategory>(
      builder: (context,child,childCategory){
        return  Container(
                height: ScreenUtil().setHeight(80),
                width: ScreenUtil().setWidth(570),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(width:1,color: Colors.black12)
                  ),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: childCategory.chilCategoryList.length,
                  itemBuilder: (contex,index){
                    return _rightInkWell(childCategory.chilCategoryList[index]);
                  },
                ),
              );
      },
    ); 
    
    
    

  }

  Widget _rightInkWell(BxMallSubDto item){
      return InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
          child: Text(
            item.mallSubName,
            style:TextStyle(fontSize:ScreenUtil().setSp(28))
          ),
        ),
      );
  }
}