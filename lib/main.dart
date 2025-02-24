import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ft_a/hep/game_config_hep.dart';
import 'package:ft_a/hep/user_info_hep.dart';
import 'package:ft_a/routers/_routers_list.dart';
import 'package:ft_base/routers/base_routers/base_routers_list.dart';
import 'package:ft_base/routers/base_routers/base_routers_name.dart';
import 'package:ft_base/util/util.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarDividerColor: null,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
      )
  );
  await GetStorage.init();

  //init a
  GameConfigHep.instance.initData();
  UserInfoHep.instance.initUserInfo();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var list=BaseRoutersList.baseList+ARoutersList.aList;
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      builder: (c,child)=>GetMaterialApp(
        title: 'Scratch FunTime',
        enableLog: true,
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        initialRoute: BaseRoutersName.launch,
        debugShowCheckedModeBanner: false,
        getPages: list,
        defaultTransition: Transition.rightToLeft,
        builder: (context,widget){
          return  MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
      ),
    );
  }
}