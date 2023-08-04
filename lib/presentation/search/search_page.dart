import 'package:fic_ecommerce_tv/bloc/search/search_bloc.dart';
import 'package:fic_ecommerce_tv/presentation/detail_product/detail_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  //searrch utk menampung inputan pencarian pnama roduk dari user
  String search;

  SearchPage({Key? key, required this.search}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  //ketika halaman pertama kali dibuka, panggil search blocnya
  @override
  void initState() {
    super.initState();

    //widget search didapatkan dari string search yang searchpage
    searchController.text = widget.search;

    context.read<SearchBloc>().add(SearchEvent.search(widget.search));
  }

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
                            onTap: () {
                              SearchPage(search: searchController.text);
                            },
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
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return state.maybeWhen(
              //orelse, kalau ada error (datanya tidak ada)
              orElse: () {
                return const Text(
                  "Tidak ada data Produk",
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                );
              },
              //listresponsemodel sudah di load di loaded
              //data, muncul data data produk yang sesuai dicari
              loaded: (data) {
                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: data.data!.length,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final product = data.data![index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailProductPage(product: product)),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.redAccent,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage("${product.attributes?.image}"),
                          ),
                          title: Text(
                            "${product.attributes?.name}",
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ));
  }
}
