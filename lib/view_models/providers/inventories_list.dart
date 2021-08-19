import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/inventories.dart';
import 'package:scanapp/models/variables_define/colors.dart';

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


  Widget iconLoeading(Inventory inv){

    switch(inv.status){
      case "finished": return Icon(Icons.check_circle, color: ColorsOf().finisheItem(),); break;
      case "ongoing": return Icon(Icons.circle, color: ColorsOf().onGoingItem(),); break;
      default : return Icon(Icons.circle, color: ColorsOf().backGround(),); break;

    }
  }


  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool bigger = false;
  TextEditingController searchItem = new TextEditingController();
  void onPressedButton(){
    bigger = !bigger;
    notifyListeners();
  }


  AppBar appBAR(context){
    return AppBar(
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:Theme.of(context).primaryColorBrightness,
      ),

      brightness: Theme.of(context).primaryColorBrightness,

      backgroundColor: ColorsOf().backGround(),
      leading: IconButton(
        onPressed: () => scaffoldKey.currentState!.openDrawer(),
        icon: Icon(Icons.menu , color: ColorsOf().primaryBackGround(),),
      ),
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: ColorsOf().primaryBackGround(),
          ),
          onPressed: () => this.onPressedButton(),
        ),
        AnimatedContainer(
          width: !bigger ? 0 : MediaQuery.of(context).size.width * 0.70,
          margin: EdgeInsets.only(right: !bigger ? 10 : 10),
          color: Colors.transparent,
          child: TextField(
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 14, color: ColorsOf().borderContainer()),
            maxLines: 1,
            maxLength: 100,
            showCursor: true,
            onTap: () {},
            onChanged: (value) { },
            controller: this.searchItem,
            autofocus: false,
            minLines: 1,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorsOf().primaryBackGround(),
                      style: BorderStyle.solid,
                      width: 1
                  )
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorsOf().primaryBackGround(),
                      style: BorderStyle.solid,
                      width: 2
                  )
              ),
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorsOf().primaryBackGround(),
                      style: BorderStyle.solid,
                      width: 1
                  )
              ),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorsOf().deleteItem(),
                      style: BorderStyle.solid,
                      width: 1
                  )
              ),
              //isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              alignLabelWithHint: false,
              labelText: null,

              counterStyle: TextStyle(
                height: double.minPositive,
              ),
              counterText: "",
              hintText: "Rechercher...",
              hintStyle: TextStyle(color: ColorsOf().importField()),

            ),
            toolbarOptions: ToolbarOptions(
              cut: true,
              copy: true,
              selectAll: true,
              paste: true,
            ),
          ),
          duration: Duration(milliseconds: 150),
        ) ,
      ],
    );
  }


}
