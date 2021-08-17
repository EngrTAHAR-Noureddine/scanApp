import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/models/custom_expansion_tile.dart' as custom;
import 'package:scanapp/models/variables_define/my_flutter_app_icons.dart';
import 'package:scanapp/view_models/providers/inventories_list.dart';

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

              child: Container(
                padding: EdgeInsets.only(top:0, left: 10, right: 10, bottom: 10),
                child: ListView.builder(

                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    padding: EdgeInsets.all(5),
                    itemBuilder: (BuildContext context, int index){

                      return Container(
                        margin: EdgeInsets.all(5),
                        child:Slidable(
                          actionPane: SlidableScrollActionPane(),
                          actionExtentRatio: 0.3,

                          actions: [
                            /*left*/

                          ],



                          secondaryActions: [ /* right */


                          ],
                          child: custom.ExpansionTile(

                            iconColor: ColorsOf().containerThings(),
                            backgroundColor: ColorsOf().backGround(),
                            headerBackgroundColor:ColorsOf().primaryBackGround(),

                            leading: value.iconLoeading("ongoing"),

                            title: Text(
                              "Inventory 001",
                              style: TextStyle(fontSize: 18.0,color:ColorsOf().containerThings(),),
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

                                          child: Icon(

                                            MyFlutterApp.import_second,
                                            color:ColorsOf().borderContainer(),
                                            size: 20,
                                          ),

                                        onPressed: (){},

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
                                          child: Icon(
                                            MyFlutterApp.update,
                                            color:ColorsOf().borderContainer(),
                                            size: 20,
                                          ),


                                          onPressed: (){},

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
                                          child: Icon(
                                            MyFlutterApp.reset_second,
                                            color:ColorsOf().borderContainer(),
                                            size: 20,
                                          ),

                                        onPressed: (){},
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
                                          child: Icon(
                                            MyFlutterApp.delete,
                                            color:ColorsOf().borderContainer(),
                                            size: 20,
                                          ),

                                        onPressed: (){},
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
                                          child: Icon(
                                            MyFlutterApp.export_icon,
                                            color:ColorsOf().borderContainer(),
                                            size: 20,
                                          ),

                                        onPressed: (){},
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

                                    onPressed: (){},
                                  ),
                                ),
                              )

                            ],
                          ),

                        ),
                      );
                    }),
              ),
            ),
          );

        });

  }
}
