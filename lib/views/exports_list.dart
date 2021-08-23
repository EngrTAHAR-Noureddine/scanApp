import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/database_models/inventories.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/exports_list.dart';
import 'package:scanapp/view_models/providers/home.dart';

class Export extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return  Consumer<ExportProvider>(
        builder: (context, value, child) {

          return Scaffold(
            key: scaffoldKey,
            backgroundColor: ColorsOf().backGround(),
            appBar: HomeProvider().customAppBar(context,scaffoldKey),
            drawer: HomeProvider().customDrawer(context,6),
            floatingActionButton:HomeProvider().customFAB(context),
            body: FutureBuilder(
              future: value.getAllInventory(),
              builder: (context, snapshot) {

                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!=null) {
                      List<Inventory> list = snapshot.data as List<Inventory>;
                      if(list.isNotEmpty){
                        return Container(
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
                                        width: 100,
                                        height: 50,
                                        color: Colors.transparent,
                                        alignment: Alignment.center,
                                        child:MaterialButton(
                                          padding: EdgeInsets.zero,
                                          height: 50,
                                          minWidth: 100,
                                          color: ColorsOf().containerThings(),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(100)),
                                              side: BorderSide(color:ColorsOf().containerThings() ,width: 1,style: BorderStyle.solid)
                                          ),
                                          child: Text("Export",style: TextStyle(fontSize: 16, color: ColorsOf().primaryBackGround()),),

                                          onPressed:(){
                                          //  Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => value.processSaving(context,list[index].id),
                                              ),
                                            );
                                          },//()=>value.processSaving(context,list[index].id),

                                        ),),
                                      title: RichText(
                                          text: TextSpan(children: [

                                            TextSpan(text:"Inventory : ",
                                              style: TextStyle(color : ColorsOf().profilField() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(text:(list[index].id!=null)?list[index].id.toString():"------",
                                              style: TextStyle(color : ColorsOf().backGround() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                            ),

                                          ])
                                      ),

                                      tileColor:ColorsOf().primaryBackGround(),
                                      onTap:null,
                                    )
                                );
                              }),
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
                    }else {

                      return Container(
                        color:ColorsOf().backGround(),
                        alignment: Alignment.center,
                        child: Text("Vide" , style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize: 20),),
                      );
                    }

              }
            ),

          );

        });

  }
}
