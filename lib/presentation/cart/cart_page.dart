// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:fic_ecommerce_tv/bloc/checkout/checkout_bloc.dart';
import 'package:fic_ecommerce_tv/common/global_variable.dart';
import 'package:fic_ecommerce_tv/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final int _page = 2;
  double bottomBarWidth = 44;
  double bottomBarBorderWidth = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Color(0xffEE4D2D)),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 3,
                    child: TextFormField(
                      onFieldSubmitted: (_) {},
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search ',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: SizedBox(
              height: 100.0,
              child: Row(
                children: [
                  const Text(
                    "Subtotal",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  BlocBuilder<CheckoutBloc, CheckoutState>(
                      builder: (context, state) {
                    //jika data checkout mulai terload, maka hitung semua
                    //harganya, const = nilainya tetap
                    if (state is CheckoutLoaded) {
                      //fold berfungsi utk menjumlahkan angka dari suatu
                      //collection dengan menjadikannya nilai (harga) terkini
                      //initial value = 0, sum untukmenampung jumlah seluruh ha
                      //harga, item untuk menyimpan satu harga produk
                      final total = state.items.fold(
                          0, (sum, item) => sum + item.attributes!.price!);

                      return Text(
                        "Rp. $total",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }

                    return const Text(
                      "Calculate",
                      style: TextStyle(
                        fontSize: 21.0,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          Padding(
            //kasih jarak antar komponnen 10
            padding: const EdgeInsets.all(10),

            //butuh auth data source dan auth model, entar aja
            child: ElevatedButton(
              onPressed: () async {},
              style: ElevatedButton.styleFrom(
                  //lebarnya tak terbatas
                  minimumSize: const Size(double.infinity, 45),
                  backgroundColor: const Color(0xffee4d2d)),
              child: const Text(
                "Checkout",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          //garis
          Container(
            color: Colors.black12.withOpacity(0.2), //ketebalan 20%
          ),
          const SizedBox(
            height: 8.0,
          ),
          BlocBuilder<CheckoutBloc, CheckoutState>(
              //blocbuilder pakai context sama stse
              builder: (context, state) {
            if (state is CheckoutLoaded) {
              //tidak boleh ada produk (items) yang sama, pakainya toset
              final uniqueItem = state.items.toSet().length; //hitung produk
              final dataSet = state.items.toSet(); //menampilkan data produk

              return Expanded(
                child: ListView.builder(
                  itemCount: uniqueItem,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          //kesamping dulu
                          child: Row(
                            children: [
                              Image.network(
                                //menampilkan gambar sesuai urutannya
                                //(kalau gbrnya banyak) ! = wajib ada
                                "${dataSet.elementAt(index).attributes!.image}",
                                width: 130.0,
                                height: 130.0,
                                fit: BoxFit.fitWidth,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 230,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      "${dataSet.elementAt(index).attributes!.name}",
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Container(
                                    width: 230,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      "${dataSet.elementAt(index).attributes!.price}",
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Container(
                                    width: 230,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      //jika panjang karakternya lebih 20 maka
                                      "${dataSet.elementAt(index).attributes!.description!.length >= 20 ? dataSet.elementAt(index).attributes!.description!.substring(0, 20) : dataSet.elementAt(index).attributes!.description!}...",
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Container(
                                    width: 230,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      dataSet
                                                  .elementAt(index)
                                                  .attributes!
                                                  .quantity! >
                                              0
                                          ? "In Stock"
                                          : "Out Of Stock",
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.tealAccent,
                                      ),
                                      maxLines: 2,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.black12,
                                  width: 2, //tebal garis border
                                )),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        //mengurangi jml qty produk yang dipilih
                                        //utk di checkout (dibeli)
                                        //elemet at berdasarkan index (id) si
                                        //colection productnya
                                        context.read<CheckoutBloc>().add(
                                            RemoveFromCartEvent(
                                                product:
                                                    dataSet.elementAt(index)));
                                      },
                                      child: Container(
                                        width: 35.0,
                                        height: 30.0,
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.remove,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                    //decoratedbox utk menampilkan qty barang yang dipesan
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: 1.5)),
                                      child: Container(
                                        width: 35.0,
                                        height: 30.0,
                                        alignment: Alignment.center,
                                        color: Colors.white,
                                        child: BlocBuilder<CheckoutBloc,
                                                CheckoutState>(
                                            builder: (context, state) {
                                          if (state is CheckoutLoaded) {
                                            //akan bertambah jml qty yang dipesan
                                            //kalau element idnya sama dengan yang di dataset
                                            final countItem = state.items
                                                .where((element) =>
                                                    element.id ==
                                                    dataSet.elementAt(index).id)
                                                .length;
                                            //belum di return ternyata :D
                                            return Text(
                                              "$countItem",
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            );
                                          }
                                          return const Text(
                                            "0",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        //mengurangi jml qty produk yang dipilih
                                        //utk di checkout (dibeli)
                                        context.read<CheckoutBloc>().add(
                                            AddToCartEvent(
                                                product:
                                                    dataSet.elementAt(index)));
                                      },
                                      child: const SizedBox(
                                        width: 35.0,
                                        height: 32.0,
                                        child: Icon(
                                          Icons.add,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            }

            return Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              'https://picsum.photos/200',
                              fit: BoxFit.contain,
                              height: 135,
                              width: 135,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 235,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const Text(
                                    'jasjus',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  width: 235,
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: const Text(
                                    'Rp. 200.000',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  width: 235,
                                  padding: const EdgeInsets.only(left: 10),
                                  child:
                                      const Text('Eligible for FREE Shipping'),
                                ),
                                Container(
                                  width: 235,
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: const Text(
                                    'In Stock',
                                    style: TextStyle(
                                      color: Colors.teal,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black12,
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 35,
                                      height: 32,
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.remove,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black12, width: 1.5),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: Container(
                                      width: 35,
                                      height: 32,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '12',
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 35,
                                      height: 32,
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.add,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          selectedItemColor: GlobalVariables.selectedNavBarColor,
          unselectedItemColor: GlobalVariables.unselectedNavBarColor,
          backgroundColor: GlobalVariables.backgroundColor,
          iconSize: 25,
          onTap: (index) {},
          //daftar icon menunya item barnya taruh disini, min hrs ada 2 item
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(
                        color: _page == 0
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth),
                  )),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    child: const Icon(
                      Icons.home_filled,
                      size: 24.0,
                    ),
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: _page == 1
                                  ? GlobalVariables.selectedNavBarColor
                                  : GlobalVariables.unselectedNavBarColor,
                              width: bottomBarBorderWidth))),
                  child: InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.person_outline,
                      size: 24.0,
                    ),
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                        border: Border(
                            //kasih garis border atas
                            top: BorderSide(
                                color: _page == 2
                                    ? GlobalVariables.selectedNavBarColor
                                    : GlobalVariables.unselectedNavBarColor,
                                width: bottomBarBorderWidth))),
                    child: BlocBuilder<CheckoutBloc, CheckoutState>(
                      builder: (context, state) {
                        if (state is CheckoutLoaded) {
                          return badges.Badge(
                            badgeStyle: const badges.BadgeStyle(
                                elevation: 0, badgeColor: Colors.orange),
                            badgeContent: Text(
                              state.items.isEmpty
                                  ? "0"
                                  : "${state.items.length}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CartPage()),
                                );
                              },
                              child: const Icon(
                                Icons.shopping_cart,
                                size: 24.0,
                              ),
                            ),
                          );
                        }
                        return badges.Badge(
                          badgeStyle: const badges.BadgeStyle(
                              elevation: 0, badgeColor: Colors.orange),
                          badgeContent: const Text(
                            "0",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CartPage()),
                              );
                            },
                            child: const Icon(
                              Icons.shopping_cart,
                              size: 24.0,
                            ),
                          ),
                        );
                      },
                    )),
                label: '')
          ]),
    );
  }
}
