import 'package:fic_ecommerce_tv/bloc/checkout/checkout_bloc.dart';
import 'package:fic_ecommerce_tv/bloc/get_products/get_products_bloc.dart';
import 'package:fic_ecommerce_tv/presentation/detail_product/detail_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListProductWidget extends StatefulWidget {
  const ListProductWidget({super.key});

  @override
  State<ListProductWidget> createState() => _ListProductWidgetState();
}

class _ListProductWidgetState extends State<ListProductWidget> {
  //initstate, kondisi ketika halaman dibuka (awal-awal), ambil data
  //produk dulu
  @override
  void initState() {
    // TODO: implement initState
    context.read<GetProductsBloc>().add(DoGetProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //grid2, yang kayak kotaknya menyesuaikan ukuran device,

    //pakai bloc builder, listener kalau ada stet tertentu error
    return BlocBuilder<GetProductsBloc, GetProductsState>(
      builder: (context, state) {
        //state loading ada paling bawah
        // if (state is GetproductsLoading) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        if (state is GetProductsError) {
          return const Center(
            child: Text("Date error"),
          );
        }

        if (state is GetProductsLoaded) {
          if (state.data.data!.isEmpty) {
            return const Center(
              child: Text("Data Empty"),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.65, //0.65 saja utk ratio
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 8,
            ),
            //itemCount: 20,
            //state data di dapatkan dari state get productsloaded
            itemCount: state.data.data!.length, //pastiin ada datanya
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              //data per satuan produk taruh disini (satuan harus
              // ada index)
              final product = state.data.data![index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailProductPage(
                              product: product,
                            )),
                  );
                },
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Hero(
                        //pakai a
                        tag: '${product.attributes!.image}',
                        // child: Image.asset(
                        //   "assets/images/img6.png",
                        //   width: 120.0,
                        //   height: 120.0,
                        //   fit: BoxFit.fill,
                        // ),
                        child: Image.network(
                          "${product.attributes!.image}",
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "${product.attributes!.price}",
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 19,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "${product.attributes!.name}",
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //attributes & quantity harus ada
                      Text(
                        product.attributes!.quantity! > 0
                            ? "In Stock"
                            : "Out Of Stock",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade200,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.shopping_cart,
                            size: 24.0,
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          const Text(
                            "Beli",
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          InkWell(
                            onTap: () {
                              context
                                  .read<CheckoutBloc>()
                                  .add(RemoveFromCartEvent(product: product));
                            },
                            child: const Icon(
                              Icons.remove_circle,
                              size: 24.0,
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          //agar angka qrynya dinamis, pakai blobuilder
                          BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                            //ketika tombol tambah dan kurang diklik
                            //jumlah barangnya per masing2 produk
                            if (state is CheckoutLoaded) {
                              final countItem = state.items
                                  .where((element) => element.id == product.id)
                                  .length;

                              return Text("$countItem");
                            }
                            return const Text(
                              "0",
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            );
                          }),
                          const SizedBox(
                            width: 4.0,
                          ),
                          InkWell(
                            onTap: () {
                              //kalau stoknya kosong, barangnya enggak bisa
                              //ditambah
                              product.attributes!.quantity! > 0
                                  ? context
                                      .read<CheckoutBloc>()
                                      .add(AddToCartEvent(product: product))
                                  : null;
                            },
                            child: const Icon(
                              Icons.add_circle,
                              size: 24.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        //ini statenya kalau loading
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
