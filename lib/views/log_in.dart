import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/view_models/providers/login.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'dart:convert';

class LogIn extends StatelessWidget {

  var blob ="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";



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
    var image = base64.decode(blob);
    return ChangeNotifierProvider(
      create: (_) => LogInProvider(),
      child: Consumer<LogInProvider>(
          builder: (context, value, child) {

                  return FutureBuilder(
                    future: value.checkLogIn(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                        return Scaffold(



                          resizeToAvoidBottomInset: false,
                          backgroundColor: ColorsOf().backGround(),


                          body: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.bottomCenter,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  height: MediaQuery.of(context).size.height*0.4,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(top: 50,left: 10,right: 10),
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(width: 200,height: 50,color: Colors.green,),
                                        Container(
                                          width: 50,height: 50,color: Colors.transparent,
                                          child: new Image.memory(image),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  child: Stack(
                                    alignment: Alignment.topCenter,

                                    children: [
                                      Container(
                                        height: MediaQuery.of(context).size.height *0.6,
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
                                      LogInProvider().logoWidget(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }else{ return Container(color: ColorsOf().backGround());}

                    }
                  );
               // });
          }),
    );
  }
}

