import 'package:ecommerce_app/layout/home_screen.dart';
import 'package:ecommerce_app/layout/on_bording_screen.dart';
import 'package:ecommerce_app/share/app_cubit.dart';
import 'package:ecommerce_app/share/app_state.dart';
import 'package:ecommerce_app/share/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'model/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getItemsData_itemModule()
        ..getCategoriesData_categoryModule(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          Widget home = OnBordingScreen();
          String? token = CacheHelper.getToken();
          if (token != null) {
            //printDebug("Token is not Null");
            home = HomeScreen();
            Map<String, dynamic> jsonToken =
                JwtDecoder.decode(CacheHelper.getToken()!);
            AppCubit.get(context).user = UserModel(CacheHelper.getToken(),
                CacheHelper.getRefreshToken(), jsonToken);
            //Log.v("Token ${AppCubit.get(context).user!.token!}");
            //Log.v("User is ${AppCubit.get(context).user!.role}");
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: home,
          );
        },
      ),
    );
  }
}
