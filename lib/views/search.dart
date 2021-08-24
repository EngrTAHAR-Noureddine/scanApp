import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/database_models/product_lots.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/home.dart';
import 'package:scanapp/view_models/providers/search.dart';
import 'package:flutter/services.dart';
import 'package:scanapp/views/item_information.dart';
class Search extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
        builder: (context, value, child) {

          return Scaffold(
            key: scaffoldKey,
            backgroundColor: ColorsOf().backGround(),
            appBar: AppBar(
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness:Theme.of(context).primaryColorBrightness,
              ),

              brightness: Theme.of(context).primaryColorBrightness,

              backgroundColor: ColorsOf().backGround(),
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back , color: ColorsOf().primaryBackGround(),),
              ),
              elevation: 0,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: ColorsOf().primaryBackGround(),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                AnimatedContainer(
                  width:  MediaQuery.of(context).size.width * 0.70,
                  margin: EdgeInsets.only(right: !HomeProvider().bigger ? 10 : 10),
                  color: Colors.transparent,
                  child: TextField(
                    readOnly: false,
                    //focusNode: MainProvider().getCurrentFocus(context),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14, color: ColorsOf().borderContainer()),
                    maxLines: 1,
                    maxLength: 100,
                    showCursor: true,

                    onChanged: (value){

                      SearchProvider().onSearch(value);

                    },
                    //(value){setSelector(9);SearchProvider().onSearch(value);},
                    controller: value.searchWord,
                    autofocus: true,
                    minLines: 1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorsOf().primaryBackGround(),
                              style: BorderStyle.solid,
                              width: 1
                          )
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorsOf().primaryBackGround(),
                              style: BorderStyle.solid,
                              width: 2
                          )
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorsOf().primaryBackGround(),
                              style: BorderStyle.solid,
                              width: 1
                          )
                      ),
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorsOf().deleteItem(),
                              style: BorderStyle.solid,
                              width: 1
                          )
                      ),
                      //isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      alignLabelWithHint: false,
                      labelText: null,

                      counterStyle: TextStyle(
                        height: double.minPositive,
                      ),
                      counterText: "",
                      hintText: "Rechercher...",
                      hintStyle: TextStyle(color: ColorsOf().importField()),

                    ),
                    toolbarOptions: ToolbarOptions(
                      cut: true,
                      copy: true,
                      selectAll: true,
                      paste: true,
                    ),
                  ),
                  duration: Duration(milliseconds: 150),
                ) ,
              ],
            ),
            body: FutureBuilder(
              future: value.getList(),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {
               //   if(snapshot.hasData){
                  List<ProductLot> list = snapshot.data as List<ProductLot>;


                  if(list.isNotEmpty){
                    return  Container(
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
                                        },
                                      ),),
                                    title: RichText(
                                        text: TextSpan(children: [

                                          TextSpan(text:"Code à Barre : ",
                                            style: TextStyle(color : ColorsOf().profilField() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(text:list[index].numLot,
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

                                                  TextSpan(text:"ID de Produit : ",
                                                    style: TextStyle(color : ColorsOf().profilField() ,fontSize: 12 ,fontWeight: FontWeight.bold),
                                                  ),
                                                  TextSpan(text:list[index].productId.toString(),
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

                                                  TextSpan(text:"Numéro de série : ",
                                                    style: TextStyle(color : ColorsOf().profilField() ,fontSize: 12 ,fontWeight: FontWeight.bold),
                                                  ),
                                                  TextSpan(text:list[index].numSerie,
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
                      );

                  }else{
                    return Container(
                      color:ColorsOf().backGround(),
                      alignment: Alignment.center,
                      child: Text("Pas Trouver" , style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize: 20),),
                    );
                  }

                }else if(snapshot.connectionState == ConnectionState.waiting){
                  return Container(
                    color:ColorsOf().backGround(),
                    alignment: Alignment.center,
                    child: Text("Rechercher..." , style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize: 20),),
                  );
                }else{
                  return Container(
                  color:ColorsOf().backGround(),
                  alignment: Alignment.center,
                  child: Text("Pas Trouver" , style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize: 20),),
                );
                }


              }
            ),
          );

        });

  }
}
