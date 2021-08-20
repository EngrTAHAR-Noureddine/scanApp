import 'package:flutter/material.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/main.dart';
import 'package:scanapp/views/log_in.dart';

class GetUserInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MainProvider().createUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {

            return LogIn();


          }else{ return Container(color: ColorsOf().backGround());}

        }
    );
  }
}
