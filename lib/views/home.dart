import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/home.dart';

class Home extends StatelessWidget {


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
          return (![2].contains(value.numOfSelecter)) ?
          Scaffold(
            resizeToAvoidBottomInset: false,
            key: value.scaffoldKey,
            body:HomeProvider().changeSelecterActivity(),

            appBar: value.customAppBar(context),
            drawer: HomeProvider().customDrawer(context),


            floatingActionButton:HomeProvider().customFAB(context),




          ):
          Scaffold(
            resizeToAvoidBottomInset: false,
            key: value.scaffoldKey,
            body:HomeProvider().changeSelecterActivity(),


          );
        }
      );
  }
}
