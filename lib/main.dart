import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginpagechallenge/Cubits/CategoriesCubit/CategoriesCubit.dart';
import 'package:loginpagechallenge/Cubits/SearchBarCubit/SearchBarCubit.dart';
import 'package:loginpagechallenge/Cubits/AppCubit/AppCubit.dart';
import 'Screens/LoginPage.dart';
import 'package:loginpagechallenge/Network/Remote/DioHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppCubit()),
        BlocProvider(create: (_) => CategoriesCubit()),
        BlocProvider(create: (_) => SearchBarCubit()),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          textTheme: GoogleFonts.tajawalTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: LoginPage()
      )
    );
  }
}
