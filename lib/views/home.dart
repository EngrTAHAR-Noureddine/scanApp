import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/home.dart';
import 'package:scanapp/views/inventories_list.dart';

class Home extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]
    );


    ColorsOf().mode(context: context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:Theme.of(context).primaryColorBrightness,
    )
    );

    return Consumer<HomeProvider>(
        builder: (context, value, child) {
          return InventoryList();
          /*
          return (![2].contains(value.numOfSelecter)) ?
          WillPopScope(
            onWillPop: () async{
              print("Before WillPopScope ==== :");
 /*             print(value.popOld);
              if(value.popOld.length>1){
                                          value.numOfSelecter  = value.popOld.removeLast();
                                          //value.setState();
                                          print("after click WillPopScope ==== :");
                                          print(value.popOld);
                                          Navigator.pop(context);
                                          }else{  Navigator.of(context).pop(null);}
*/
              Navigator.pop(context);
              return false;
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: scaffoldKey,
              body:HomeProvider().changeSelecterActivity(),

              appBar: value.customAppBar(context,scaffoldKey),
              drawer: HomeProvider().customDrawer(context),


              floatingActionButton:HomeProvider().customFAB(context),




            ),
          ):
          WillPopScope(
            onWillPop: () async{
              if(value.popOld.isNotEmpty){ value.setSelector(value.popOld.removeLast());  }
              Navigator.pop(context);
              return false;
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: scaffoldKey,
              body:HomeProvider().changeSelecterActivity(),


            ),
          );
          */

        }
      );
  }
}
