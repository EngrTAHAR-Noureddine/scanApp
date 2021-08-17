import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/onGoing_list.dart';

class OnGoingLists extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Consumer<OnGoingListProvider>(
        builder: (context, value, child) {

          return Scaffold(
            backgroundColor: ColorsOf().backGround(),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

              child: Column(
               children:[
                 Container(
                   height: 50,
                   color: ColorsOf().backGround(),
                   child:Container(
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
                 ),
                 Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
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
                                title:  RichText(
                                    text: TextSpan(children: [

                                      TextSpan(text:"Name : ",
                                        style: TextStyle(color : ColorsOf().profilField() ,fontSize: 16 ,fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text:"100",
                                        style: TextStyle(color : ColorsOf().backGround() ,fontSize: 16 ,fontWeight: FontWeight.bold),
                                      ),

                                    ])
                                ),
                                tileColor:ColorsOf().primaryBackGround(),
                                onTap: (){},
                              )
                            );
                          }),
                    ),
              ),
          ]
              ),
            ),
          );

        });

  }
}
