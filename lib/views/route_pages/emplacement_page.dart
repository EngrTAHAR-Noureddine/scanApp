import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/counter_stocks_in_emplacement.dart';
import 'package:scanapp/models/database_models/emplacements.dart';
import 'package:scanapp/models/database_models/user.dart';
import 'package:scanapp/models/item.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/home.dart';
import 'package:scanapp/view_models/providers/main.dart';
import 'package:scanapp/views/list_of_items.dart';

class ListEmplacement extends StatelessWidget {

  int? id;
  String? name;
  List<String>? chain;
  ListEmplacement({this.id,this.name,this.chain});
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<List<Item>> figureEmplacements(User user)async{
    List<Item> itemEmplacement = <Item>[];
    if(user.emplacementTable != "Empty"){
      List<Emplacement> emplacement = await DBProvider.db.getAllEmplacements();
      if(emplacement.isNotEmpty){
        emplacement.forEach((element) {
          Item item = new Item(nameItem: element.nom,idParent: element.id);
          itemEmplacement.add(item);
        });
      }
    }else if(user.stockSysTable != "Empty"){
      //Looking For stock sys
      /* Search for Emplacement from stockSys Table */
      List<StocksCounter> emplacement = await DBProvider.db.getEmplFromStockSys();
      if(emplacement.isNotEmpty){
        emplacement.forEach((element) {
          Item item = new Item(nameItem:"Bureau: "+element.emplacementID.toString(),idParent: element.emplacementID);
          itemEmplacement.add(item);
        });
      }
    }
    return itemEmplacement.isNotEmpty?itemEmplacement : [];
  }
  Future<List<Item>> fetchEmplacement(int? id)async{
    List<Item> itemEmplacement = <Item>[];
    User? user = await MainProvider().getUser();
    if(user!=null){
      if(user.emplacementTable != "Empty"){
        List<Emplacement> emplacement = await DBProvider.db.getAllEmplacementByService(id);
        if(emplacement.isNotEmpty){
          emplacement.forEach((element) {
            Item item = new Item(nameItem: element.nom,idParent: element.id);
            itemEmplacement.add(item);
          });
        }
      }else{
        itemEmplacement = await figureEmplacements(user);
      }
    }


    return itemEmplacement.isNotEmpty?itemEmplacement : [];
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
              future: fetchEmplacement(id),
              builder: (context, snapshot) {
                if(chain==null) chain = <String>[];
                if(chain!.length>3)chain!.removeRange(3,chain!.length);
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!=null) {
                  List<Item> list = snapshot.data as List<Item>;

                  if(list.isNotEmpty){

                    return Scaffold(
                      key: scaffoldKey,
                      backgroundColor: ColorsOf().backGround(),
                      appBar: HomeProvider().customAppBar(context,scaffoldKey),
                      drawer: HomeProvider().customDrawer(context,1),
                      floatingActionButton:HomeProvider().customFAB(context),
                      body: Container(
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

                                                    TextSpan(text:"Bureaux de : ",
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
                                                  TextSpan(text:(list[index].nameItem!=null)?list[index].nameItem:index.toString(),
                                                    style: TextStyle(color : ColorsOf().backGround() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),

                                                ])
                                            ),
                                            tileColor:ColorsOf().primaryBackGround(),
                                            onTap:(){
                                              if(chain==null) chain = <String>[];
                                              print("____ emplacement ______");
                                              print(chain);
                                              list.forEach((element) {
                                                if(element.nameItem!=null && chain!.isNotEmpty) if(chain!.last==element.nameItem) chain!.removeLast();
                                              });
                                              if(name==null){chain = <String>[];}
                                              chain!.add(list[index].nameItem??"");
                                              print(chain);
                                              print("___________________________");
                                              Navigator.push(context, FadeRoute(page: ListItems(id: list[index].idParent,chain: chain,lookingFor: "stockSys",)));

                                            },
                                          )
                                      );
                                    }):ListItems(),
                              ),
                            ),
                          ],
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
                    body: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: Text("Rechercher..." , style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize: 20),),

                        color: ColorsOf().backGround()),
                  );
                }else{
                  return ListItems();


                }


              }
          );



  }
}
