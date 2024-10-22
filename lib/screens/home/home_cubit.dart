import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user/company.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    initialLoad();
  }

  initialLoad() {
    emitUpdate();
  }

  navigateToCompanyDetails(BuildContext context, Company company) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Text(company.name ?? '?')));
  }

  emitUpdate() => emit(UpdateUIState());
}
