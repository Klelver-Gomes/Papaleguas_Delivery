import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterpriseBloc extends Cubit<bool> {
  EnterpriseBloc() : super(false);

  late bool _showSearch = false;

  static TextEditingController controllerSearch = TextEditingController();

  bool initSearch() {
    _showSearch = !_showSearch;
    emit(_showSearch);
    return _showSearch;
  }

}
