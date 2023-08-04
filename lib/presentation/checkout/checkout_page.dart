import 'package:fic_ecommerce_tv/bloc/order/order_bloc.dart';
import 'package:fic_ecommerce_tv/data/datasources/auth_local_datasource.dart';
import 'package:fic_ecommerce_tv/data/models/order_request_model.dart';
import 'package:fic_ecommerce_tv/widgets/snap_widget.dart';
import 'package:flutter/material.dart';
import 'package:fic_ecommerce_tv/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:fic_ecommerce_tv/presentation/snap_widget.dart';
//checkout page ambil data dari order dan checkout

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout Page"),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          //orientasi rownya mulai dari kiri (cross berlawanan dari
          // orientasinya column)
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Alamat Pengiriman",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 9.0,
            ),
            TextField(
              controller: _addressController,
              maxLines: 4,
              decoration: const InputDecoration(
                  labelText: '', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text(
              "Item Product yang dibeli",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            //pakai blocbuuilder kalau hanya membutuhkan 1 state
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                if (state is CheckoutLoaded) {
                  //tidak boleh ada produk (items) yang sama, pakainya toset
                  //jml barang dipesan (yang berbeda atau sama)
                  final uniqueItem = state.items.toSet().length;
                  final dataSet = state.items.toSet(); //data barang dipesan

                  //expanded = utk mengisi (mentokin) ukuran widget
                  return Expanded(
                    child: ListView.builder(
                      itemCount: uniqueItem, //menampilkan jumlah barang
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        //akan bertambah kalau produknya sama
                        final count = state.items
                            .where(
                              (element) =>
                                  element.id == dataSet.elementAt(index).id,
                            )
                            .length; //length (berapa jumlahmya)
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              backgroundImage: NetworkImage(
                                "${dataSet.elementAt(index).attributes!.image}",
                              ),
                            ),
                            title: Text(
                                "${dataSet.elementAt(index).attributes!.name}"),
                            subtitle: Text("$count"),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: 0, //dihilangin
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 100.0,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8.0,
                            ),
                          ),
                        ),
                        child: const Text(
                          "OK",
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
      //tombol bayarnya ada di bottom navigation bar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        //kalau blocnya beda, pakaimya bloclistener
        child: BlocListener<OrderBloc, OrderState>(
          //listener disini utk meload data callback payment (order)
          listener: (context, state) {
            // maybewhen utk handling ada error dan sukses terload
            //bikin snapwidget dulu utk callaback pembayaran midtrans
            state.maybeWhen(
              orElse: () {},
              loaded: (model) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          (SnapWidget(url: model.redirectUrl))),
                );
              },
            );
          },
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutLoaded) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () async {
                    final userId = await AuthLocalDataSource().getUserId();
                    //total, utk menghitung harga keseluruhan, selanjutnya setealh
                    //tanda koma, sum harga penjumlahan sebelumnya, item itu harga
                    //per barang

                    /* qty mungkin pakai ini
                       final countItem = state.items
                                                .where((element) =>
                                                    element.id ==
                                                    dataSet.elementAt(index).id)
                                                .length;
                                            //belum di return
                    */
                    final total = state.items
                        .fold(0, (sum, item) => item.attributes!.price!);

                    //datanya ada di e
                    final data = Data(
                        items: state.items
                            .map((e) => Item(
                                id: e.id!,
                                productName: e.attributes!.name!,
                                price: e.attributes!.price!,
                                qty: 1))
                            .toList(),
                        totalPrice: total,
                        deliveryAddress: _addressController.text,
                        courierName: "JNT",
                        shippingCost: 20000,
                        statusOrder: "Waiting Payment",
                        userId: userId);
                    //data do order dari order requst model, enggak bisa langsung
                    //dari datanya
                    final requestModel = OrderRequestModel(data: data);

                    //ketika ditekan, lakukan pemesanan ke order bloc
                    context
                        .read<OrderBloc>()
                        .add(OrderEvent.doOrder(requestModel));
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.money,
                        size: 24.0,
                      ),
                      SizedBox(
                        width: 7.0,
                      ),
                      Text("Bayar"),
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
