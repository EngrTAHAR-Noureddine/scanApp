import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/models/variables_define/my_flutter_app_icons.dart';
import 'package:scanapp/view_models/providers/home.dart';

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
            body:value.changeSelecterActivity(8),

/*
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
            drawer: value.drawerApp(context),
            floatingActionButton: FloatingActionButton(
              backgroundColor: ColorsOf().containerThings(),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side:BorderSide(color: ColorsOf().primaryBackGround(),width: 1,style:BorderStyle.solid)),

              child: Icon(MyFlutterApp.qr_code,size: 30,color: ColorsOf().primaryBackGround(),),
              onPressed: (){},
            ),

*/



          );
        }
      );
  }
}
