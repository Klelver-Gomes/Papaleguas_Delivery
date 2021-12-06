import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papaleguas_delivery/model/product_model.dart';

class CartBloc extends Cubit<List<Product>> {
  CartBloc() : super([]);

  void addProduct({required Product product}) {
    state.add(product);
    emit(List.from(state));
  }

  void removeProduct({required Product product}) {
    state.remove(product);
    emit(List.from(state));
  }

  List<Product> getAll({required Product product}) {
    return state;
  }

  void clearListProduct() {
    state.clear();
    emit(List.from(state));
  }
}
