import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/home.dart';

class Home extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                      accountName: Text("Abass Makinde" , style: TextStyle(color: ColorsOf().primaryForGround()),),
                      accountEmail: Text("abs@gmail.com",style: TextStyle(color: ColorsOf().primaryForGround()),),
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
                      onTap: (){},

                      child: Container(
                        color: Colors.blue,
                        child: ListTile(

                          onTap: (){Navigator.popAndPushNamed(context, "/home");},
                          leading: Icon(Icons.home, color: ColorsOf().containerThings(),size: 25,),
                          title: Align(
                              alignment: Alignment(-1.2, 0),
                              child: Text("Home" , style: TextStyle(color: ColorsOf().containerThings(),fontSize: 16 ),)
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: null,
                      child: Container(
                        child: ListTile(
                          onTap: (){Navigator.popAndPushNamed(context, "/profile");},
                          leading: SvgPicture.asset("assets/images/qr_code.svg", semanticsLabel: 'scanner',height: 25,width: 25,color: ColorsOf().containerThings(),),
                          title: Align(alignment: Alignment(-1.2, 0),child: Text("Scanner", style: TextStyle(color: ColorsOf().containerThings(),fontSize: 16 ),)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: null,
                      child: Container(child : ListTile(
                        onTap: (){Navigator.pushNamed(context, "/news");},
                        leading: Icon(Icons.add, color: ColorsOf().containerThings() ,size: 25,),
                        title: Align(alignment: Alignment(-1.2, 0),child: Text("Importer fichier", style: TextStyle(color: ColorsOf().containerThings(),fontSize: 16 ),)),
                      ),),
                    ),
                    InkWell(
                      onTap: null,
                      child: Container(
                        child: ListTile(
                          onTap: (){Navigator.pushNamed(context, "/news");},
                          leading: Icon(Icons.add, color: ColorsOf().containerThings() ,size: 25,),
                          title: Align(alignment: Alignment(-1.2, 0),child: Text("Mettre à jour fichier", style: TextStyle(color: ColorsOf().containerThings(),fontSize: 16 ),)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: null,
                      child: Container(
                        child: ListTile(
                          onTap: (){Navigator.pushNamed(context, "/news");},
                          leading: Icon(Icons.add, color: ColorsOf().containerThings(),size: 25,),
                          title: Align(alignment: Alignment(-1.2, 0),child: Text("Rapport", style: TextStyle(color: ColorsOf().containerThings(),fontSize: 16 ),)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: null,
                      child: Container(
                        child: ListTile(
                          onTap: (){Navigator.pushNamed(context, "/news");},
                          leading: Icon(Icons.add, color: ColorsOf().containerThings(),size: 25,),
                          title: Align(alignment: Alignment(-1.2, 0),child: Text("Exporter fichier", style: TextStyle(color: ColorsOf().containerThings(),fontSize: 16 ),)),
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: null,
                      child: Container(
                        child: ListTile(
                          leading: Icon(Icons.settings, color: ColorsOf().containerThings(),size: 25,),
                          title: Align(alignment: Alignment(-1.2, 0),child: Text("Paramètres", style: TextStyle(color: ColorsOf().containerThings(),fontSize: 16 ),)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: null,
                      child: Container(
                        child: ListTile(
                          leading: Icon(
                            Icons.add,
                            color: ColorsOf().containerThings(),
                            size: 25,
                          ),
                          title: Align(alignment: Alignment(-1.2, 0),child: Text("Se déconnecter",style: TextStyle(color: ColorsOf().containerThings(),fontSize: 16 ),)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: Container(
              color: ColorsOf().backGround(),
            ),
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
