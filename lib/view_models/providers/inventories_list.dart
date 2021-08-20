import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/inventories.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/home.dart';

class InventoryListProvider extends ChangeNotifier{

  static InventoryListProvider? _instance;
  InventoryListProvider._();
  factory InventoryListProvider() => _instance ??=InventoryListProvider._();

  Inventory? incompleteInventory;
  Future<List<Inventory>> getInventories()async{

    incompleteInventory = await DBProvider.db.getIncompleteInventory();

    List<Inventory> list = (await DBProvider.db.getAllInventories());


    return (list.isNotEmpty)?list:[];
  }

  setState(){
    notifyListeners();
  }
  Widget iconLoeading(Inventory inv){

    switch(inv.status){
      case "finished": return Icon(Icons.check_circle, color: ColorsOf().finisheItem(),);
      case "ongoing": return Icon(Icons.circle, color: ColorsOf().onGoingItem(),);
      default : return Icon(Icons.circle, color: ColorsOf().backGround(),);

    }
  }


  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool bigger = false;
  TextEditingController searchItem = new TextEditingController();
  void onPressedButton(){
    bigger = !bigger;
    notifyListeners();
  }


  void moveFirst(List<Inventory> list){

    if(incompleteInventory!=null){
      for(int i = list.length-1; i>=0 ;i--){
        for(int j =i-1 ; j>=0;j-- ){

          if(list[i].id == incompleteInventory!.id){
            dynamic c = list[i];
            list[i] =list[j];
            list[j] = c;
          }

        }
      }
    }

  }


  showDialogOfButtons(context ,Inventory inv,String title, String content,String buttonName)async{
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
                content: Text(content, style: TextStyle(color: ColorsOf().containerThings(),fontSize:14,),),
                title: Text(title,style: TextStyle(color: ColorsOf().containerThings() ),),
                actions: <Widget>[
                  MaterialButton(
                    child: Text('Annuler',style:TextStyle(color: ColorsOf().containerThings() )),
                    onPressed: () {
                      Navigator.of(context).pop();
                      notifyListeners();
                    },
                  ),
                  MaterialButton(
                    color:ColorsOf().containerThings() ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.all(0),
                    child: Text(buttonName ,style: TextStyle(color: ColorsOf().primaryBackGround()),),


                    onPressed: ()async{
                      switch(buttonName){
                        case "Supprimer":await deleteInventory(inv); break;
                        case "Terminer": await finishInventory(inv); break;
                        default : break;
                      }
                      Navigator.of(context).pop();
                      },


                  ),



                ],
              ),
            ),
          );

        });
  }

  /* * Buttons  * */
  Widget deleteButton(context, Inventory inv){
   return Container(
      height: double.infinity,
      decoration: BoxDecoration(
          color:ColorsOf().deleteItem(),

          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          )
      ),
      child: IconSlideAction(
        color: Colors.transparent,
        foregroundColor: ColorsOf().backGround(),
        icon: Icons.delete,
        caption: 'Delete',
        onTap: ()=>showDialogOfButtons(context, inv,"Supprimer Inventaire","êtes-vous sûr de supprimer l'inventaire ?","Supprimer"),
      ),

    );
  }

  finishButon(context, Inventory inv){
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
          color:ColorsOf().finisheItem(),

          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          )
      ),
      child: IconSlideAction(
        color: Colors.transparent,
        foregroundColor: ColorsOf().borderContainer(),
        icon: Icons.check_circle,
        caption: 'Terminer',
        onTap: ()=>showDialogOfButtons(context, inv,"Terminer Inventaire","êtes-vous sûr de terminer l'inventaire ?","Terminer"),
      ),

    );
  }



  //***************** Functions ********************

  Future<void> deleteInventory(Inventory inv)async{
     await  DBProvider.db.clearInventoryWithLines(inv);
     notifyListeners();
  }

  Future<void> finishInventory(Inventory inv)async{
   inv.closeDate = DateTime.now().toIso8601String();
   inv.status = "finished";
   await DBProvider.db.updateInventory(inv);
   notifyListeners();
  }


}
