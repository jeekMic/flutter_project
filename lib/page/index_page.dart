import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../page/cart_page.dart';
import '../page/category_page.dart';
import '../page/home_page.dart';
import '../page/member_page.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(title: Text("首页"),icon: Icon(CupertinoIcons.home)),
    BottomNavigationBarItem(title: Text("分类"),icon: Icon(CupertinoIcons.search)),
    BottomNavigationBarItem(title: Text("购物车"),icon: Icon(CupertinoIcons.shopping_cart)),
    BottomNavigationBarItem(title: Text("个人分类"),icon: Icon(CupertinoIcons.profile_circled)),
  ];
  int currentIndex = 0;
  var currentpage;
  @override
  void initState() {
    // TODO: implement initState
    currentpage = tabBodies[currentIndex];
    super.initState();
  }

  final List<Widget> tabBodies =[
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index){
          setState(() {
           currentIndex = index;
           currentpage = tabBodies[currentIndex]; 
          });
        },
      ),
        body: IndexedStack(
          index: currentIndex,
          children: tabBodies,
        ),
      );
  }
}