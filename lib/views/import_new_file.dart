import 'package:flutter/material.dart';
import 'package:scanapp/models/variables_define/colors.dart';
class ImportNewerFile extends StatelessWidget {
bool isPortrait = false;
  @override
  Widget build(BuildContext context) {
    return  OrientationBuilder(
      builder: (context, orientation)
    {
      isPortrait = (orientation == Orientation.portrait);
      return Scaffold(
        backgroundColor: ColorsOf().backGround(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            width: 200,
            height: 200,
            child: Column(
              children: [
                MaterialButton(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  highlightElevation: 0,
                  elevation: 0,
                  focusElevation: 0,
                  hoverElevation: 0,
                  child: CircleAvatar(
                    backgroundColor: ColorsOf().importField(),
                    radius: 50,
                      child: Icon(Icons.add, size: 50, color: ColorsOf().backGround(),)
                  ),


                  onPressed: (){},


                ),
                SizedBox(height: 20,),
                Text("Importer Fichier", style: TextStyle(fontSize: 16 , color: ColorsOf().importField(),),)
              ],
            ),

          ),
        ),
      );

    });

  }
}
