part of 'create_user_bloc.dart';

abstract class CreateUserEvent extends Equatable {
  const CreateUserEvent();

  @override
  List<Object?> get props => [];
}

class FormChanged extends CreateUserEvent {}

class CreateButtonTapped extends CreateUserEvent {}

class CreateUserFailed extends CreateUserEvent {}

class RetryTapped extends CreateUserEvent {}

class NewUserCreated extends CreateUserEvent {
  const NewUserCreated({
    required this.user,
  });

  final UserCreated user;

  @override
  List<Object?> get props => [
        user,
      ];
}
