import 'package:fic_ecommerce_tv/bloc/checkout/checkout_bloc.dart';
import 'package:fic_ecommerce_tv/bloc/get_products/get_products_bloc.dart';
import 'package:fic_ecommerce_tv/bloc/login/login_bloc.dart';
import 'package:fic_ecommerce_tv/bloc/register/register_bloc.dart';
import 'package:fic_ecommerce_tv/data/datasources/auth_remote_data_source.dart';
import 'package:fic_ecommerce_tv/data/datasources/product_remote_datasource.dart';
import 'package:fic_ecommerce_tv/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver(); //memantau bloc saat ini
  runApp(const MyApp());
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change'); //utk memantau event yg berjalan
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("${bloc.runtimeType} $transition");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print("${bloc.runtimeType} $stackTrace");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //di main bungkus pakai blocprovider
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          //parameter datasource diisi oleh product data source
          //agar bisa di load data productnya
          create: (context) => GetProductsBloc(ProductRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(AuthRemoteDataSource()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Fluteer",
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        home: const HomePage(),
      ),
    );
  }
}
