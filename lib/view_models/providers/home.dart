import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/models/variables_define/my_flutter_app_icons.dart';
import 'package:scanapp/view_models/providers/main.dart';
import 'package:scanapp/view_models/providers/process_on_file.dart';
import 'package:scanapp/view_models/providers/scanner.dart';
import 'package:scanapp/views/log_in.dart';
import 'package:scanapp/views/scanner.dart';
import 'package:scanapp/views/search.dart';


class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({required this.page})
      : super(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation,) => page,
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child,) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}


class HomeProvider extends ChangeNotifier{
  static  HomeProvider? _instance;
  HomeProvider._();
  factory HomeProvider() => _instance ??=HomeProvider._();

  int numOfSelecter = 0;
  List<int> popOld = <int>[];

  bool bigger = false;
  bool isStateAdmin = false;

  dynamic param;

  TextEditingController searchItem = new TextEditingController();



   void onPressedButton(context){
     Navigator.push(context, FadeRoute(page: Search()));
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

  void setSelector(num,[params]){
      if(num != null){
        popOld.add(numOfSelecter);
        numOfSelecter = num;
        this.param = params;
        if(numOfSelecter == 2) ScannerProvider().clearVars();
        print("Set Selector ==== :");
        print(popOld);
      }else{ numOfSelecter = 0;}

  }


  void changeSelecter(int num, context,path){
    numOfSelecter = num;
    if(numOfSelecter == 2) ScannerProvider().clearVars();
    notifyListeners();
  }

  FocusNode focusNode = new FocusNode();

  AppBar customAppBar(context,scaffoldKey){
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
           onPressed: () => this.onPressedButton(context),
         ),

       ],
     );
  }

  Drawer customDrawer(context,num){

    if(num != null){

      numOfSelecter = num;
      if(numOfSelecter == 2) ScannerProvider().clearVars();
     }else{ numOfSelecter = 0;}

    var image =(MainProvider().user!=null && MainProvider().user!.logoImage != null && MainProvider().user!.logoImage != "Empty")? MainProvider().user!.logoImage : null;

    return Drawer(
      child: Container(
        color: ColorsOf().primaryBackGround(),
        child: ListView(

          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: ColorsOf().containerThings()),
              accountName: Text((isStateAdmin)?"Administrateur":"Ouvrier" , style: TextStyle(color: ColorsOf().primaryBackGround()),),
              accountEmail: Text(((MainProvider().user!=null && MainProvider().user!.logoName!=null)?MainProvider().user!.logoName.toString():""),style: TextStyle(color: ColorsOf().primaryBackGround()),),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  child: (image!=null)? new Image.memory(image):Container(),
                  backgroundColor:(image!=null)? Colors.transparent :  ColorsOf().primaryBackGround(),
                ),
              ),
            ),
            Container(
              color: colorBox(0),
              alignment: Alignment.topCenter,
              height: 50,
              child: ListTile(
                onTap:(){
                  //HomeProvider().setSelector(0);
                  Navigator.pop(context);

                  var route = ModalRoute.of(context);
                  if(route!=null){
                    print(route.settings.name);

                    if(route.settings.name != "/home" && route.settings.name != "/inventoryList")Navigator.pushNamed(context, "/home");

                  }


                },
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
                onTap:(){
                       //   HomeProvider().setSelector(1);
                          Navigator.pop(context);
                          var route = ModalRoute.of(context);
                          if(route!=null){

                            print(route.settings.name);

                            if(route.settings.name != "/listItems")Navigator.pushNamed(context, "/listItems");

                          }

                      },//=>changeSelecter(1,context,"/listItems"), //(){ /*Navigator.popAndPushNamed(context, "/profile"); */},
                leading: Icon(Icons.format_list_bulleted_rounded, size: 20,color: colorText(1),),
                title: Align(
                    alignment: Alignment(-1.2, -0.1),
                    child: Text("Afficher Les Produits", style: TextStyle(color:colorText(1),fontSize: 14 ),)),
              ),
            ),
            Container(
              color: colorBox(3),
              height: 50,
              child : ListTile(
                onTap:(){
                  Navigator.pop(context);
                  ProcessFileProvider().showDialogToProcess(context, "import");
                  },
                leading: Icon(MyFlutterApp.import_second,size: 20,color: colorText(3),),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Importer fichier", style: TextStyle(color: colorText(3),fontSize: 14 ),)),
              ),
            ),
            (MainProvider().user!.productLotsTable != "Empty")?Container(
              color: colorBox(4),
              height: 50,
              child: ListTile(
              onTap:(){
                Navigator.pop(context);
                ProcessFileProvider().showDialogToProcess(context, "update");},// (){ /*Navigator.pushNamed(context, "/news"); */},
                leading: Icon(MyFlutterApp.update,size: 20,color: colorText(4),),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Mettre à jour fichier", style: TextStyle(color: colorText(4),fontSize: 14 ),)),
              ),
            ):Container(),
            Container(
              color: colorBox(5),
              height: 50,
              child: ListTile(
                onTap:(){

                  Navigator.pop(context);
                  var route = ModalRoute.of(context);
                  if(route!=null){
                    print(route.settings.name);

                    if(route.settings.name !="/report")Navigator.pushNamed(context, "/report");

                  }


                },
                leading:Icon(MyFlutterApp.repport,size: 20,color: colorText(5),),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Rapport", style: TextStyle(color: colorText(5),fontSize: 14 ),)),
              ),
            ),
            Container(
              color: colorBox(6),
              height: 50,
              child: ListTile(
                onTap: (){
                  Navigator.pop(context);
                  var route = ModalRoute.of(context);
                  if(route!=null){
                    print(route.settings.name);

                    if(route.settings.name !="/export")Navigator.pushNamed(context, "/export");

                  }

                },
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
                onTap: (){

                  Navigator.pop(context);
                  var route = ModalRoute.of(context);
                  if(route!=null){
                    print(route.settings.name);

                    if(route.settings.name !="/settings")Navigator.pushNamed(context, "/settings");

                  }


                },
                leading: Icon(Icons.settings, color: colorText(7),size: 20,),
                title: Align(alignment: Alignment(-1.2, -0.1),
                    child: Text("Paramètres", style: TextStyle(color:colorText(7),fontSize: 14 ),)),
              ),
            ),
            Container(
              color: colorBox(8),
              height: 50,
              child: ListTile(
                onTap:(){
                Navigator.pop(context);
                showDialogLogOut(context);
                },
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
       onPressed:(){

         Navigator.push(context, FadeRoute(page: Scanner()));


       }
     );
  }


  Future<void> showDialogLogOut(BuildContext context) async {

    String title = "Deconnecter";

    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return   Center(
            child: SingleChildScrollView(

              child: AlertDialog(
                backgroundColor:ColorsOf().primaryBackGround(),
                elevation: 1,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                content: Text("Voulez-vous vraiment "+title.toLowerCase()+" ?", style: TextStyle(color: ColorsOf().containerThings(),fontSize:14,),),
                title: Text(title,style: TextStyle(color: ColorsOf().containerThings() ),),
                actions: <Widget>[

                  MaterialButton(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    highlightElevation: 0,
                    elevation: 0,
                    focusElevation: 0,
                    hoverElevation: 0,

                    color:ColorsOf().containerThings() ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.all(0),
                    child: Text(title,style: TextStyle(color: ColorsOf().primaryBackGround()),),


                    onPressed:(){

                      Navigator.pop(context);
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>LogIn(),
                        ),
                      );

                    }

                  ),

                   SizedBox(width: 50,),


                  MaterialButton(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    highlightElevation: 0,
                    elevation: 0,
                    focusElevation: 0,
                    hoverElevation: 0,
                    child: Text('Cancel',style:TextStyle(color: ColorsOf().containerThings() )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );

        });


  }

}
