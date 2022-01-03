// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/bloc_observer.dart';
import 'package:todo_app/shared/network/local/cach_helper.dart';
import 'package:todo_app/shared/styles/thems.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'layout/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  bool isDark = CacheHelper.getBoolean(key: 'isDark');
  Widget widget;
  runApp(MyApp(
    isDark: isDark,
    startWidget :widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  MyApp({
    this.isDark,
    this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>AppCubit()..changeAppMode (
      fromShared: isDark,),
      child: BlocConsumer <AppCubit, AppStates>(
          listener: (context,state){},
      builder: (context,state){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light, //AppCubit.get(context).isDark? ThemeMode.dark:ThemeMode.light,
          home: HomeLayout(),
        );
      },
    ),
    );
  }
}

