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
import '../model/categoryGoodList.dart';
import '../provide/category_good_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
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
                 RightCategoryNav(),
                 CategoryGoodsList(),
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
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context).setChildCategory(childList,categoryId);
        print("you has click the left nvvigation at ${index}");
        _getGoodsList(categoryId:categoryId);
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
      Provide.value<ChildCategory>(context).setChildCategory(list[0].bxMallSubDto,list[0].mallCategoryId);
      //list.data.forEach((item)=> print(item.mallCategoryName));
    });
  }


    void _getGoodsList({String categoryId}) async{
    var data = {
      'categoryId':categoryId==null?"4":categoryId,
      'categorySubId':'',
      'page':1,
    };
    await request('getMallGoods', formData:data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).setGoodList(goodsList.data);
    });

  }
  
}
//右侧UI,横向的导航页面
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
                    return _rightInkWell(index,childCategory.chilCategoryList[index]);
                  },
                ),
              );
      },
    ); 
    

  }
  Widget _rightInkWell(int index,BxMallSubDto item){
     bool isClick = false;
     isClick =  (index==Provide.value<ChildCategory>(context).childIndex?true:false);
      return InkWell(
        onTap: (){
          Provide.value<ChildCategory>(context).changeChildIndex(index,item.mallSubId);
          _getGoodsList(item.mallSubId);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
          child: Text(
            item.mallSubName,
            style:TextStyle(fontSize:ScreenUtil().setSp(28),color: isClick?Colors.pink:Colors.black)
          ),
        ),
      );
  }
  

    void _getGoodsList(String categorySubId) async{
    var data = {
      'categoryId':Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':categorySubId,
      'page':1,
    };
    await request('getMallGoods', formData:data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if(goodsList.data == null){
      Provide.value<CategoryGoodsListProvide>(context).setGoodList([]);
      }else{
              Provide.value<CategoryGoodsListProvide>(context).setGoodList(goodsList.data);
      }

    });

  }


}
//商品列表，上拉加载
class CategoryGoodsList extends StatefulWidget {
  CategoryGoodsList({Key key}) : super(key: key);

  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  // List list = [];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context,child,data){
          if(data.goodList.length>0){
          return Expanded(
            child: Container(  
            width: ScreenUtil().setWidth(570),
            child: ListView.builder(
                itemBuilder: (context,index){
                  return _ListWidget(data.goodList,index);
                },
                itemCount: data.goodList.length,
            ),
          ),
          );
          }else{
            return Text("暂时没有数据");
          }


      },
  
    );
  }

// Container(
//        width: ScreenUtil().setWidth(570),
//        height: ScreenUtil().setHeight(1000),
//        child: ListView.builder(
//           itemBuilder: (context,index){
//             return _ListWidget(index);
//           },
//           itemCount: list.length,
//        ),
//     );


  Widget _goodsImage(List newList,index){
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }
  Widget _goodsName(List newList,index){
    return  Container(
      padding:EdgeInsets.all(5.0),
      width:ScreenUtil().setWidth(370),
      child:Text(
      newList[index].goodsName,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: ScreenUtil().setSp(28)),
    ),
    );
  }
  Widget _goodsprice(List newList,index){
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
          children: <Widget>[
            Text("价格￥${newList[index].presentPrice}",style: TextStyle(color: Colors.pink,fontSize: ScreenUtil().setSp(30)),),
            Text("${newList[index].presentPrice}",style:TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough)),
          ],
          
      ),
    );
  }

  Widget _ListWidget(List newList,int index){
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(top:5.0,bottom:5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width:1.0,color: Colors.black12),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(newList,index),
            Column(
              children: <Widget>[
                _goodsName(newList,index),
                _goodsprice(newList,index)
              ],
            ),
          ],
        ),
      ),
    );
  }

}