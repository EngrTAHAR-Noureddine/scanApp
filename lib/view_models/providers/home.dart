import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/models/variables_define/my_flutter_app_icons.dart';
import 'package:scanapp/view_models/providers/main.dart';
import 'package:scanapp/view_models/providers/process_on_file.dart';
import 'package:scanapp/views/exports_list.dart';
import 'package:scanapp/views/home.dart';
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
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool bigger = false;
  TextEditingController searchItem = new TextEditingController();

   void onPressedButton(){
    bigger = !bigger;

    notifyListeners();
  }
  setState(){
     notifyListeners();
  }

  Color colorBox(int num){

    return (num == numOfSelecter)?ColorsOf().profilField():ColorsOf().primaryBackGround();
  }
  Color colorText(int num){

    return (num == numOfSelecter)?ColorsOf().primaryBackGround():ColorsOf().containerThings();
  }


  void changeSelecter(int num, context,path){
    numOfSelecter = num;
    this.scaffoldKey.currentState!.openEndDrawer();
    //Navigator.pushNamed(context, path);
    notifyListeners();
  }

  Widget changeSelecterActivity(){
    // put numselected
    List<dynamic> listWidgets = [InventoryList(),ListItems(),Scanner(),ImportNewerFile(),ImportNewerFile(),Repport(),Export(),
    Settings(),ImportNewerFile(),Search(),OnGoingLists()];
    return listWidgets[numOfSelecter];


  }


  AppBar customAppBar(context){
     return AppBar(
       backwardsCompatibility: false,
       systemOverlayStyle: SystemUiOverlayStyle(
         statusBarColor: Colors.transparent,
         statusBarIconBrightness:Theme.of(context).primaryColorBrightness,
       ),

       brightness: Theme.of(context).primaryColorBrightness,

       backgroundColor: ColorsOf().backGround(),
       leading: IconButton(
         onPressed: () => scaffoldKey.currentState!.openDrawer(),
         icon: Icon(Icons.menu , color: ColorsOf().primaryBackGround(),),
       ),
       elevation: 0,
       actions: [
         IconButton(
           icon: Icon(
             Icons.search,
             color: ColorsOf().primaryBackGround(),
           ),
           onPressed: () => this.onPressedButton(),
         ),
         AnimatedContainer(
           width: !HomeProvider().bigger ? 0 : MediaQuery.of(context).size.width * 0.70,
           margin: EdgeInsets.only(right: !HomeProvider().bigger ? 10 : 10),
           color: Colors.transparent,
           child: TextField(
             textAlign: TextAlign.left,
             style: TextStyle(fontSize: 14, color: ColorsOf().borderContainer()),
             maxLines: 1,
             maxLength: 100,
             showCursor: true,
             onTap: () {},
             onChanged: (value) { },
             controller: this.searchItem,
             autofocus: false,
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
     );
  }

  Drawer customDrawer(context){
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
                onTap:()=>changeSelecter(0,context,"/inventoryList"), //(){Navigator.popAndPushNamed(context, "/home");},
                leading: Icon(Icons.home, color: colorText(0),size: 20,),
                title: Align(
                    alignment: Alignment(-1.2, -0.1),
                    child: Text("Home" , style: TextStyle(color: colorText(0),fontSize: 14 ),)
                ),
              ),
            ),
            Container(
              color: colorBox(1),
              height: 50,
              child: ListTile(
                onTap:()=>changeSelecter(1,context,"/listItems"), //(){ /*Navigator.popAndPushNamed(context, "/profile"); */},
                leading: Icon(Icons.format_list_bulleted_rounded, size: 20,color: colorText(1),),
                title: Align(
                    alignment: Alignment(-1.2, -0.1),
                    child: Text("Afficher List", style: TextStyle(color:colorText(1),fontSize: 14 ),)),
              ),
            ),
            Container(
              color: colorBox(2),
              height: 50,
              child: ListTile(
                onTap:()=>changeSelecter(2,context,"/scanner"), //(){ /*Navigator.popAndPushNamed(context, "/profile"); */},
                leading: Icon(MyFlutterApp.qr_code,size: 20,color: colorText(2),),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Scanner", style: TextStyle(color:colorText(2),fontSize: 14 ),)),
              ),
            ),
            Container(
              color: colorBox(3),
              height: 50,
              child : ListTile(
                onTap:()=>ProcessFileProvider().showDialogToProcess(context, "import"), //(){ /*Navigator.pushNamed(context, "/news"); */},
                leading: Icon(MyFlutterApp.import_second,size: 20,color: colorText(3),),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Importer fichier", style: TextStyle(color: colorText(3),fontSize: 14 ),)),
              ),),
            (MainProvider().user!.productLotsTable != "Empty")?Container(
              color: colorBox(4),
              height: 50,
              child: ListTile(
                onTap:()=>ProcessFileProvider().showDialogToProcess(context, "update"),// (){ /*Navigator.pushNamed(context, "/news"); */},
                leading: Icon(MyFlutterApp.update,size: 20,color: colorText(4),),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Mettre à jour fichier", style: TextStyle(color: colorText(4),fontSize: 14 ),)),
              ),
            ):Container(),
            Container(
              color: colorBox(5),
              height: 50,
              child: ListTile(
                onTap: ()=>changeSelecter(5,context,"/report"),//(){ /* Navigator.pushNamed(context, "/news"); */},
                leading:Icon(MyFlutterApp.repport,size: 20,color: colorText(5),),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Rapport", style: TextStyle(color: colorText(5),fontSize: 14 ),)),
              ),
            ),
            Container(
              color: colorBox(6),
              height: 50,
              child: ListTile(
                onTap: ()=>changeSelecter(6,context,"/export"),// (){ /*Navigator.pushNamed(context, "/news"); */ },
                leading: Icon(MyFlutterApp.export_icon,size: 20,color: colorText(6),),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Exporter fichier", style: TextStyle(color:colorText(6),fontSize: 14 ),)),
              ),
            ),
            Divider(
              color: ColorsOf().containerThings(),


            ),

            Container(
              color: colorBox(7),
              height: 50,
              child: ListTile(
                onTap: ()=>changeSelecter(7,context,"/settings"),
                leading: Icon(Icons.settings, color: colorText(7),size: 20,),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Paramètres", style: TextStyle(color:colorText(7),fontSize: 14 ),)),
              ),
            ),
            Container(
              color: colorBox(8),
              height: 50,
              child: ListTile(
                onTap:  ()=>changeSelecter(8,context,"/logout"),
                leading: Icon(MyFlutterApp.logout,size: 20,color: colorText(8),),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Se déconnecter",style: TextStyle(color:colorText(8),fontSize: 14 ),)),
              ),
            )
          ],
        ),
      ),
    );
  }

  FloatingActionButton customFAB(context){
     return FloatingActionButton(
       backgroundColor: ColorsOf().containerThings(),
       elevation: 2,
       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(100),
           side:BorderSide(color: ColorsOf().primaryBackGround(),width: 1,style:BorderStyle.solid)),

       child: Icon(MyFlutterApp.qr_code,size: 30,color: ColorsOf().primaryBackGround(),),
       onPressed: ()=>this.changeSelecter(2, context,"/scanner"),
     );
  }


}
