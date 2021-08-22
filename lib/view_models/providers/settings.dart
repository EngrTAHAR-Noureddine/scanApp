import 'package:flutter/material.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/user.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/main.dart';

class SettingsProvider extends ChangeNotifier{
  static SettingsProvider? _instance;
  SettingsProvider._();
  factory SettingsProvider() => _instance ??=SettingsProvider._();


  List<bool> switches =[false,false];
  Future<void> showDialogResetPassword(BuildContext context,) async {
    User? user = await MainProvider().getUser();

    String title = "Réinitialiser le mot de passe";

    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return   Center(
            child: SingleChildScrollView(

              child: AlertDialog(
                backgroundColor:ColorsOf().primaryBackGround(),
                elevation: 1,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                content: Text("Voulez-vous vraiment "+title.toLowerCase()+" ?", style: TextStyle(color: ColorsOf().containerThings(),fontSize:14,),),
                title: Text(title,style: TextStyle(color: ColorsOf().containerThings() ),),
                actions: <Widget>[

                  MaterialButton(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    highlightElevation: 0,
                    elevation: 0,
                    focusElevation: 0,
                    hoverElevation: 0,

                    color:ColorsOf().containerThings() ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.all(0),
                    child: Text("OUI",style: TextStyle(color: ColorsOf().primaryBackGround()),),


                    onPressed:()async{
                      if(user != null){
                        user.userPasswordActually = user.userPasswordReset;
                        await DBProvider.db.updateUser(user);
                        Navigator.of(context).pop();
                        switches[1] = true;
                      }
                      notifyListeners();
                    },


                  ),

                  SizedBox(width: 50,),


                  MaterialButton(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    highlightElevation: 0,
                    elevation: 0,
                    focusElevation: 0,
                    hoverElevation: 0,
                    child: Text('Non',style:TextStyle(color: ColorsOf().containerThings() )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );

        });


  }
  toggleMode(bool value, int num ,{context}) async {

    switches[num] = value;
    if(num == 1 && value == true){
      return await showDialogResetPassword(context);

    }else{
     await MainProvider().setAppMode(switches[num]);
     notifyListeners();
    }
  }
  final formKeyClient = GlobalKey<FormState>();
   final formKeyAdmin = GlobalKey<FormState>();

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
         validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }else if(MainProvider().user!.userPasswordActually == this.CurrentPasswordControllerClient.text){
            return null;
          }else{
            return 'Password is incorrect';
          }

        },
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
       validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }else{
            return null;
          }

        },
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
         validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }else if(this.NewPasswordControllerClient.text == this.rewritePasswordControllerClient.text){
            return null;
          }else{
            return 'Password is incorrect';
          }

        },
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
        onPressed: ()async{
          if(this.formKeyAdmin.currentState != null){
            if (this.formKeyAdmin.currentState!.validate()) {
                await MainProvider().updateUser(this.NewPasswordControllerAdmin.text,true);
              this.CurrentPasswordControllerAdmin.clear();
              this.rewritePasswordControllerAdmin.clear();
              this.NewPasswordControllerAdmin.clear();
              final snackBar = SnackBar(content: Text('le changement de mot de passe a réussi',style: TextStyle(color: ColorsOf().backGround()),),backgroundColor: ColorsOf().borderContainer(),);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              notifyListeners();
                          }
          }
          
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

         validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }else if(MainProvider().user!.adminPassword == this.CurrentPasswordControllerAdmin.text){
            print("input : "+MainProvider().user!.adminPassword! +'--'+ this.CurrentPasswordControllerAdmin.text);
            return null;
          }else{
            print("input : "+MainProvider().user!.adminPassword! +'--'+ this.CurrentPasswordControllerAdmin.text);
            return 'Password is incorrect';
          }

        },
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

         validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }else{
            return null;
          }

        },
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

        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }else if(this.NewPasswordControllerAdmin.text == this.rewritePasswordControllerAdmin.text){
            print("rewrite : "+this.NewPasswordControllerAdmin.text+"----"+ this.rewritePasswordControllerAdmin.text);
            return null;
          }else{
            return 'Password is incorrect';
          }

        },
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
        onPressed: ()async{
          if(this.formKeyClient.currentState != null){
            if (this.formKeyClient.currentState!.validate()) {
                  await MainProvider().updateUser(this.NewPasswordControllerClient.text,false);
                  this.rewritePasswordControllerClient.clear();
                  this.CurrentPasswordControllerClient.clear();
                  this.NewPasswordControllerClient.clear();
                  final snackBar = SnackBar(content: Text('le changement de mot de passe a réussi',style: TextStyle(color: ColorsOf().backGround()),),backgroundColor: ColorsOf().borderContainer(),);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  notifyListeners();
                          }
          }
          
        },
      ),
    );
  }

}
