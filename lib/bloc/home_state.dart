abstract class HomeState {}

class DataInitial extends HomeState {}

class DataLoadingState extends HomeState {}

class DataLoadedState extends HomeState {
  Map<String, dynamic> users;

  DataLoadedState(this.users);
}

class DataErrorState extends HomeState {
  final String error;

  DataErrorState(this.error);
}
