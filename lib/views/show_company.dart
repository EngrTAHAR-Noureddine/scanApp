import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/database_models/product_lots.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/home.dart';
import 'package:scanapp/view_models/providers/list_of_items.dart';
import 'package:scanapp/view_models/providers/show_company.dart';
import 'package:scanapp/views/item_information.dart';
import 'package:scanapp/views/list_of_items.dart';

class ListOfItems extends StatelessWidget {
    String? lookingFor;
    int? id;
    String? name;
    String? chain;
    ListOfItems({this.lookingFor,this.id,this.name,this.chain});

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return  Consumer<ShowCompanyProvider>(
        builder: (context, value, child) {

          return FutureBuilder(
                future: value.fetchTables(lookingFor: lookingFor,id: id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!=null) {
                    List<Item> list = snapshot.data as List<Item>;

                    if(list.isNotEmpty){

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
                          child: Container(
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
                                                child: Text(chain??"" , style: TextStyle(color : ColorsOf().importField() ,fontSize: 10 ,fontWeight: FontWeight.normal , fontStyle:FontStyle.italic),),
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

                                                        TextSpan(text:value.localWidget+" de : ",
                                                          style: TextStyle(color : ColorsOf().borderContainer() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                        ),
                                                        TextSpan(text:name??"",
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
                                                leading: Icon(Icons.apartment_outlined, color: ColorsOf().containerThings(),),
                                                title: RichText(
                                                    text: TextSpan(children: [

                                                      TextSpan(text:"Nom : ",
                                                        style: TextStyle(color : ColorsOf().profilField() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                      ),
                                                      TextSpan(text:(list[index].nameItem!=null)?list[index].nameItem:(value.localWidget!=null)?value.localWidget+" "+index.toString():"-----",
                                                        style: TextStyle(color : ColorsOf().backGround() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                      ),

                                                    ])
                                                ),
                                                tileColor:ColorsOf().primaryBackGround(),
                                                onTap:(){
                                                  if(chain==null)chain = "";
                                                  chain = list[index].nameItem!;
                                                  if(list[index].lookingFor == "stockSys"){
                                                    Navigator.push(context, FadeRoute(page: ListItems(lookingFor: list[index].lookingFor,id: list[index].idParent,chain: chain,)));
                                                  }else{
                                                    Navigator.push(context, FadeRoute(page: ListOfItems(id: list[index].idParent,lookingFor: list[index].lookingFor,name: list[index].nameItem,chain: chain,)));
                                                  }

                                                },
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
                          ),
                        ),
                      );
                    }else{
                      return ListItems();
                    }



                  }
                  else if(snapshot.connectionState == ConnectionState.waiting){
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
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            alignment: Alignment.center,
                            child: Text("Rechercher..." , style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize: 20),),

                            color: ColorsOf().backGround()),
                      ),
                    );
                  }else{
                    return ListItems();

                   /*
                    return Container(
                      color:ColorsOf().backGround(),
                      alignment: Alignment.center,
                      child: Text("Vide" , style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize: 20),),
                    );
                    */

                  }


                }
            );

        });

  }
}
