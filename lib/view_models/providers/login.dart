import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/views/home.dart';

class LogInProvider extends ChangeNotifier{

  static final LogInProvider _singleton = LogInProvider._internal();
  factory LogInProvider() {
    return _singleton;
  }
  LogInProvider._internal();
/* Variables */
  final formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  bool _switch = false;
/* Provider Functions  */

  inputPassword(){
    return Container(
      color:ColorsOf().primaryBackGround(),
      height:50,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10, right: 10, ),
      child: TextFormField(

        // focusNode: currentFocus,
       /* validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }else if(SettingsProvider().user.passWord == this.passwordController.text){
            return null;
          }else{
            return 'Password is incorrect';
          }

        },*/
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 16,color:ColorsOf().backGround() ),
        maxLines: 1,
        maxLength: 100,
        showCursor: true,
        obscureText: true,
        controller: passwordController,
        autofocus: false,
        minLines: 1,
        keyboardType: TextInputType.text,

        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignLabelWithHint: false,
          labelText: null,
          prefixIcon: Icon(Icons.lock,color: ColorsOf().backGround()),
          counterStyle: TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().containerThings(),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().containerThings(),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().deleteItem(),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          hintText: "Enter password",
          hintStyle: TextStyle(color: ColorsOf().importField()),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().containerThings(),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),

        ),
        toolbarOptions: ToolbarOptions(
          cut: true,
          copy: true,
          selectAll: true,
          paste: true,
        ),
      ),

    );
  }

  asAdminField(){
    return Container(
      color:ColorsOf().primaryBackGround(),
      height:50,
      alignment: Alignment.center,
      child: SwitchListTile(
        activeColor: Colors.blue,
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Colors.grey,
        activeTrackColor: Colors.blue,
        title: Text(
            'Comme Admin', style: TextStyle(color:ColorsOf().backGround() ,fontSize: 16,),
        ),

        value: _switch,
        onChanged: (bool value) async {
          _switch = value;
          notifyListeners();
          /*if (!value) {
            return await SettingsProvider().showDialogToHideGoals(context);
          } else {
            SettingsProvider().user.hideGoal = "yes";
            await DBProvider.db.updateUser(SettingsProvider().user);

            _switches[2] = value;
            SettingsProvider().setState();
          }*/
        },

      ),
    );
  }

  buttonLogIn(context){
    return  Container(
      color:Colors.transparent,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 10),
      child: MaterialButton(
        color: ColorsOf().containerThings(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.all(0),

        minWidth: 150,
        height: 50,
        child: Text("Connecter" ,style: TextStyle(color: ColorsOf().primaryBackGround() ,fontSize: 20),),
        onPressed: (){
        // if (this.formKey.currentState.validate()) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => Home(),
                fullscreenDialog: true,
              ),
            );

         // }*/
        },
      ),
    );
  }


/* Widgets  */
Widget logoWidget(){
  return Container(
    height: 100,
    width: 100,
    child: ColorsOf().logoLogIn(),
  );
}



}




