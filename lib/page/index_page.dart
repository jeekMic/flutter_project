import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'member_page.dart';
import 'home_page.dart';
class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs  = [
    BottomNavigationBarItem(icon:Icon(CupertinoIcons.home),title: Text("首页")),
    BottomNavigationBarItem(icon:Icon(CupertinoIcons.search),title: Text("分类")),
    BottomNavigationBarItem(icon:Icon(CupertinoIcons.shopping_cart),title: Text("�?物车")),
    BottomNavigationBarItem(icon:Icon(CupertinoIcons.profile_circled),title: Text("会员�?�?")),
  ];
  final List tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];
  int currentIndex = 0;
  var currentPage;
  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width:750,height: 1334)..init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomTabs,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            print(index);
           currentIndex = index;
           currentPage = tabBodies[currentIndex]; 
          });
        },
      ),
      body: currentPage,

    );
  }
}