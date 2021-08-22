import 'package:flutter/material.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/counter_stocks_in_emplacement.dart';


class RepportProvider extends ChangeNotifier{

  static RepportProvider? _instance;
  RepportProvider._();
  factory RepportProvider() => _instance ??=RepportProvider._();

  int total = 0;
  int scan =0;
  List<StocksCounter>? listLinesEmp;

  Future<List<EmplacementInfo>> getAllStatistics()async{
     total = 0;
     scan =0;


    List<StocksCounter>? listStocks = await DBProvider.db.saveStocksOfEmplacement();
    List<StocksCounter>? listLinesEmp = await DBProvider.db.getEachEmplacementStocks();
    List<EmplacementInfo> emplacements = <EmplacementInfo>[];



      if(listStocks.isNotEmpty){



        for(int i =0 ; i< listStocks.length ;i++){
          StocksCounter stock = listStocks[i];
          total = (stock.number!=null)?(total + stock.number!):(total +0);
          String? name = (await DBProvider.db.getEmplacement(stock.emplacementID))?.nom ?? null;
            EmplacementInfo empInfo = new EmplacementInfo(
                nom: name,
                id: stock.emplacementID,
                total: stock.number??0,
                scan: 0
            );
            emplacements.add(empInfo);
        }
      }

      if(listLinesEmp.isNotEmpty){



        listLinesEmp.forEach((line) {

          scan  = (line.number!=null)?(scan + line.number!):(scan +0);

          emplacements.forEach((stock) {

            if(stock.id == line.emplacementID){
              stock.scan = line.number??0;
            }

          });


        });
      }




    return (emplacements.isNotEmpty)?emplacements:[];

 }


}

class EmplacementInfo{

  int? id;
  String? nom;
  int? total;
  int? scan;

  EmplacementInfo({required this.id,required this.scan,required this.total , required this.nom});

}
