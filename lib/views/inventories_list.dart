import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/database_models/inventories.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/models/custom_expansion_tile.dart' as custom;
import 'package:scanapp/models/variables_define/my_flutter_app_icons.dart';
import 'package:scanapp/view_models/providers/exports_list.dart';
import 'package:scanapp/view_models/providers/home.dart';
import 'package:scanapp/view_models/providers/onGoing_list.dart';
import 'package:scanapp/view_models/providers/process_on_file.dart';
import 'package:scanapp/view_models/providers/inventories_list.dart';
import 'package:scanapp/view_models/providers/search.dart';
import 'package:scanapp/views/import_new_file.dart';
import 'package:scanapp/views/onGoingList.dart';
import 'package:scanapp/views/search.dart';

class InventoryList extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  Consumer<InventoryListProvider>(
        builder: (context, value, child) {

          return Scaffold(
            key: scaffoldKey,
            backgroundColor: ColorsOf().backGround(),
            appBar: HomeProvider().customAppBar(context,scaffoldKey),
            drawer: HomeProvider().customDrawer(context,0),
            floatingActionButton:HomeProvider().customFAB(context),
            body:Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top:0, left: 10, right: 10, bottom: 10),
              child: FutureBuilder(
                future: value.getInventories(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {
                    List<Inventory> list = snapshot.data as List<Inventory>;
                    value.moveFirst(list);
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
                                closeOnScroll: true,
                                actionPane: SlidableScrollActionPane(),

                                actionExtentRatio: 0.3,

                                actions:(list[index].status != "finished")? [
                                  /*left*/
                                    value.finishButon(context,list[index]),
                                ] : [],



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

                                        TextSpan(text:"Inventaire : ",
                                          style: TextStyle(color : ColorsOf().profilField() ,fontSize: 18 ,fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text:list[index].id.toString(),
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
                            (value.showingUpdateButton())?
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
                                                              size: 25,
                                                                ),


                                              onPressed:(list[index].status != "finished")? ()=>ProcessFileProvider().showDialogToProcess(context, "update"):null,

                                              )
                                              ):  Container(
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
                                                  size: 25,
                                                ),

                                                onPressed:(list[index].status != "finished")? ()=>ProcessFileProvider().showDialogToProcess(context, "import"):null,

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
                                                        Icons.check_circle,
                                                        color:(list[index].status=="ongoing")?ColorsOf().borderContainer():ColorsOf().importField(),
                                                        size: 25,
                                                        ),

                                                        onPressed: (list[index].status=="ongoing")? ()=>value.showDialogOfButtons(context, list[index],"Terminer Inventaire","êtes-vous sûr de terminer l'inventaire ?","Terminer"):null,
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
                                                  size: 25,
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
                                                  size: 25,
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
                                                  size: 25,
                                                ),

                                                onPressed:(list[index].status != "begin")? (){
                                                      //  Navigator.pop(context);
                                                      Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                      builder: (context) => ExportProvider().processSaving(context,list[index].id),
                                                      ),
                                                      );
                                                      }:null,
                                              )
                                          ),

                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      child: Container(
                                        height: 40,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(100)),
                                            color:(list[index].status != "finished")? ColorsOf().primaryBackGround():ColorsOf().importField()
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

                                          onPressed:(list[index].status == "ongoing")? (){

                                            OnGoingListProvider().id =list[index].id;
                                             //HomeProvider().setSelector(10);
                                            Navigator.pop(context);
                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute<void>(
                                                              builder: (BuildContext context) => OnGoingListInventory(),
                                                              // fullscreenDialog: true,
                                                              ),
                                               );


                                          }: null,
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

                  }if(snapshot.connectionState == ConnectionState.waiting){
                    return Container();
                  }else {
                    return ImportNewerFile();
                  }


                }
              ),
            ) ,
          );

        });

  }
}
