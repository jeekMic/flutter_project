import 'package:flutter/material.dart';
import 'package:flutter_shop/page/index_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
      return Container(
        child: MaterialApp(
          title: "°ÙÐÕÉú»î",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.pink
          ),
          home: IndexPage(),
        ),
      );
    }
}
