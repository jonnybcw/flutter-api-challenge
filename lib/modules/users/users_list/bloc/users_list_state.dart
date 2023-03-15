part of 'users_list_bloc.dart';

abstract class UsersListState extends Equatable {
  const UsersListState();

  @override
  List<Object> get props => [];
}

class UsersListInitial extends UsersListState {}

class UsersListLoadSuccess extends UsersListState {
  const UsersListLoadSuccess({
    required this.pagingController,
  });

  final PagingController<int, User> pagingController;

  @override
  List<Object> get props => [pagingController];
}

class UsersListLoadFailure extends UsersListState {}

class UsersListRefresh extends UsersListState {}
