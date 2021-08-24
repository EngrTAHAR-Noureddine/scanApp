import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/database_models/product_lots.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/home.dart';
import 'package:scanapp/view_models/providers/onGoing_list.dart';
import 'package:scanapp/views/item_information.dart';

class OnGoingListInventory extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  Consumer<OnGoingListProvider>(
        builder: (context, value, child) {

          return Scaffold(
            key: scaffoldKey,
            backgroundColor: ColorsOf().backGround(),
            appBar: HomeProvider().customAppBar(context,scaffoldKey),
            drawer: HomeProvider().customDrawer(context,10),
            floatingActionButton:HomeProvider().customFAB(context),
            body: RefreshIndicator(
              onRefresh: ()async{
                value.setState();

              },
              child: FutureBuilder(
                  future: value.getAllLines(),
                  builder: (context, snapshot) {


                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                      List<ProductLot> list = snapshot.data as List<ProductLot>;


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

                                            onPressed:(){
                                              Navigator.push(context, FadeRoute(page: ItemInfo(idProduct: list[index].productId,)));
                                            }, //()=>HomeProvider().setSelector(11,list[index].productId),

                                          ),),
                                        title: RichText(
                                            text: TextSpan(children: [

                                              TextSpan(text:"Code à barre : ",
                                                style: TextStyle(color : ColorsOf().profilField() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                              ),
                                              TextSpan(text:(list[index].numLot!=null)?list[index].numLot.toString():"-----",
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

                                                      TextSpan(text:"Numéro de série : ",
                                                        style: TextStyle(color : ColorsOf().profilField() ,fontSize: 12 ,fontWeight: FontWeight.bold),
                                                      ),
                                                      TextSpan(text:(list[index].numSerie!=null)?list[index].numSerie:"-----",
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

                                                      TextSpan(text:"Immatriculation : ",
                                                        style: TextStyle(color : ColorsOf().profilField() ,fontSize: 12 ,fontWeight: FontWeight.bold),
                                                      ),
                                                      TextSpan(text:(list[index].immatriculation!=null)?list[index].immatriculation:"-----",
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
          );

        });

  }
}
