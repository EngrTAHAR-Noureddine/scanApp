import 'package:flutter/material.dart';
import 'package:scanapp/models/variables_define/colors.dart';

class importNewFileProvider extends ChangeNotifier{

  static final importNewFileProvider _singleton = importNewFileProvider._internal();
  factory importNewFileProvider() {
    return _singleton;
  }
  importNewFileProvider._internal();


  Future<void> showDialogToImportFile(BuildContext context,String text) async {
    final TextEditingController _textEditingController = TextEditingController();
    final GlobalKey<FormState> _formKeyDialogCat = GlobalKey<FormState>();
    String title = (text=="new")?"Importer nouveau Fichier":"Mettre à jour le fichier";

    String validButton =text;
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return   Center(
            child: SingleChildScrollView(

              child: AlertDialog(
                backgroundColor:ColorsOf().primaryBackGround(),

                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                content: Text("Importer Fichier", style: TextStyle(color: ColorsOf().containerThings(),fontSize:14,),),
                title: Text(title,style: TextStyle(color: ColorsOf().containerThings() ),),
                actions: <Widget>[

                  MaterialButton(
                    color:ColorsOf().containerThings() ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.all(0),
                    child: Text("Importer" ,style: TextStyle(color: ColorsOf().primaryBackGround()),),
                    onPressed: (){},
                  ),
                  MaterialButton(
                    color:ColorsOf().containerThings() ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.all(0),
                    child: Text("Importer" ,style: TextStyle(color: ColorsOf().primaryBackGround()),),
                    onPressed: (){},
                  ),
                  MaterialButton(
                    child: Text('Cancel',style:TextStyle(color: ColorsOf().containerThings() )),
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


}
