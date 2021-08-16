import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanapp/view_models/providers/login.dart';
import 'package:scanapp/view_models/providers/main.dart';
import 'package:scanapp/views/log_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ //NewTaskProvider
          ChangeNotifierProvider<MainProvider>(
            create: (context) => MainProvider(), ),
          ChangeNotifierProvider<LogInProvider>(
            create: (context) => LogInProvider(), ),
        ],
        child: Builder(
          builder: (context) {
                return Consumer<MainProvider>(
                        builder: (context, value, child) {
                                    return MaterialApp(
                                              title: 'Flutter Demo',
                                              debugShowCheckedModeBanner: false,
                                              theme: ThemeData(
                                                primaryColorBrightness: Brightness.light,
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
                                                primaryColorBrightness: Brightness.dark,
                                              ),
                                              themeMode: ThemeMode.system,
                                              home: LogIn(),
                                                         );
                        }
                        );
                                  }
                                  )
    );
  }
}
