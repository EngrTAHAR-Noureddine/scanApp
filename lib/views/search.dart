import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/database_models/product_lots.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/home.dart';
import 'package:scanapp/view_models/providers/search.dart';

class Search extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return WillPopScope (
      onWillPop: ()async{
        HomeProvider().setSelector(0);
        return false;
      },
      child: Consumer<SearchProvider>(
          builder: (context, value, child) {

            return FutureBuilder(
              future: value.getList(),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {
               //   if(snapshot.hasData){
                  List<ProductLot> list = snapshot.data as List<ProductLot>;


                  if(list.isNotEmpty){
                    return Scaffold(
                      backgroundColor: ColorsOf().backGround(),
                      body: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: list.length,
                            padding: EdgeInsets.all(5),
                            itemBuilder: (BuildContext context, int index){

                              return Container(
                                  margin: EdgeInsets.all(5),
                                  child:ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        side: BorderSide(color:ColorsOf().primaryBackGround() ,width: 1,style: BorderStyle.solid)
                                    ),
                                    leading: Icon(Icons.inventory, color: ColorsOf().containerThings(),),
                                    trailing:Container(
                                      width: 30,
                                      height: 30,
                                      alignment: Alignment.center,
                                      child:MaterialButton(
                                        padding: EdgeInsets.zero,
                                        height: 30,
                                        minWidth: 30,
                                        shape: CircleBorder(
                                            side: BorderSide(color:ColorsOf().primaryBackGround() ,width: 1,style: BorderStyle.solid)
                                        ),
                                        child: Icon(Icons.info, color: ColorsOf().onGoingItem(), size: 30,),

                                        onPressed: (){},

                                      ),),
                                    title: RichText(
                                        text: TextSpan(children: [

                                          TextSpan(text:"Code à Barre : ",
                                            style: TextStyle(color : ColorsOf().profilField() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(text:list[index].numLot,
                                            style: TextStyle(color : ColorsOf().backGround() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                          ),

                                        ])
                                    ),
                                    subtitle:Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(top: 10),
                                      child:Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: RichText(
                                                text: TextSpan(children: [

                                                  TextSpan(text:"ID de Produit : ",
                                                    style: TextStyle(color : ColorsOf().profilField() ,fontSize: 12 ,fontWeight: FontWeight.bold),
                                                  ),
                                                  TextSpan(text:list[index].productId.toString(),
                                                    style: TextStyle(color : ColorsOf().backGround() ,fontSize: 12 ,fontWeight: FontWeight.normal),
                                                  ),

                                                ])
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: RichText(
                                                text: TextSpan(children: [

                                                  TextSpan(text:"Numéro de série : ",
                                                    style: TextStyle(color : ColorsOf().profilField() ,fontSize: 12 ,fontWeight: FontWeight.bold),
                                                  ),
                                                  TextSpan(text:list[index].numSerie,
                                                    style: TextStyle(color : ColorsOf().backGround() ,fontSize: 12 ,fontWeight: FontWeight.normal),
                                                  ),

                                                ])
                                            ),
                                          ),
                                        ],
                                      ),),
                                    tileColor:ColorsOf().primaryBackGround(),
                                    onTap:null,
                                  )
                              );
                            }),
                      ),
                    );
                  }else{
                    return Container(
                      color:ColorsOf().backGround(),
                      alignment: Alignment.center,
                      child: Text("Pas Trouver" , style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize: 20),),
                    );
                  }

                }else{
                  return Container(
                  color:ColorsOf().backGround(),
                  alignment: Alignment.center,
                  child: Text("Pas Trouver" , style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize: 20),),
                );
                }


              }
            );

          }),
    );

  }
}
