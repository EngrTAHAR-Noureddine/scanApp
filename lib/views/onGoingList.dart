import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/onGoing_list.dart';

class OnGoingLists extends StatelessWidget {

  bool isPortrait = false;
  @override
  Widget build(BuildContext context) {
    return  Consumer<OnGoingListProvider>(
        builder: (context, value, child) {

          return Scaffold(
            backgroundColor: ColorsOf().backGround(),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                        title: Text(
                          "Name : ",
                          style: TextStyle(fontSize: 14.0,color:ColorsOf().containerThings()),
                        ),
                        tileColor:ColorsOf().primaryBackGround(),
                        onTap: (){},
                      )
                    );
                  }),
            ),
          );

        });

  }
}
