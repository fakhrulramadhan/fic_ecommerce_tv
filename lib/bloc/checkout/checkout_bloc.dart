import 'package:fic_ecommerce_tv/data/models/responses/list_product_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  //super utk memberi tahu kondisi awalnya (panggil event loaded
  // dengan data yang kosong)
  CheckoutBloc() : super(CheckoutLoaded(items: const [])) {
    on<AddToCartEvent>((event, emit) {
      // TODO: implement event handler

      //ambil data state sebelumnya,
      //sebelumnya sudah ada isinya
      final currentState = state as CheckoutLoaded;

      //tambahkan (add) product terbaru (masukkan ke keranjang)
      //currentState.items.add(event.product);

      //jangan pakai add

      //panggil state, emit utk melakukan perubahan pada stete
      //pakai ... karena ada beberapa data item
      //yang ingin dirubah, menambahkan data product yang
      // sebelumnya sudah dideklarasikan di event add tocart
      emit(CheckoutLoading());

      //tambahin jumlah itemnya
      emit(CheckoutLoaded(items: [...currentState.items, event.product]));
      //emit(currentState);
      //emit(CheckoutLoaded(items: currentState.items.add(event.product)));
    });

    //mengurangi jumlah produk yang ada berdasarkan stok
    //masing2 produk
    on<RemoveFromCartEvent>((event, emit) {
      // TODO: implement event handler

      //ambil data state sebelumnya,
      //sebelumnya sudah ada isinya
      final currentState = state as CheckoutLoaded;

      //nilai yang baru
      //final newState = currentState.items.remove(event.product);

      //hapuskan (remove) product terbaru (masukkan ke keranjang)
      //objeknynya enggak ketemu, bentuknya objek, bukan string
      currentState.items.remove(event.product);

      //panggil state, emit utk melakukan perubahan pada stete
      //yang ingin dirubah, menambahkan data product yang
      // sebelumnya sudah dideklarasikan di event add tocart

      //kurangi jumlah itemnya,
      //emit(CheckoutLoaded(items: [...currentState.items]));
      emit(CheckoutLoading());

      emit(CheckoutLoaded(items: currentState.items));
    });
  }
}
