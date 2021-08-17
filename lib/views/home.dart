import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/models/variables_define/my_flutter_app_icons.dart';
import 'package:scanapp/view_models/providers/home.dart';
import 'package:scanapp/views/inventories_list.dart';

class Home extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]
    );


    ColorsOf().mode(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:Theme.of(context).primaryColorBrightness,
    )
    );

    return Consumer<HomeProvider>(
        builder: (context, value, child) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
             backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness:Theme.of(context).primaryColorBrightness,
              ),

              brightness: Theme.of(context).primaryColorBrightness,

              backgroundColor: ColorsOf().backGround(),
              leading: IconButton(
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
                icon: Icon(Icons.menu , color: ColorsOf().primaryBackGround(),),
              ),
              elevation: 0,
              actions: [
               IconButton(
                  icon: Icon(
                    Icons.search,
                    color: ColorsOf().primaryBackGround(),
                  ),
                  onPressed: () => value.onPressedButton(),
                ),
               AnimatedContainer(
                  width: !value.bigger ? 0 : MediaQuery.of(context).size.width * 0.70,
                  margin: EdgeInsets.only(right: !value.bigger ? 10 : 10),
                  color: Colors.transparent,
                  child: TextField(
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14, color: ColorsOf().borderContainer()),
                    maxLines: 1,
                    maxLength: 100,
                    showCursor: true,
                    onTap: () {},
                    onChanged: (value) { },
                    controller: value.searchItem,
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
            ),
            drawer: Drawer(
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
                      color: value.colorBox(0),
                      alignment: Alignment.topCenter,
                      height: 50,
                      child: ListTile(
                        onTap:()=>value.changeSelecter(0,context, "/profile"), //(){Navigator.popAndPushNamed(context, "/home");},
                        leading: Icon(Icons.home, color: value.colorText(0),size: 20,),
                        title: Align(
                            alignment: Alignment(-1.2, -0.1),
                            child: Text("Home" , style: TextStyle(color: value.colorText(0),fontSize: 14 ),)
                        ),
                      ),
                    ),
                    Container(
                      color: value.colorBox(8),
                      height: 50,
                      child: ListTile(
                        onTap:()=>value.changeSelecter(8,context, "/onGoingList"), //(){ /*Navigator.popAndPushNamed(context, "/profile"); */},
                        leading: Icon(Icons.format_list_bulleted_rounded, size: 20,color: value.colorText(8),),
                        title: Align(
                            alignment: Alignment(-1.2, -0.1),
                            child: Text("Afficher List", style: TextStyle(color:value.colorText(8),fontSize: 14 ),)),
                      ),
                    ),
                    Container(
                      color: value.colorBox(1),
                      height: 50,
                      child: ListTile(
                        onTap:()=>value.changeSelecter(1,context, "/home"), //(){ /*Navigator.popAndPushNamed(context, "/profile"); */},
                        leading: Icon(MyFlutterApp.qr_code,size: 20,color: value.colorText(1),),
                        title: Align(alignment: Alignment(-1.2, -0.1),
                            child: Text("Scanner", style: TextStyle(color:value.colorText(1),fontSize: 14 ),)),
                      ),
                    ),
                    Container(
                      color: value.colorBox(2),
                      height: 50,
                      child : ListTile(
                      onTap:()=>value.changeSelecter(2,context, "/home"), //(){ /*Navigator.pushNamed(context, "/news"); */},
                      leading: Icon(MyFlutterApp.import_second,size: 20,color: value.colorText(2),),
                      title: Align(alignment: Alignment(-1.2, -0.1),
                          child: Text("Importer fichier", style: TextStyle(color: value.colorText(2),fontSize: 14 ),)),
                    ),),
                    Container(
                      color: value.colorBox(3),
                      height: 50,
                      child: ListTile(
                        onTap:()=>value.changeSelecter(3,context, "/home"),// (){ /*Navigator.pushNamed(context, "/news"); */},
                        leading: Icon(MyFlutterApp.update,size: 20,color: value.colorText(3),),
                        title: Align(alignment: Alignment(-1.2, -0.1),
                            child: Text("Mettre à jour fichier", style: TextStyle(color: value.colorText(3),fontSize: 14 ),)),
                      ),
                    ),
                    Container(
                       color: value.colorBox(4),
                      height: 50,
                      child: ListTile(
                        onTap: ()=>value.changeSelecter(4,context, "/home"),//(){ /* Navigator.pushNamed(context, "/news"); */},
                        leading:Icon(MyFlutterApp.repport,size: 20,color: value.colorText(4),),
                        title: Align(alignment: Alignment(-1.2, -0.1),
                            child: Text("Rapport", style: TextStyle(color: value.colorText(4),fontSize: 14 ),)),
                      ),
                    ),
                    Container(
                      color: value.colorBox(5),
                      height: 50,
                      child: ListTile(
                        onTap: ()=>value.changeSelecter(5,context, "/home"),// (){ /*Navigator.pushNamed(context, "/news"); */ },
                        leading: Icon(MyFlutterApp.export_icon,size: 20,color: value.colorText(5),),
                        title: Align(alignment: Alignment(-1.2, -0.1),
                            child: Text("Exporter fichier", style: TextStyle(color:value.colorText(5),fontSize: 14 ),)),
                      ),
                    ),
                    Divider(
                      color: ColorsOf().containerThings(),


                    ),

                    Container(
                      color: value.colorBox(6),
                      height: 50,
                      child: ListTile(
                        onTap: ()=>value.changeSelecter(6,context, "/home"),
                        leading: Icon(Icons.settings, color: value.colorText(6),size: 20,),
                        title: Align(alignment: Alignment(-1.2, -0.1),
                            child: Text("Paramètres", style: TextStyle(color:value.colorText(6),fontSize: 14 ),)),
                      ),
                    ),
                    Container(
                      color: value.colorBox(7),
                      height: 50,
                      child: ListTile(
                        onTap:  ()=>value.changeSelecter(7,context, "/home"),
                        leading: Icon(MyFlutterApp.logout,size: 20,color: value.colorText(7),),
                        title: Align(alignment: Alignment(-1.2, -0.1),
                            child: Text("Se déconnecter",style: TextStyle(color:value.colorText(7),fontSize: 14 ),)),
                      ),
                    )
                  ],
                ),
              ),
            ),
            body:value.changeSelecterActivity(6),
            floatingActionButton: FloatingActionButton(
                    backgroundColor: ColorsOf().containerThings(),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side:BorderSide(color: ColorsOf().primaryBackGround(),width: 1,style:BorderStyle.solid)),

                    child: Icon(MyFlutterApp.qr_code,size: 30,color: ColorsOf().primaryBackGround(),),
                    onPressed: (){},
            ),
          );
        }
      );
  }
}
