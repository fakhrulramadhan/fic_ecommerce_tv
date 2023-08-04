import 'package:fic_ecommerce_tv/bloc/checkout/checkout_bloc.dart';
import 'package:fic_ecommerce_tv/presentation/cart/cart_page.dart';
import 'package:flutter/material.dart';

import 'package:fic_ecommerce_tv/data/models/responses/list_product_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailProductPage extends StatefulWidget {
  final Product product; //dari list response product
  const DetailProductPage({super.key, required this.product});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        //pakai widget untuk akses ke model product
        title: Text(
          "${widget.product.attributes!.name}",
          style: const TextStyle(
            color: Color.fromARGB(255, 219, 219, 219),
          ),
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 130,
                child: Image.network(
                  "${widget.product.attributes!.image}",
                  //width: 128.0,
                  height: 128.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "${widget.product.attributes!.name}",
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                "${widget.product.attributes!.price}",
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                "${widget.product.attributes!.description}",
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 9.0,
              ),
              //button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: () {
                  //melempar data ke add cart event untuk
                  // menampung barang yang ingin dibeli
                  context
                      .read<CheckoutBloc>()
                      .add(AddToCartEvent(product: widget.product));
                },
                //bloc consumer bisa buat listener dan builder
                // sekaligus, bloclistener hanya menampung
                // listener saja (buildernya ditaruh di child)

                child: BlocConsumer<CheckoutBloc, CheckoutState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is CheckoutLoaded) {
                      //add to cart event sudah ada juga di cart page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartPage()),
                      );
                    }
                  },
                  //pakai bloc consumer kalau listener dan
                  // buildernya membutuhkan nama bloc yang
                  //sama
                  builder: (context, state) {
                    if (state is CheckoutLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return const Row(
                      children: [
                        Icon(
                          Icons.shopping_cart_checkout,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Beli",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
