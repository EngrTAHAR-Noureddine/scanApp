import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/repport.dart';

class Repport extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Consumer<RepportProvider>(
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
                                            style: TextStyle(color : ColorsOf().borderContainer() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(text:"100",
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
                                          TextSpan(text:"23",
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
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 10,
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
                                  title:  RichText(
                                      text: TextSpan(children: [

                                        TextSpan(text:"Emplacement : ",
                                          style: TextStyle(color : ColorsOf().profilField() ,fontSize: 16 ,fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text:"100",
                                          style: TextStyle(color : ColorsOf().backGround() ,fontSize: 16 ,fontWeight: FontWeight.bold),
                                        ),

                                      ])
                                  ),
                                  subtitle:Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(top: 5),
                                    child:Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: RichText(
                                              text: TextSpan(children: [

                                                TextSpan(text:"Total : ",
                                                  style: TextStyle(color : ColorsOf().profilField() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                ),
                                                TextSpan(text:"100",
                                                  style: TextStyle(color : ColorsOf().backGround() ,fontSize: 14 ,fontWeight: FontWeight.normal),
                                                ),

                                              ])
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          alignment: Alignment.topLeft,
                                            child: RichText(
                                                text: TextSpan(children: [

                                                  TextSpan(text:"Scan : ",
                                                    style: TextStyle(color : ColorsOf().profilField() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),
                                                  TextSpan(text:"23",
                                                    style: TextStyle(color : ColorsOf().backGround() ,fontSize: 14 ,fontWeight: FontWeight.normal),
                                                  ),

                                                ])
                                            )
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
