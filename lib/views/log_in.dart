import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/view_models/providers/login.dart';
import 'package:scanapp/models/variables_define/colors.dart';


class LogIn extends StatelessWidget {

//  bool isPortrait =true;

  @override
  Widget build(BuildContext context) {

    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:Theme.of(context).primaryColorBrightness,
    )
    );
    ColorsOf().mode(context);
    return Consumer<LogInProvider>(
        builder: (context, value, child) {
          //return OrientationBuilder(
            //  builder: (context, orientation) {
               // isPortrait =  (orientation == Orientation.portrait);
                return Scaffold(
               /* appBar: AppBar(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: ColorsOf().backGround()

                  ),
                    elevation: 0,
                  //brightness: Theme.of(context).primaryColorBrightness,
                ),*/


                  resizeToAvoidBottomInset: false,
                  backgroundColor: ColorsOf().backGround(),


                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.bottomCenter,

                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [

                        Container(
                          height: MediaQuery.of(context).size.height *2/ 3 ,
                          width: MediaQuery.of(context).size.width ,
                          padding: EdgeInsets.only(top: 50),


                          child: Container(
                            padding: EdgeInsets.only(top: 80),
                            decoration: BoxDecoration(
                              color: ColorsOf().primaryBackGround(),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                            ),
                            child: Form(
                              key: LogInProvider().formKey,
                              child: SingleChildScrollView(
                                padding: EdgeInsets.all(10),
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    LogInProvider().inputPassword(),
                                    SizedBox(height: 10),
                                    LogInProvider().asAdminField(),
                                    SizedBox(height: 10),
                                    LogInProvider().buttonLogIn(context),
                                  ],
                                ),
                              ),
                            )

                          ),

                        ),
                        value.logoWidget(),
                      ],
                    ),
                  ),
                );
             // });
        });
  }
}

