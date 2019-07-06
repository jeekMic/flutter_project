import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/page/index_page.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:flutter_shop/provide/detal_info.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_good_list.dart';
import './routers/routers.dart';
import './routers/application.dart';
void main(){
  var counter = Counter();
  var childCategory = ChildCategory();
  var detailsInfoProvider = DetailsInfoProvider();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var cartProvide = CartProvide();
  var providers = Providers();

  providers..provide(Provider<Counter>.value(counter))
           ..provide(Provider<ChildCategory>.value(childCategory))
           ..provide(Provider<DetailsInfoProvider>.value(detailsInfoProvider))
           ..provide(Provider<DetailsInfoProvider>.value(detailsInfoProvider))
           ..provide(Provider<CartProvide>.value(cartProvide));
  runApp(ProviderNode(child: MyApp(),providers: providers,));
  }

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){ 
      var router = Router();
      Routes.configureRouter(router);
      Application.router = router;
      return Container(
        child: MaterialApp(
          title: "百姓生活家",
          onGenerateRoute: Application.router.generator,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.pink
          ),
          home: IndexPage(),
        ),
      );
    }
}
