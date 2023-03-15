part of 'users_list_bloc.dart';

abstract class UsersListEvent extends Equatable {
  const UsersListEvent();

  @override
  List<Object> get props => [];
}

class UsersListLoaded extends UsersListEvent {}

class GetUsersFailed extends UsersListEvent {}

class RetryTapped extends UsersListEvent {}

class RefreshTriggered extends UsersListEvent {}
