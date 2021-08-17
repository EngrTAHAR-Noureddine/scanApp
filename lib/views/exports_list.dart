import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/exports_list.dart';

class Export extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Consumer<ExportProvider>(
        builder: (context, value, child) {

          return Scaffold(
            backgroundColor: ColorsOf().backGround(),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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

                              onPressed: (){},

                            ),),
                          title: RichText(
                              text: TextSpan(children: [

                                TextSpan(text:"Inventory : ",
                                  style: TextStyle(color : ColorsOf().profilField() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text:"100000",
                                  style: TextStyle(color : ColorsOf().backGround() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                ),

                              ])
                          ),

                          tileColor:ColorsOf().primaryBackGround(),
                          onTap:null,
                        )
                    );
                  }),
            ),
          );

        });

  }
}
