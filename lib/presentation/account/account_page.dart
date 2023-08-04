import 'package:fic_ecommerce_tv/bloc/checkout/checkout_bloc.dart';
import 'package:fic_ecommerce_tv/common/global_variable.dart';
import 'package:fic_ecommerce_tv/presentation/cart/cart_page.dart';
import 'package:fic_ecommerce_tv/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic_ecommerce_tv/bloc/list_order/list_order_bloc.dart';
import 'package:fic_ecommerce_tv/data/datasources/auth_local_datasource.dart';

import 'package:badges/badges.dart' as badges;

import '../../data/models/responses/auth_response_model.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final int _page = 1;
  double widthBottomBar = 40;
  double borderWidthBottomBar = 2;
  User? user;

  //ketika halaman dibuka, pertama kali load dulu data order barang
  //yang dipesan dan data user
  @override
  void initState() {
    super.initState();

    //blm dibuat list order blocnya :D
    context.read<ListOrderBloc>().add(const ListOrderEvent.get());
    getUser();
  }

  Future<void> getUser() async {
    await AuthLocalDataSource().getUser();
    setState(() {}); //update UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50), //tinggi appbar 50
        child: AppBar(
          automaticallyImplyLeading: false,
          //kasih background merah pada appbar
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.redAccent),
          ),
          title: const Text(
            "Account",
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: const [],
        ),
      ),
      body: Column(
        children: [
          //menampilkan informasi user yang login
          Text(
            "User anda: ${user == null ? '--' : user!.username} ",
            style: const TextStyle(
              fontSize: 17.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  onPressed: () async {
                    await AuthLocalDataSource().removeAuthData();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: const Text("Logout"),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 18.0,
          ),
          //garis pembatas
          const Divider(
            height: 2,
            thickness: 3,
          ),
          //tampilkan data daftar orderan yang pernah dipesan
          // per usernya pakai listview dan listorderbloc
          Expanded(child: BlocBuilder<ListOrderBloc, ListOrderState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Container(
                    child: const Center(child: Text("Tidak ada order")),
                  );
                },

                //dalam keadaan termuat
                loaded: (data) {
                  return ListView.builder(
                    itemCount: data.data!.length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      //index utk tampilkan per data (nomor) order
                      final orderListData = data.data![index];
                      return Card(
                        elevation: 6,
                        shadowColor: Colors.redAccent,
                        child: ListTile(
                          title: Text("No. Order: ${orderListData.id}"),
                          subtitle: Text(
                              "Total harga: ${orderListData.attributes!.totalPrice}"),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ))
        ],
      ),

      //menu bottom bar
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
                  width: widthBottomBar,
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(
                        color: _page == 0
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: borderWidthBottomBar),
                  )),
                  child: InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.home_filled,
                      size: 24.0,
                    ),
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                  width: widthBottomBar,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: _page == 1
                                  ? GlobalVariables.selectedNavBarColor
                                  : GlobalVariables.unselectedNavBarColor,
                              width: borderWidthBottomBar))),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountPage()),
                      );
                    },
                    child: const Icon(
                      Icons.person_outline,
                      size: 24.0,
                    ),
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                    width: widthBottomBar,
                    decoration: BoxDecoration(
                        border: Border(
                            //kasih garis border atas
                            top: BorderSide(
                                color: _page == 2
                                    ? GlobalVariables.selectedNavBarColor
                                    : GlobalVariables.unselectedNavBarColor,
                                width: borderWidthBottomBar))),
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
