import 'package:flutter/material.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/models/variables_define/my_flutter_app_icons.dart';
import 'package:scanapp/views/exports_list.dart';
import 'package:scanapp/views/import_new_file.dart';
import 'package:scanapp/views/inventories_list.dart';
import 'package:scanapp/views/list_of_items.dart';
import 'package:scanapp/views/onGoingList.dart';
import 'package:scanapp/views/repport.dart';
import 'package:scanapp/views/scanner.dart';
import 'package:scanapp/views/search.dart';
import 'package:scanapp/views/settings.dart';

class HomeProvider extends ChangeNotifier{
  static  HomeProvider? _instance;
  HomeProvider._();
  factory HomeProvider() => _instance ??=HomeProvider._();

  int numOfSelecter = 0;

  bool bigger = false;
  TextEditingController searchItem = new TextEditingController();

   void onPressedButton(){
    bigger = !bigger;

    notifyListeners();
  }

  Color colorBox(int num){

    return (num == numOfSelecter)?ColorsOf().profilField():ColorsOf().primaryBackGround();
  }
  Color colorText(int num){

    return (num == numOfSelecter)?ColorsOf().primaryBackGround():ColorsOf().containerThings();
  }


  void changeSelecter(int num, context, path){
    numOfSelecter = num;
    Navigator.popAndPushNamed(context, path);
    //notifyListeners();
  }

  Widget changeSelecterActivity(int num){
    // put numselected
    List<dynamic> listWidgets = [InventoryList(),
      ImportNewerFile(),OnGoingLists(),ListItems(),Repport(),Export(),Settings(),Search(),Scanner()];
    return listWidgets[num];
  }


  Drawer drawerApp(context){
    return Drawer(
      child: Container(
        color: ColorsOf().primaryBackGround(),
        child: ListView(

          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: ColorsOf().containerThings()),
              accountName: Text("Abass Makinde" , style: TextStyle(color: ColorsOf().primaryBackGround()),),
              accountEmail: Text("abs@gmail.com",style: TextStyle(color: ColorsOf().primaryBackGround()),),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  child: Text(
                    "AM",
                    style: TextStyle(
                        color: Colors.pink,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            Container(
              color: colorBox(0),
              alignment: Alignment.topCenter,
              height: 50,
              child: ListTile(
                onTap:()=>changeSelecter(0,context, "/profile"), //(){Navigator.popAndPushNamed(context, "/home");},
                leading: Icon(Icons.home, color: colorText(0),size: 20,),
                title: Align(
                    alignment: Alignment(-1.2, -0.1),
                    child: Text("Home" , style: TextStyle(color: colorText(0),fontSize: 14 ),)
                ),
              ),
            ),
            Container(
              color: colorBox(8),
              height: 50,
              child: ListTile(
                onTap:()=>changeSelecter(8,context, "/onGoingList"), //(){ /*Navigator.popAndPushNamed(context, "/profile"); */},
                leading: Icon(Icons.format_list_bulleted_rounded, size: 20,color: colorText(8),),
                title: Align(
                    alignment: Alignment(-1.2, -0.1),
                    child: Text("Afficher List", style: TextStyle(color:colorText(8),fontSize: 14 ),)),
              ),
            ),
            Container(
              color: colorBox(1),
              height: 50,
              child: ListTile(
                onTap:()=>changeSelecter(1,context, "/home"), //(){ /*Navigator.popAndPushNamed(context, "/profile"); */},
                leading: Icon(MyFlutterApp.qr_code,size: 20,color: colorText(1),),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Scanner", style: TextStyle(color:colorText(1),fontSize: 14 ),)),
              ),
            ),
            Container(
              color: colorBox(2),
              height: 50,
              child : ListTile(
                onTap:()=>changeSelecter(2,context, "/home"), //(){ /*Navigator.pushNamed(context, "/news"); */},
                leading: Icon(MyFlutterApp.import_second,size: 20,color: colorText(2),),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Importer fichier", style: TextStyle(color: colorText(2),fontSize: 14 ),)),
              ),),
            Container(
              color: colorBox(3),
              height: 50,
              child: ListTile(
                onTap:()=>changeSelecter(3,context, "/home"),// (){ /*Navigator.pushNamed(context, "/news"); */},
                leading: Icon(MyFlutterApp.update,size: 20,color: colorText(3),),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Mettre à jour fichier", style: TextStyle(color: colorText(3),fontSize: 14 ),)),
              ),
            ),
            Container(
              color: colorBox(4),
              height: 50,
              child: ListTile(
                onTap: ()=>changeSelecter(4,context, "/home"),//(){ /* Navigator.pushNamed(context, "/news"); */},
                leading:Icon(MyFlutterApp.repport,size: 20,color: colorText(4),),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Rapport", style: TextStyle(color: colorText(4),fontSize: 14 ),)),
              ),
            ),
            Container(
              color: colorBox(5),
              height: 50,
              child: ListTile(
                onTap: ()=>changeSelecter(5,context, "/home"),// (){ /*Navigator.pushNamed(context, "/news"); */ },
                leading: Icon(MyFlutterApp.export_icon,size: 20,color: colorText(5),),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Exporter fichier", style: TextStyle(color:colorText(5),fontSize: 14 ),)),
              ),
            ),
            Divider(
              color: ColorsOf().containerThings(),


            ),

            Container(
              color: colorBox(6),
              height: 50,
              child: ListTile(
                onTap: ()=>changeSelecter(6,context, "/home"),
                leading: Icon(Icons.settings, color: colorText(6),size: 20,),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Paramètres", style: TextStyle(color:colorText(6),fontSize: 14 ),)),
              ),
            ),
            Container(
              color: colorBox(7),
              height: 50,
              child: ListTile(
                onTap:  ()=>changeSelecter(7,context, "/home"),
                leading: Icon(MyFlutterApp.logout,size: 20,color: colorText(7),),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Se déconnecter",style: TextStyle(color:colorText(7),fontSize: 14 ),)),
              ),
            )
          ],
        ),
      ),
    );
  }



}
