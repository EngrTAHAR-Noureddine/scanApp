import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/view_models/providers/exports_list.dart';
import 'package:scanapp/view_models/providers/home.dart';
import 'package:scanapp/view_models/providers/process_on_file.dart';
import 'package:scanapp/view_models/providers/inventories_list.dart';
import 'package:scanapp/view_models/providers/list_of_items.dart';
import 'package:scanapp/view_models/providers/login.dart';
import 'package:scanapp/view_models/providers/main.dart';
import 'package:scanapp/view_models/providers/onGoing_list.dart';
import 'package:scanapp/view_models/providers/repport.dart';
import 'package:scanapp/view_models/providers/scanner.dart';
import 'package:scanapp/view_models/providers/search.dart';
import 'package:scanapp/view_models/providers/settings.dart';
import 'package:scanapp/views/exports_list.dart';
import 'package:scanapp/views/get_user_info.dart';
import 'package:scanapp/views/home.dart';
import 'package:scanapp/views/import_new_file.dart';
import 'package:scanapp/views/inventories_list.dart';
import 'package:scanapp/views/list_of_items.dart';
import 'package:scanapp/views/log_in.dart';
import 'package:scanapp/views/onGoingList.dart';
import 'package:scanapp/views/repport.dart';
import 'package:scanapp/views/scanner.dart';
import 'package:scanapp/views/search.dart';
import 'package:scanapp/views/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:Theme.of(context).primaryColorBrightness,
    )
    );
    return MultiProvider(
        providers: [ //NewTaskProvider
          ChangeNotifierProvider<MainProvider>(
            create: (context) => MainProvider(), ),
          ChangeNotifierProvider<LogInProvider>(
            create: (context) => LogInProvider(), ),
          ChangeNotifierProvider<HomeProvider>(
            create: (context) => HomeProvider(), ),
          ChangeNotifierProvider<InventoryListProvider>(
            create: (context) => InventoryListProvider(), ),
          ChangeNotifierProvider<OnGoingListProvider>(
            create: (context) => OnGoingListProvider(), ),
          ChangeNotifierProvider<ListItemsProvider>(
            create: (context) => ListItemsProvider(), ),
          ChangeNotifierProvider<RepportProvider>(
            create: (context) => RepportProvider(), ),
          ChangeNotifierProvider<ExportProvider>(
            create: (context) => ExportProvider(), ),
          ChangeNotifierProvider<SettingsProvider>(
            create: (context) => SettingsProvider(), ),
          ChangeNotifierProvider<SearchProvider>(
            create: (context) => SearchProvider(), ),
          ChangeNotifierProvider<ScannerProvider>(
            create: (context) => ScannerProvider(), ),
          ChangeNotifierProvider<ProcessFileProvider>(
            create: (context) => ProcessFileProvider(), ),

        ],
        child: Builder(
          builder: (context) {
                return Consumer<MainProvider>(
                        builder: (context, value, child) {
                                    return MaterialApp(
                                              title: 'Flutter Demo',
                                              debugShowCheckedModeBanner: false,
                                              theme: ThemeData(
                                                primaryColorBrightness: Brightness.dark,
                                                brightness: Brightness.dark,
                                                accentColorBrightness:Brightness.dark,
                                                primarySwatch:MaterialColor(0xFFFF9500,const <int, Color>{
                                                  50: const Color(0xFFFF9500 ),//10%
                                                  100: const Color(0xFFFF9500),//20%
                                                  200: const Color(0xFFFF9500),//30%
                                                  300: const Color(0xFFFF9500),//40%
                                                  400: const Color(0xFFFF9500),//50%
                                                  500: const Color(0xFFFF9500),//60%
                                                  600: const Color(0xFFFF9500),//70%
                                                  700: const Color(0xFFFF9500),//80%
                                                  800: const Color(0xFFFF9500),//90%
                                                  900: const Color(0xFFFF9500),//100%
                                                }, )
                                              ),
                                              darkTheme: ThemeData(
                                                primaryColorBrightness: Brightness.light,
                                                brightness: Brightness.light,
                                                accentColorBrightness:Brightness.light,
                                                primarySwatch:MaterialColor(0xFF242426,const <int, Color>{
                                                  50: const Color(0xFF242426 ),//10%
                                                  100: const Color(0xFF242426),//20%
                                                  200: const Color(0xFF242426),//30%
                                                  300: const Color(0xFF242426),//40%
                                                  400: const Color(0xFF242426),//50%
                                                  500: const Color(0xFF242426),//60%
                                                  600: const Color(0xFF242426),//70%
                                                  700: const Color(0xFF242426),//80%
                                                  800: const Color(0xFF242426),//90%
                                                  900: const Color(0xFF242426),//100%
                                                }, ),

                                              ),
                                              themeMode: ThemeMode.system,
                                              home: GetUserInfo(),//LogIn(),
                                              routes: {
                                                "/home": (context) => Home(),
                                                "/inventoryList": (context) => InventoryList(),
                                                "/listItems": (context) => ListItems(),
                                                "/scanner": (context) => Scanner(),
                                                "/import": (context) => ImportNewerFile(),
                                                "/update": (context) => ImportNewerFile(),
                                                "/export": (context) => Export(),
                                                "/report": (context) => Repport(),
                                                "/settings": (context) => Settings(),
                                                "/logout": (context) => LogIn(),
                                                "/search": (context) => Search(),
                                                "/onGoingList": (context) => OnGoingLists(),

                                              },
                                                         );
                        }
                        );
                                  }
                                  )
    );
  }
}
