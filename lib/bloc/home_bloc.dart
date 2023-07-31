import 'package:assignment_project/bloc/home_event.dart';
import 'package:assignment_project/bloc/home_state.dart';
import 'package:assignment_project/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(DataInitial()) {
    on<LoadUserEvent>(_onLoadUserEvent);
  }

  _onLoadUserEvent(LoadUserEvent event, Emitter<HomeState> emit) async {
    final UserRepository _userRepository = UserRepository();
    emit(DataLoadingState());
    try {
      Map<String, dynamic> users = await _userRepository.getUsers();
      emit(DataLoadedState(users));
    } catch (e) {
      emit(DataErrorState(e.toString()));
    }
  }
}

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   final UserRepository _userRepository;
//
//   HomeBloc(this._userRepository) : super(DataLoadingState()) {
//     on<LoadUserEvent>((event, emit) async {
//       emit(DataLoadingState());
//       try {
//         Map<String,dynamic> users = await _userRepository.getUsers();
//         emit(DataLoadedState(users));
//       } catch (e) {
//         emit(DataErrorState(e.toString()));
//       }
//     }
//     );
//   }
// }
