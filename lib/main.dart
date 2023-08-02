import 'package:fic_ecommerce_tv/bloc/checkout/checkout_bloc.dart';
import 'package:fic_ecommerce_tv/bloc/get_products/get_products_bloc.dart';
import 'package:fic_ecommerce_tv/data/datasources/product_remote_datasource.dart';
import 'package:fic_ecommerce_tv/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
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
