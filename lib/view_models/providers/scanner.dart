import 'package:flutter/material.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/models/variables_define/my_flutter_app_icons.dart';

class ScannerProvider extends ChangeNotifier{

  static ScannerProvider? _instance;
  ScannerProvider._();
  factory ScannerProvider() => _instance ??=ScannerProvider._();



/* Variables */
  final formKey = GlobalKey<FormState>();
  TextEditingController barCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  bool _switch = false;
/* Provider Functions  */

  inputBarCode(){
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
        obscureText: false,
        controller: barCodeController,
        autofocus: false,
        minLines: 1,
        keyboardType: TextInputType.text,

        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignLabelWithHint: false,
          labelText: null,
          prefixIcon: Icon(Icons.qr_code_scanner_outlined,color: ColorsOf().backGround()),
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
          hintText: "code à barre...",
          hintStyle: TextStyle(color: ColorsOf().hintText()),

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
  inputState(){
    return Container(
      margin: EdgeInsets.only(top: 10,bottom: 10),
      color:ColorsOf().containerThings(),
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
        obscureText: false,
        controller: stateController,
        autofocus: false,
        minLines: 1,
        keyboardType: TextInputType.text,

        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignLabelWithHint: false,
          labelText: null,
          prefixIcon: Icon(Icons.assignment_turned_in_outlined,color: ColorsOf().primaryBackGround()),
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
          hintText: "bon/pas bon....",
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


  /* Widgets  */
  Widget logoWidget(){
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: ColorsOf().borderContainer(),width: 1,style:BorderStyle.solid),
        color: ColorsOf().containerThings(),
      ),
      child: Icon(MyFlutterApp.qr_code,size: 60,color: ColorsOf().primaryBackGround(),),
    );
  }

}
