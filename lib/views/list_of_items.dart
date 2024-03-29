import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/database_models/product_lots.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/home.dart';
import 'package:scanapp/view_models/providers/list_of_items.dart';
import 'package:scanapp/views/item_information.dart';

class ListItems extends StatelessWidget {

  int? id;
  String? lookingFor;
  List<String>? chain =<String>[];
  ListItems({this.id,this.lookingFor,this.chain});

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return  Consumer<ListItemsProvider>(
        builder: (context, value, child) {
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: ColorsOf().backGround(),
            appBar: HomeProvider().customAppBar(context,scaffoldKey),
            drawer: HomeProvider().customDrawer(context,1),
            floatingActionButton:HomeProvider().customFAB(context),

            body: RefreshIndicator(
              onRefresh: ()async{
                value.setState();
              },
              child: FutureBuilder(
                future: value.getProductLots(lookingFor: lookingFor,id: id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                    List<ProductLot> list = snapshot.data as List<ProductLot>;
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,

                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            color: ColorsOf().backGround(),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top:5,bottom: 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding:EdgeInsets.only(left: 5,right: 5),
                                          child: Text((chain!=null)?chain!.join(">"):"" , style: TextStyle(color : ColorsOf().importField() ,fontSize: 10 ,fontWeight: FontWeight.normal , fontStyle:FontStyle.italic),),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomLeft,

                                  height: 50,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                            padding:EdgeInsets.only(left: 10),
                                            child: RichText(
                                                text: TextSpan(children: [

                                                  TextSpan(text:"Total : ",
                                                    style: TextStyle(color : ColorsOf().borderContainer() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),
                                                  TextSpan(text:(value.total!=null)?value.total.toString():"0",
                                                    style: TextStyle(color : ColorsOf().primaryForGround() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),

                                                ])
                                            )

                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.only(right: 10),
                                            child: RichText(
                                                text: TextSpan(children: [

                                                  TextSpan(text:"Scan : ",
                                                    style: TextStyle(color : ColorsOf().borderContainer() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),
                                                  TextSpan(text:(value.scan!=null)?value.scan.toString():"0",
                                                    style: TextStyle(color : ColorsOf().primaryForGround() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),

                                                ])
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
                              child: (list.isNotEmpty)?ListView.builder(
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

                                              onPressed:(){
                                                    Navigator.push(context, FadeRoute(page: ItemInfo(idProduct: list[index].productId,)));
                                                    },

                                            ),),
                                          title: RichText(
                                              text: TextSpan(children: [

                                                TextSpan(text:"Code à barre : ",
                                                  style: TextStyle(color : ColorsOf().profilField() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                ),
                                                TextSpan(text:(list[index].numLot!=null)?list[index].numLot.toString():"-----",
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

                                                        TextSpan(text:"Némuro de série : ",
                                                          style: TextStyle(color : ColorsOf().profilField() ,fontSize: 12 ,fontWeight: FontWeight.bold),
                                                        ),
                                                        TextSpan(text:list[index].numSerie??"-----",
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

                                                        TextSpan(text:"Immatriculation : ",
                                                          style: TextStyle(color : ColorsOf().profilField() ,fontSize: 12 ,fontWeight: FontWeight.bold),
                                                        ),
                                                        TextSpan(text:list[index].immatriculation??"-----",
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
                                  }):Container(
                                        color:ColorsOf().backGround(),
                                        alignment: Alignment.center,
                                        child: Text("Vide" , style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize: 20),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );


                  }else if(snapshot.connectionState == ConnectionState.waiting){
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: Text("Rechercher..." , style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize: 20),),

                        color: ColorsOf().backGround());
                  }else{
                    return Container(
                      color:ColorsOf().backGround(),
                      alignment: Alignment.center,
                      child: Text("Vide" , style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize: 20),),
                    );
                  }


                }
              ),
            ),
          );

        });

  }
}
