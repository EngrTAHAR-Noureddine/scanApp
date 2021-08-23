import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/emplacements.dart';
import 'package:scanapp/models/database_models/inventories.dart';
import 'package:scanapp/models/database_models/inventory_lines.dart';
import 'package:scanapp/models/database_models/product_lots.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/models/variables_define/my_flutter_app_icons.dart';
import 'package:scanapp/view_models/providers/main.dart';

class ScannerProvider extends ChangeNotifier{

  static ScannerProvider? _instance;
  ScannerProvider._();
  factory ScannerProvider() => _instance ??=ScannerProvider._();



/* Variables */
  final formKey = GlobalKey<FormState>();
  TextEditingController barCodeController = TextEditingController();



  String? barCode;
  bool didFinished = false;
  int? idEmplacement;
  int? idProduct;
  String? nameEmplacement;
  String? quality = "Bon";
  InventoryLine? newLine;
  Inventory? incompleteInventory;
  bool showKeyBoard = false;

/*
  keyBoardToggle(bool show){
    (show)? SystemChannels.textInput.invokeMethod('TextInput.show'):SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
*/
/* Provider Functions  */
  void clearVars(){
    print("inter to the clear var ===** ");
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    showKeyBoard = false;
    barCode = null;
    didFinished = false;
    idEmplacement = null;
    idProduct= null;
    nameEmplacement= null;
    quality= null;
    newLine= null;
    _switch = false;
    asDefault = false;
    incompleteInventory = null;
  }

  Future<void> useCamera()async{
    String? getFromCamera;
    try {
      getFromCamera = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Annuler", true, ScanMode.DEFAULT);
    } catch (e) { print(e); }
    barCode = ((getFromCamera == null) || (getFromCamera == "-1")) ?null: getFromCamera;
    notifyListeners();
  }

  Future<bool?> searchTheScan()async{
   if(!showKeyBoard) SystemChannels.textInput.invokeMethod('TextInput.hide');

    bool? findIt;
    ProductLot? productLot;
    Emplacement? emplacement;


    /* get incomplete inventory */
    incompleteInventory = await DBProvider.db.getIncompleteInventory();
    /**/

    /* get All inventory lines to compare with all product lots */
    if(incompleteInventory!=null){
      List<InventoryLine> listInvLines = await DBProvider.db.getAllInventoryLines(incompleteInventory!.id);
      if(listInvLines.isNotEmpty)didFinished = (MainProvider().user!.allProductLots == listInvLines.length)?true:false;
    }
    /**/


    if(!didFinished && barCode != null){

      /* scan the emplacemnt */
      emplacement = await DBProvider.db.scanEmplacement(barCode!);
      /**/

      /* get Product lot by barcode */
     if(emplacement == null) productLot = await DBProvider.db.scanByBarCode(barCode!);
      /**/
     if(emplacement!=null){
       idEmplacement = emplacement.id;
       nameEmplacement = emplacement.nom;
       barCode = null;
     }else if(productLot != null){
        findIt = true;
      //  print("findIt of future : "+findIt.toString());
        idProduct = productLot.productId;

        newLine = new InventoryLine(
          difference: 0,
          emplacementId: idEmplacement,
          productId: productLot.productId,
          productLotId: productLot.id,
          inventoryId: incompleteInventory?.id,
          quality: quality ?? "bon",
          quantity: 1,
          quantitySystem: 1
                );
      }else if(MainProvider().user!.productLotsTable == "Empty"){
       findIt = null;
     }else{findIt = false;}

    }
    if(didFinished){

    if(incompleteInventory != null){
      incompleteInventory!.closeDate = DateTime.now().toIso8601String();
      incompleteInventory!.status = "finished";
       await DBProvider.db.updateInventory(incompleteInventory!);
    }


    }
  //  print("findIt of future : "+findIt.toString());
    return findIt;
  }

  Future<void> validation()async{
    _switch = false;
    //keyBoardToggle(false);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if(newLine != null){
      newLine!.quality = quality ?? "Bon";
      if(newLine !=null){
        await DBProvider.db.newInventoryLine(newLine!);
        if(incompleteInventory!=null) {
          incompleteInventory!.status = "ongoing";
          await DBProvider.db.updateInventory(incompleteInventory!);
        }
      }

      quality = null;
      barCodeController.clear();
      barCode = null;
      idProduct = null;
      newLine = null;
      notifyListeners();
    }
  }


  /* Widgets .....*********************** */
  Widget dialogBox(context,bool? findIt){
    String textDialog = "";
    if(findIt!=null)
     textDialog = (!didFinished)?(findIt)?"Trouver le code à barre":"Pas trouver le code à barre":"Vous avez terminé votre travail";
    return (findIt!=null)?Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 10),
        /*
                                * Trouver :
                                * backgroung =>ColorsOf().finisheItem(),
                                * foreground ==> ColorsOf().borderContainer()
                                * non-Trouver :
                                * background ==>ColorsOf().deleteItem(),
                                * foreground ==>ColorsOf().backGround()
                                * */
        decoration: BoxDecoration(
          color:(!didFinished)?(findIt)?ColorsOf().finisheItem():ColorsOf().deleteItem():ColorsOf().finisheItem(),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          textDialog,
          style: TextStyle(
              color:(!didFinished)?(findIt)?ColorsOf().borderContainer():ColorsOf().backGround():ColorsOf().borderContainer(),
              fontSize: 20,
              fontWeight: FontWeight.bold),)
    ):Container();
  }


  inputBarCode(context){
    return Container(
      color:ColorsOf().primaryBackGround(),
      height:50,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10, right: 10, ),
      child: TextFormField(

        enabled: !didFinished,

        onTap: (){
          showKeyBoard = true;
        },
        onEditingComplete: (){
          barCode = barCodeController.text;
          barCodeController.clear();
          notifyListeners();
        },
        validator: (value){

          if(value != null){
            if(value.contains('\n') || value.contains('\t')){
              barCodeController.text = value.replaceAll('\t', '');
              barCode = barCodeController.text;
              barCodeController.clear();
              notifyListeners();
            }
          }

          return null;
        },

        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 16,color:ColorsOf().backGround() ),
        maxLines: 1,
        maxLength: 100,
        showCursor: true,
        obscureText: false,
        controller: barCodeController,
        autofocus: true,
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
  Widget spaceBetween(){

    //FocusScope.of(context).requestFocus(focusNode);
   if(!showKeyBoard) SystemChannels.textInput.invokeMethod('TextInput.hide');
    return SizedBox(height: 10);
  }

  bool _switch = false;
  bool asDefault = false;

  setIsGood(context){
    String text =(quality!=null) ? "Etat :\n\n"+quality.toString() : "Etat :\n\n Pas Bon";
    String text2 ="Par défaut :\n\n Bon" ;
    return Container(
      color:Colors.transparent,//ColorsOf().primaryBackGround(),
      height:80,
      padding: EdgeInsets.all(5),
      //width: 100,
      alignment: Alignment.center,
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(

            width: MediaQuery.of(context).size.width*0.4,
            child: SwitchListTile(
              contentPadding: EdgeInsets.all(0),
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey,
              activeTrackColor: Colors.blue,
              title: Text(
                text, style: TextStyle(color:ColorsOf().primaryBackGround() ,fontSize: 14,fontWeight: FontWeight.bold),
              ),

              value: (asDefault)?true:_switch,
              onChanged: (bool value) async {
                print(value);
                _switch = value;
                if(!_switch) asDefault = false;
                quality =(asDefault)? "Bon" :(_switch)?"Bon":"Pas Bon";
                notifyListeners();

              },

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: 2,
              color: ColorsOf().borderContainer(),

            ),
          ),
          Container(

            width: MediaQuery.of(context).size.width*0.4,
            child: SwitchListTile(
              contentPadding: EdgeInsets.all(0),
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey,
              activeTrackColor: Colors.blue,
              title: Text(
                text2, style: TextStyle(color:ColorsOf().primaryBackGround() ,fontSize: 14,fontWeight: FontWeight.bold),
              ),

              value: asDefault,
              onChanged: (bool value) async {
                print(value);
                asDefault = value;
                if(asDefault) quality = "Bon";

                notifyListeners();

              },

            ),
          ),
        ],
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
