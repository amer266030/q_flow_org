import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:q_flow_organizer/model/user/company.dart';

part 'most_applied_state.dart';

class MostAppliedCubit extends Cubit<MostAppliedState> {
  MostAppliedCubit() : super(MostAppliedInitial()) {
    // Initialize with some sample data
    companies = [
      Company(name: 'Company A'),
      Company(name: 'Company B'),
      Company(name: 'Company C'),
    ];
  }

  List<Company> companies = [];
  int touchedGroupIndex = -1;

  void updateTouchedGroupIndex(int index) {
    touchedGroupIndex = index;
    emitUpdate();
  }

  void emitUpdate() => emit(UpdateUIState());
}
