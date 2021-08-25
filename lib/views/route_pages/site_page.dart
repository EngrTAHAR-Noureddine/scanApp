import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/counter_stocks_in_emplacement.dart';
import 'package:scanapp/models/database_models/site.dart';
import 'package:scanapp/models/database_models/user.dart';
import 'package:scanapp/models/item.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/home.dart';
import 'package:scanapp/view_models/providers/main.dart';
import 'package:scanapp/views/route_pages/company_page.dart';

class ListSites extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<List<Item>> figureSites()async{
    User? user = await MainProvider().getUser();
    List<Item> itemSite = <Item>[];
    if(user!=null){
      if(user.siteTable!="Empty"){

        List<Site> sites = await DBProvider.db.getAllSites();
        if(sites.isNotEmpty){
          sites.forEach((element) {
            Item item = new Item(nameItem: element.nom,idParent: element.id);
            itemSite.add(item);
          });
        }
      } else if(user.companyTable != "Empty"){
        // Looking in Company
        /* Search for Site from company Table */
        List<StocksCounter> sites = await DBProvider.db.getSiteFromCompany();

        if(sites.isNotEmpty){
          sites.forEach((element) {
            Item item = new Item(nameItem:"Site "+element.emplacementID.toString(),idParent: element.emplacementID);
            itemSite.add(item);
          });
        }
      }
    }



    return itemSite.isNotEmpty?itemSite:[];
  }


  @override
  Widget build(BuildContext context) {

    return  FutureBuilder(
              future: figureSites(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!=null) {
                  List<Item> list = snapshot.data as List<Item>;

                  if(list.isNotEmpty){

                    return Scaffold(
                      key: scaffoldKey,
                      backgroundColor: ColorsOf().backGround(),
                      appBar: HomeProvider().customAppBar(context,scaffoldKey),
                      drawer: HomeProvider().customDrawer(context,1),
                      floatingActionButton:HomeProvider().customFAB(context),
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
                                            child: Text("" , style: TextStyle(color : ColorsOf().importField() ,fontSize: 10 ,fontWeight: FontWeight.normal , fontStyle:FontStyle.italic),),
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

                                                    TextSpan(text:"Sites : ",
                                                      style: TextStyle(color : ColorsOf().borderContainer() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                    ),
                                                    TextSpan(text:"",
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
                                child: (list.isNotEmpty)?ListView.builder(
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
                                            leading: Icon(Icons.apartment_outlined, color: ColorsOf().containerThings(),),
                                            title: RichText(
                                                text: TextSpan(children: [

                                                  TextSpan(text:"Nom : ",
                                                    style: TextStyle(color : ColorsOf().profilField() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),
                                                  TextSpan(text:(list[index].nameItem!=null)?list[index].nameItem:index.toString(),
                                                    style: TextStyle(color : ColorsOf().backGround() ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                                  ),

                                                ])
                                            ),
                                            tileColor:ColorsOf().primaryBackGround(),
                                            onTap:(){

                                              List<String> chain = <String>[];
                                              chain.add(list[index].nameItem??"");

                                              Navigator.push(context, FadeRoute(page: ListCompanies(id: list[index].idParent,name: list[index].nameItem,chain: chain,)));
                                            },
                                          )
                                      );
                                    }):ListCompanies(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }else{
                    return ListCompanies();
                  }
                }
                else if(snapshot.connectionState == ConnectionState.waiting){
                  return Scaffold(
                    key: scaffoldKey,
                    backgroundColor: ColorsOf().backGround(),
                    appBar: HomeProvider().customAppBar(context,scaffoldKey),
                    drawer: HomeProvider().customDrawer(context,1),
                    floatingActionButton:HomeProvider().customFAB(context),
                    body: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: Text("Rechercher..." , style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize: 20),),

                        color: ColorsOf().backGround()),
                  );
                }else{
                  return ListCompanies();
                }


              }
          );

  }
}
