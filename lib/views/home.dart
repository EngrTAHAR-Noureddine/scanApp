import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/home.dart';
import 'package:scanapp/views/import_new_file.dart';

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
                    InkWell(
                      onTap: null,

                      child: Container(
                        color: value.colorBox(0),
                        alignment: Alignment.center,
                        height: 50,
                        child: ListTile(

                          onTap:()=>value.changeSelecter(0), //(){Navigator.popAndPushNamed(context, "/home");},
                          leading: Icon(Icons.home, color: value.colorText(0),size: 25,),
                          title: Align(
                              alignment: Alignment(-1.2, 0),
                              child: Text("Home" , style: TextStyle(color: value.colorText(0),fontSize: 16 ),)
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: null,
                      child: Container(
                        color: value.colorBox(8),
                        height: 50,
                        child: ListTile(
                          onTap:()=>value.changeSelecter(8), //(){ /*Navigator.popAndPushNamed(context, "/profile"); */},
                          leading: Icon(Icons.format_list_bulleted_rounded, size: 25,color: value.colorText(8),),
                          title: Align(alignment: Alignment(-1.2, 0),child: Text("Afficher List", style: TextStyle(color:value.colorText(8),fontSize: 16 ),)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: null,
                      child: Container(
                        color: value.colorBox(1),
                        height: 50,
                        child: ListTile(
                          onTap:()=>value.changeSelecter(1), //(){ /*Navigator.popAndPushNamed(context, "/profile"); */},
                          leading: SvgPicture.asset("assets/images/qr_code.svg", semanticsLabel: 'scanner',height: 25,width: 25,color: value.colorText(1),),
                          title: Align(alignment: Alignment(-1.2, 0),child: Text("Scanner", style: TextStyle(color:value.colorText(1),fontSize: 16 ),)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: null,
                      child: Container(
                        color: value.colorBox(2),
                        height: 50,
                        child : ListTile(
                        onTap:()=>value.changeSelecter(2), //(){ /*Navigator.pushNamed(context, "/news"); */},
                        leading: SvgPicture.asset("assets/images/import.svg", semanticsLabel: 'scanner',height: 25,width: 25,color: value.colorText(2),),
                        title: Align(alignment: Alignment(-1.2, 0),child: Text("Importer fichier", style: TextStyle(color: value.colorText(2),fontSize: 16 ),)),
                      ),),
                    ),
                    InkWell(
                      onTap: null,
                      child: Container(
                        color: value.colorBox(3),
                        height: 50,
                        child: ListTile(
                          onTap:()=>value.changeSelecter(3),// (){ /*Navigator.pushNamed(context, "/news"); */},
                          leading: SvgPicture.asset("assets/images/update.svg", semanticsLabel: 'scanner',height: 25,width: 25,color: value.colorText(3),),
                          title: Align(alignment: Alignment(-1.2, 0),child: Text("Mettre à jour fichier", style: TextStyle(color: value.colorText(3),fontSize: 16 ),)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: null,
                      child: Container(
                         color: value.colorBox(4),
                        height: 50,
                        child: ListTile(
                          onTap: ()=>value.changeSelecter(4),//(){ /* Navigator.pushNamed(context, "/news"); */},
                          leading: SvgPicture.asset("assets/images/repport.svg", semanticsLabel: 'scanner',height: 25,width: 25,color: value.colorText(4),),
                          title: Align(alignment: Alignment(-1.2, 0),child: Text("Rapport", style: TextStyle(color: value.colorText(4),fontSize: 16 ),)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap:null,
                      child: Container(
                        color: value.colorBox(5),
                        height: 50,
                        child: ListTile(
                          onTap: ()=>value.changeSelecter(5),// (){ /*Navigator.pushNamed(context, "/news"); */ },
                          leading: SvgPicture.asset("assets/images/export.svg", semanticsLabel: 'scanner',height: 25,width: 25,color:value.colorText(5),),
                          title: Align(alignment: Alignment(-1.2, 0),child: Text("Exporter fichier", style: TextStyle(color:value.colorText(5),fontSize: 16 ),)),
                        ),
                      ),
                    ),
                    Divider(
                      color: ColorsOf().containerThings(),


                    ),

                    InkWell(
                      onTap: null,
                      child: Container(
                        color: value.colorBox(6),
                        height: 50,
                        child: ListTile(
                          onTap: ()=>value.changeSelecter(6),
                          leading: Icon(Icons.settings, color: value.colorText(6),size: 25,),
                          title: Align(alignment: Alignment(-1.2, 0),child: Text("Paramètres", style: TextStyle(color:value.colorText(6),fontSize: 16 ),)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap:null,
                      child: Container(
                        color: value.colorBox(7),
                        height: 50,
                        child: ListTile(
                          onTap:  ()=>value.changeSelecter(7),
                          leading: SvgPicture.asset("assets/images/exit.svg", semanticsLabel: 'scanner',height: 25,width: 25,color: value.colorText(7),),
                          title: Align(alignment: Alignment(-1.2, 0),child: Text("Se déconnecter",style: TextStyle(color:value.colorText(7),fontSize: 16 ),)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: ImportNewerFile(),
            floatingActionButton: FloatingActionButton(
                    backgroundColor: ColorsOf().primaryBackGround(),
                    child: SvgPicture.asset("assets/images/qr_code.svg", semanticsLabel: 'scanner',height: 25,width: 25,color: ColorsOf().containerThings(),),
                    onPressed: (){},
            ),
          );
        }
      );
  }
}
