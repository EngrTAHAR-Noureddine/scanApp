import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/product_category.dart';
import 'package:scanapp/models/database_models/products.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/models/variables_define/my_flutter_app_icons.dart';
import 'package:scanapp/view_models/providers/home.dart';

class ProductInfo{
  String? nameProduct;
  String? productCode;
  String? categoryName;
  String? gestionLot;
  String? productType;
  ProductInfo({this.nameProduct,this.gestionLot,this.productType,this.productCode,this.categoryName});
}

class ItemInfo extends StatelessWidget {
  int? idProduct;
  ItemInfo({this.idProduct});

  Future<ProductInfo?> getProdutIfo()async{
    Product? product = await DBProvider.db.getProduct(idProduct);
    ProductInfo? productInfo;
    if(product!=null){
      ProductCategory? category = await DBProvider.db.getProductCategory(product.categoryId);
      productInfo = new ProductInfo(
        productType: product.productType,
        productCode: product.productCode,
        nameProduct: product.nom,
        gestionLot: product.gestionLot,
        categoryName: (category!=null)?(category.parentPath??"")+"/"+(category.categoryName??"-----"):"------"
      );

    }

    return productInfo;
  }




  TextEditingController addCodeBar = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      print(idProduct);

          return Scaffold(
            key: scaffoldKey,
            backgroundColor: ColorsOf().backGround(),
            appBar: HomeProvider().customAppBar(context,scaffoldKey),
            drawer: HomeProvider().customDrawer(context,11),
            floatingActionButton:HomeProvider().customFAB(context),
            resizeToAvoidBottomInset: false,
            body: FutureBuilder(
                future: getProdutIfo(),
                builder: (context, snapshot) {
                  ProductInfo? product;
                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                    product = snapshot.data as ProductInfo;
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.bottomCenter,

                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [

                          Container(
                            height: MediaQuery.of(context).size.height * 0.8 ,
                            width: MediaQuery.of(context).size.width ,
                            padding: EdgeInsets.only(top: 50),


                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: ColorsOf().primaryBackGround(),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(top: 40),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: ColorsOf().primaryBackGround(),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(

                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                side: BorderSide(color:Colors.transparent ,width: 0,style: BorderStyle.solid)
                                            ),
                                            leading: RichText(
                                                text: TextSpan(children: [

                                                  TextSpan(text:"Code de Produit : ",
                                                    style: TextStyle(color : ColorsOf().containerThings() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),


                                                ])
                                            ),

                                            title: RichText(
                                                text: TextSpan(children: [

                                                  TextSpan(text:(product!=null)?product.productCode??"-----":"-----",
                                                    style: TextStyle(color : ColorsOf().containerThings() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),

                                                ])
                                            ),

                                            tileColor:ColorsOf().primaryBackGround(),
                                            onTap:null,
                                          ),
                                        ),
                                        Container(
                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                side: BorderSide(color:Colors.transparent ,width: 0,style: BorderStyle.solid)
                                            ),
                                            leading: RichText(
                                                text: TextSpan(children: [

                                                  TextSpan(text:"Nom de Produit : ",
                                                    style: TextStyle(color : ColorsOf().containerThings() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),

                                                ])
                                            ),
                                            title: RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text:(product!=null)?product.nameProduct??"-----":"-----",
                                                    style: TextStyle(color : ColorsOf().containerThings() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),

                                                ])
                                            ),

                                            tileColor:ColorsOf().primaryBackGround(),
                                            onTap:null,
                                          ),
                                        ),
                                        Container(
                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                side: BorderSide(color:Colors.transparent ,width: 0,style: BorderStyle.solid)
                                            ),
                                            leading: RichText(
                                                text: TextSpan(children: [

                                                  TextSpan(text:"Type de Produit : ",
                                                    style: TextStyle(color : ColorsOf().containerThings() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),


                                                ])
                                            ),
                                            title: RichText(
                                                text: TextSpan(children: [

                                                  TextSpan(
                                                    text:(product!=null)?product.productType??"-----":"-----",
                                                    style: TextStyle(color : ColorsOf().containerThings() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),

                                                ])
                                            ),

                                            tileColor:ColorsOf().containerThings(),
                                            onTap:null,
                                          ),
                                        ),
                                        Container(

                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                side: BorderSide(color:Colors.transparent ,width: 0,style: BorderStyle.solid)
                                            ),
                                            leading: RichText(
                                                text: TextSpan(children: [

                                                  TextSpan(text:"Le category de produit : ",
                                                    style: TextStyle(color : ColorsOf().containerThings() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),

                                                ])
                                            ),
                                            title:  RichText(
                                                text: TextSpan(children: [

                                                  TextSpan(
                                                    text:(product!=null)?product.categoryName??"-----":"-----",
                                                    style: TextStyle(color : ColorsOf().containerThings() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),

                                                ])
                                            ),

                                            tileColor:ColorsOf().containerThings(),
                                            onTap:null,
                                          ),
                                        ),
                                        Container(
                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                side: BorderSide(color:Colors.transparent ,width: 0,style: BorderStyle.solid)
                                            ),
                                            leading: RichText(
                                                text: TextSpan(children: [

                                                  TextSpan(text:"gestion lot : ",
                                                    style: TextStyle(color : ColorsOf().containerThings() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),


                                                ])
                                            ),
                                            title: RichText(
                                                text: TextSpan(children: [

                                                  TextSpan(
                                                    text:(product!=null)?product.gestionLot??"-----":"-----",
                                                    style: TextStyle(color : ColorsOf().containerThings() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),

                                                ])
                                            ),

                                            tileColor:ColorsOf().containerThings(),
                                            onTap:null,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                )

                            ),

                          ),
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: ColorsOf().borderContainer(),width: 1,style:BorderStyle.solid),
                              color: ColorsOf().containerThings(),
                            ),
                            child: Icon(MyFlutterApp.qr_code,size: 60,color: ColorsOf().primaryBackGround(),),
                          ),
                        ],
                      ),
                    );


                  }else{
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: Text("Pas Trouver" , style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize: 20),),
                        color: ColorsOf().backGround());
                  }



                }
            ),
          );




  }
}
