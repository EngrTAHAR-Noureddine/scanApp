import 'package:flutter/material.dart';
import 'package:scanapp/models/variables_define/colors.dart';

class SettingsProvider extends ChangeNotifier{
  static SettingsProvider? _instance;
  SettingsProvider._();
  factory SettingsProvider() => _instance ??=SettingsProvider._();


  List<bool> switches =[false,false,false,false];

  toggleMode(bool value, int num) async {

    switches[num] = value;
    notifyListeners();
  }
  final formKey = GlobalKey<FormState>();
  TextEditingController CurrentPasswordControllerClient = TextEditingController();
  TextEditingController NewPasswordControllerClient = TextEditingController();
  TextEditingController rewritePasswordControllerClient = TextEditingController();

  TextEditingController CurrentPasswordControllerAdmin = TextEditingController();
  TextEditingController NewPasswordControllerAdmin  = TextEditingController();
  TextEditingController rewritePasswordControllerAdmin  = TextEditingController();

  inputCurrentPasswordClient(){
    return Container(
      color:ColorsOf().backGround(),
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
        style: TextStyle(fontSize: 16,color:ColorsOf().primaryBackGround() ),
        maxLines: 1,
        maxLength: 100,
        showCursor: true,
        obscureText: true,
        controller: CurrentPasswordControllerClient,
        autofocus: false,
        minLines: 1,
        keyboardType: TextInputType.text,

        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignLabelWithHint: false,
          labelText: null,
          prefixIcon: Icon(Icons.lock,color: ColorsOf().primaryBackGround()),
          counterStyle: TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().primaryBackGround(),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().primaryBackGround(),
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
              color: ColorsOf().primaryBackGround(),
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
  inputNewPasswordClient(){
    return Container(
      color:ColorsOf().backGround(),
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
        style: TextStyle(fontSize: 16,color:ColorsOf().primaryBackGround() ),
        maxLines: 1,
        maxLength: 100,
        showCursor: true,
        obscureText: true,
        controller: NewPasswordControllerClient,
        autofocus: false,
        minLines: 1,
        keyboardType: TextInputType.text,

        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignLabelWithHint: false,
          labelText: null,
          prefixIcon: Icon(Icons.lock,color: ColorsOf().primaryBackGround()),
          counterStyle: TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().primaryBackGround(),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().primaryBackGround(),
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
              color: ColorsOf().primaryBackGround(),
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
  rewritePasswordClient(){
    return Container(
      color:ColorsOf().backGround(),
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
        style: TextStyle(fontSize: 16,color:ColorsOf().primaryBackGround() ),
        maxLines: 1,
        maxLength: 100,
        showCursor: true,
        obscureText: true,
        controller: rewritePasswordControllerClient,
        autofocus: false,
        minLines: 1,
        keyboardType: TextInputType.text,

        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignLabelWithHint: false,
          labelText: null,
          prefixIcon: Icon(Icons.lock,color: ColorsOf().primaryBackGround()),
          counterStyle: TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().primaryBackGround(),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().primaryBackGround(),
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
              color: ColorsOf().primaryBackGround(),
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
  buttonConfirmAdmin(context){
    return  Container(
      color:Colors.transparent,
      alignment: Alignment.center,
      child: MaterialButton(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        highlightElevation: 0,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,

        color: ColorsOf().containerThings(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(color:ColorsOf().primaryBackGround() ,width: 1,style: BorderStyle.solid)
        ),
        padding: EdgeInsets.all(0),

        minWidth: 100,
        height: 40,
        child: Text("Confirmer" ,style: TextStyle(color: ColorsOf().primaryBackGround() ,fontSize: 16),),
        onPressed: (){
          /* if (this.formKey.currentState.validate()) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => Home(),
              fullscreenDialog: true,
            ),
          );
 }*/
        },
      ),
    );
  }


  inputCurrentPasswordAdmin(){
    return Container(
      color:ColorsOf().backGround(),
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
        style: TextStyle(fontSize: 16,color:ColorsOf().primaryBackGround() ),
        maxLines: 1,
        maxLength: 100,
        showCursor: true,
        obscureText: true,
        controller: CurrentPasswordControllerAdmin,
        autofocus: false,
        minLines: 1,
        keyboardType: TextInputType.text,

        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignLabelWithHint: false,
          labelText: null,
          prefixIcon: Icon(Icons.lock,color: ColorsOf().primaryBackGround()),
          counterStyle: TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().primaryBackGround(),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().primaryBackGround(),
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
              color: ColorsOf().primaryBackGround(),
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
  inputNewPasswordAdmin(){
    return Container(
      color:ColorsOf().backGround(),
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
        style: TextStyle(fontSize: 16,color:ColorsOf().primaryBackGround() ),
        maxLines: 1,
        maxLength: 100,
        showCursor: true,
        obscureText: true,
        controller: NewPasswordControllerAdmin,
        autofocus: false,
        minLines: 1,
        keyboardType: TextInputType.text,

        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignLabelWithHint: false,
          labelText: null,
          prefixIcon: Icon(Icons.lock,color: ColorsOf().primaryBackGround()),
          counterStyle: TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().primaryBackGround(),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().primaryBackGround(),
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
              color: ColorsOf().primaryBackGround(),
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
  rewritePasswordAdmin(){
    return Container(
      color:ColorsOf().backGround(),
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
        style: TextStyle(fontSize: 16,color:ColorsOf().primaryBackGround() ),
        maxLines: 1,
        maxLength: 100,
        showCursor: true,
        obscureText: true,
        controller: rewritePasswordControllerAdmin,
        autofocus: false,
        minLines: 1,
        keyboardType: TextInputType.text,

        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignLabelWithHint: false,
          labelText: null,
          prefixIcon: Icon(Icons.lock,color: ColorsOf().primaryBackGround()),
          counterStyle: TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().primaryBackGround(),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: ColorsOf().primaryBackGround(),
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
              color: ColorsOf().primaryBackGround(),
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
  buttonConfirmClient(context){
    return  Container(
      color:Colors.transparent,
      alignment: Alignment.center,
      child: MaterialButton(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        highlightElevation: 0,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,

        color: ColorsOf().containerThings(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(color:ColorsOf().primaryBackGround() ,width: 1,style: BorderStyle.solid)
        ),
        padding: EdgeInsets.all(0),

        minWidth: 100,
        height: 40,
        child: Text("Confirmer" ,style: TextStyle(color: ColorsOf().primaryBackGround() ,fontSize: 16),),
        onPressed: (){
          /* if (this.formKey.currentState.validate()) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => Home(),
              fullscreenDialog: true,
            ),
          );
 }*/
        },
      ),
    );
  }

}
