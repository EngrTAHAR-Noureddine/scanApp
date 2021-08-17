import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/list_of_items.dart';

class ListItems extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Consumer<ListItemsProvider>(
        builder: (context, value, child) {

          return Scaffold(
            backgroundColor: ColorsOf().backGround(),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

              child: Column(
                children: [
                  Container(
                    height: 100,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(top:5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:EdgeInsets.only(left: 5,right: 5),
                                  child: Text("Company>Service>Bureau>Emplacement" , style: TextStyle(color : ColorsOf().importField() ,fontSize: 10 ,fontWeight: FontWeight.normal , fontStyle:FontStyle.italic),),
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
                                            style: TextStyle(color : ColorsOf().primaryBackGround() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(text:"100",
                                            style: TextStyle(color : ColorsOf().containerThings() ,fontSize: 14 ,fontWeight: FontWeight.bold),
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
                                            style: TextStyle(color : ColorsOf().primaryBackGround() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(text:"23",
                                            style: TextStyle(color : ColorsOf().containerThings() ,fontSize: 14 ,fontWeight: FontWeight.bold),
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
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 10,
                          itemExtent: 100,
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
                                  title: Text(
                                    "Code à Barre : ",
                                    style: TextStyle(fontSize: 16.0,color:ColorsOf().containerThings(),fontWeight: FontWeight.bold),
                                  ),
                                  subtitle:Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(top: 5),
                                    child:Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "ID de Produit : ",
                                          style: TextStyle(fontSize: 14.0,color:ColorsOf().containerThings()),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Quantité : ",
                                          style: TextStyle(fontSize: 14.0,color:ColorsOf().containerThings()),
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
                  ),
                ],
              ),
            ),
          );

        });

  }
}
