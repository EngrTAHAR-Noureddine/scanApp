import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/database_models/inventory_lines.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/home.dart';
import 'package:scanapp/view_models/providers/onGoing_list.dart';

class OnGoingListInventory extends StatelessWidget {
    int? id;
    OnGoingListInventory({id});
    
  @override
  Widget build(BuildContext context) {
    return  Consumer<OnGoingListProvider>(
        builder: (context, value, child) {

          return WillPopScope(
              onWillPop: () async{
                HomeProvider().setSelector(0);
                return false;
              },

            child: Scaffold(
              backgroundColor: ColorsOf().backGround(),
              body: RefreshIndicator(
                onRefresh: ()async{
                  value.setState();

                },
                child: FutureBuilder(
                    future: value.getAllLines(id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                        List<InventoryLine> list = snapshot.data as List<InventoryLine>;
                        if(list.isNotEmpty){
                          return Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,

                            child: Container(
                              padding: EdgeInsets.all(10),
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

                                              onPressed: ()=>HomeProvider().setSelector(11,list[index].productId),

                                            ),),
                                          title: RichText(
                                              text: TextSpan(children: [

                                                TextSpan(text:"ID : ",
                                                  style: TextStyle(color : ColorsOf().profilField() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                ),
                                                TextSpan(text:(list[index].id!=null)?list[index].id.toString():"-----",
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

                                                        TextSpan(text:"Id Inventaire : ",
                                                          style: TextStyle(color : ColorsOf().profilField() ,fontSize: 12 ,fontWeight: FontWeight.bold),
                                                        ),
                                                        TextSpan(text:(list[index].inventoryId!=null)?list[index].inventoryId.toString():"-----",
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

                                                        TextSpan(text:"ID d'Emplacement : ",
                                                          style: TextStyle(color : ColorsOf().profilField() ,fontSize: 12 ,fontWeight: FontWeight.bold),
                                                        ),
                                                        TextSpan(text:(list[index].emplacementId!=null)?list[index].emplacementId.toString():"-----",
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
                              child: Text("Vide" , style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize: 20),),
                              );
                              }



                      }else if(snapshot.connectionState == ConnectionState.waiting){
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
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
            ),
          );

        });

  }
}
