import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/settings.dart';
import 'package:scanapp/models/custom_expansion_tile.dart' as custom;
class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
        builder: (context, value, child){
          return Container(
            color: ColorsOf().backGround(),
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [

                  SwitchListTile(
                    activeColor: Colors.blue, //ColorsOf().onGoingItem(),
                    inactiveThumbColor: ColorsOf().importField(),
                    inactiveTrackColor:  ColorsOf().importField(),
                    activeTrackColor: Colors.blue, //ColorsOf().onGoingItem(),
                    title: Text('Dark mode', style: TextStyle(color: ColorsOf().primaryBackGround())),
                    value: value.switches[0],
                    onChanged: (bool val)=>value.toggleMode(val,0),
                    secondary: Icon(Icons.dark_mode_outlined, color:ColorsOf().primaryBackGround() ),
                  ),
                  Container(
                          margin: EdgeInsets.all(5),
                          child:custom.ExpansionTile(
                            iconColor: ColorsOf().primaryBackGround(),
                            backgroundColor: ColorsOf().backGround(),
                            isElevation: false,
                            headerBackgroundColor:ColorsOf().backGround(),
                            leading: Icon(Icons.lock , color: ColorsOf().primaryBackGround(),),

                            title:  Text("Changer mot de passe d'administrateur", style: TextStyle(color: ColorsOf().primaryBackGround())),
                            children: <Widget>[
                              Container(

                                color: Colors.transparent,
                               padding: EdgeInsets.all(10),
                                   child: Column(
                                     children: [
                                       Container(
                                         child: Text("Mot de passe actuel:" ,style:TextStyle(color : ColorsOf().borderContainer() ,fontSize: 14 ,fontWeight: FontWeight.normal)),
                                         alignment: Alignment.centerLeft,
                                         margin: EdgeInsets.all(10),
                                       ),
                                       value.inputCurrentPasswordAdmin(),
                                       SizedBox(height: 10,),
                                       Container(
                                         child: Text("Nouveau mot de passe:" ,style:TextStyle(color : ColorsOf().borderContainer() ,fontSize: 14 ,fontWeight: FontWeight.normal)),
                                         alignment: Alignment.centerLeft,
                                         margin: EdgeInsets.all(10),
                                       ),
                                       value.inputNewPasswordAdmin(),
                                       SizedBox(height: 10,),
                                       Container(
                                         child: Text("Confirmer mot de passe :" ,style:TextStyle(color : ColorsOf().borderContainer() ,fontSize: 14 ,fontWeight: FontWeight.normal)),
                                         alignment: Alignment.centerLeft,
                                         margin: EdgeInsets.all(10),
                                       ),
                                       value.rewritePasswordAdmin(),
                                       SizedBox(height: 10,),
                                        value.buttonConfirmAdmin(context),
                                     ],
                                   ),
                              )
                            ],
                          ),
              ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child:custom.ExpansionTile(
                      iconColor: ColorsOf().primaryBackGround(),
                      backgroundColor: ColorsOf().backGround(),
                      isElevation: false,
                      headerBackgroundColor:ColorsOf().backGround(),
                      leading: Icon(Icons.lock , color: ColorsOf().primaryBackGround(),),

                      title:  Text("Changer mot de passe de client", style: TextStyle(color: ColorsOf().primaryBackGround())),
                      children: <Widget>[
                        Container(

                          color: Colors.transparent,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                child: Text("Mot de passe actuel:" ,style:TextStyle(color : ColorsOf().borderContainer() ,fontSize: 14 ,fontWeight: FontWeight.normal)),
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.all(10),
                              ),
                              value.inputCurrentPasswordClient(),
                              SizedBox(height: 10,),
                              Container(
                                child: Text("Nouveau mot de passe:" ,style:TextStyle(color : ColorsOf().borderContainer() ,fontSize: 14 ,fontWeight: FontWeight.normal)),
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.all(10),
                              ),
                              value.inputNewPasswordClient(),
                              SizedBox(height: 10,),
                              Container(
                                child: Text("Confirmer mot de passe :" ,style:TextStyle(color : ColorsOf().borderContainer() ,fontSize: 14 ,fontWeight: FontWeight.normal)),
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.all(10),
                              ),
                              value.rewritePasswordClient(),
                              SizedBox(height: 10,),
                              value.buttonConfirmClient(context),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),


                ],
              ),
            )



          );
        });
  }
}