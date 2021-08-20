import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/database_models/inventories.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/models/custom_expansion_tile.dart' as custom;
import 'package:scanapp/models/variables_define/my_flutter_app_icons.dart';
import 'package:scanapp/view_models/providers/process_on_file.dart';
import 'package:scanapp/view_models/providers/inventories_list.dart';
import 'package:scanapp/views/import_new_file.dart';

class InventoryList extends StatelessWidget {




  bool isPortrait = false;
  @override
  Widget build(BuildContext context) {
    return  Consumer<InventoryListProvider>(
        builder: (context, value, child) {

          return Scaffold(
            backgroundColor: ColorsOf().backGround(),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top:0, left: 10, right: 10, bottom: 10),
              child: FutureBuilder(
                future: value.getInventories(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {
                    List<Inventory> list = snapshot.data as List<Inventory>;

                  //if(list.isNotEmpty) {
                    return RefreshIndicator(
                      onRefresh: ()async{
                        value.setState();

                      },
                      child:(list.isNotEmpty)? ListView.builder(

                          scrollDirection: Axis.vertical,
                          itemCount: list.length,
                          padding: EdgeInsets.all(5),
                          itemBuilder: (BuildContext context, int index){

                            return Container(
                              margin: EdgeInsets.all(5),
                              child:Slidable(
                                actionPane: SlidableScrollActionPane(),
                                actionExtentRatio: 0.3,

                                actions: [
                                  /*left*/
                                 value.finishButon(context,list[index]),
                                ],



                                secondaryActions: [ /* right */
                                  value.deleteButton(context,list[index]),

                                ],
                                child: custom.ExpansionTile(

                                  iconColor: ColorsOf().containerThings(),
                                  backgroundColor: ColorsOf().backGround(),
                                  headerBackgroundColor:ColorsOf().primaryBackGround(),

                                  leading: value.iconLoeading(list[index]),

                                  title:  RichText(
                                      text: TextSpan(children: [

                                        TextSpan(text:"Inventory : ",
                                          style: TextStyle(color : ColorsOf().profilField() ,fontSize: 18 ,fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text:list[index].closeDate.toString(),
                                          style: TextStyle(color : ColorsOf().backGround() ,fontSize: 18 ,fontWeight: FontWeight.bold),
                                        ),

                                      ])
                                  ),
                                  children: <Widget>[

                                    Container(
                                      margin: EdgeInsets.only(bottom: 2),
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.transparent,
                                              alignment: Alignment.center,
                                              child: MaterialButton(

                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                highlightElevation: 0,
                                                elevation: 0,
                                                focusElevation: 0,
                                                hoverElevation: 0,
                                                minWidth: 40,
                                                height: 40,
                                                child: Icon(

                                                  MyFlutterApp.import_second,
                                                  color: (list[index].status != "finished")?ColorsOf().borderContainer():ColorsOf().importField(),
                                                  size: 20,
                                                ),

                                                onPressed:(list[index].status != "finished")? ()=>ProcessFileProvider().showDialogToProcess(context, "import"):null,

                                              )             ),
                                          Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.transparent,
                                              child:MaterialButton(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                highlightElevation: 0,
                                                elevation: 0,
                                                focusElevation: 0,
                                                hoverElevation: 0,
                                                minWidth: 40,
                                                height: 40,
                                                child: Icon(
                                                  MyFlutterApp.update,
                                                  color:(list[index].status != "finished")?ColorsOf().borderContainer():ColorsOf().importField(),
                                                  size: 20,
                                                ),


                                                onPressed:(list[index].status != "finished")? ()=>ProcessFileProvider().showDialogToProcess(context, "update"):null,

                                              )
                                          ),
                                          Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.transparent,
                                              child: MaterialButton(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                highlightElevation: 0,
                                                elevation: 0,
                                                focusElevation: 0,
                                                hoverElevation: 0,
                                                minWidth: 40,
                                                height: 40,
                                                child: Icon(
                                                  MyFlutterApp.reset_second,
                                                  color:(list[index].status != "finished")?ColorsOf().borderContainer():ColorsOf().importField(),
                                                  size: 20,
                                                ),

                                                onPressed:(list[index].status != "finished")? ()=>ProcessFileProvider().showDialogToProcess(context, "reset"):null,
                                              )
                                          ),
                                          Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.transparent,
                                              child: MaterialButton(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                highlightElevation: 0,
                                                elevation: 0,
                                                focusElevation: 0,
                                                hoverElevation: 0,
                                                minWidth: 40,
                                                height: 40,
                                                child: Icon(
                                                  MyFlutterApp.delete,
                                                  color:ColorsOf().borderContainer(),
                                                  size: 20,
                                                ),

                                                onPressed: ()=>value.showDialogOfButtons(context,list[index],"Supprimer Inventaire","êtes-vous sûr de supprimer l'inventaire ?","Supprimer"),
                                              )
                                          ),
                                          Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.transparent,
                                              child: MaterialButton(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                highlightElevation: 0,
                                                elevation: 0,
                                                focusElevation: 0,
                                                hoverElevation: 0,
                                                minWidth: 40,
                                                height: 40,
                                                child: Icon(
                                                  MyFlutterApp.export_icon,
                                                  color:(list[index].status != "begin")?ColorsOf().borderContainer():ColorsOf().importField(),
                                                  size: 20,
                                                ),

                                                onPressed:(list[index].status != "begin")? (){print("export");}:null,
                                              )
                                          ),

                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      child: Container(
                                        height: 30,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(100)),
                                            color: ColorsOf().primaryBackGround()
                                        ),
                                        child: MaterialButton(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          highlightElevation: 0,
                                          elevation: 0,
                                          focusElevation: 0,
                                          hoverElevation: 0,
                                          child: Text("Parcours" , style: TextStyle(fontSize: 20, color:ColorsOf().containerThings()),),

                                          onPressed: (){print("parcours");},
                                        ),
                                      ),
                                    )

                                  ],
                                ),

                              ),
                            );
                          }):ImportNewerFile(),
                    );
                  /*}else{
                    return ImportNewerFile();
                  }*/

                  }else {
                    return ImportNewerFile();
                  }


                }
              ),
            ),
          );

        });

  }
}
