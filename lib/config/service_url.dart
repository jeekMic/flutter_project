import 'dart:developer';

const serviceUrl = "http://v.jspang.com:8088/baixing/";
const servicePath = {
  'homePageContent':serviceUrl+"wxmini/homePageContent",//商店首页信息
  'homePaeBelowContent':serviceUrl+'wxmini/homePageBelowConten',//商城热卖
  'getCategory':serviceUrl+'wxmini/getCategory',//商品类别信息
  'getMallGoods': serviceUrl+'wxmini/getMallGoods', //商品分类的商品列表
};