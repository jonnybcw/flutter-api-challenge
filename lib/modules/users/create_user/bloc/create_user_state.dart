part of 'create_user_bloc.dart';

abstract class CreateUserState extends Equatable {
  const CreateUserState();

  @override
  List<Object?> get props => [];
}

class CreateUserInitial extends CreateUserState {}

class CreateUserIdle extends CreateUserState {
  const CreateUserIdle({
    required this.nameFieldState,
    required this.jobFieldState,
    required this.isCreateButtonEnabled,
  });

  final FieldState nameFieldState;
  final FieldState jobFieldState;
  final bool isCreateButtonEnabled;

  @override
  List<Object?> get props => [
        nameFieldState,
        jobFieldState,
        isCreateButtonEnabled,
      ];
}

class CreateUserFailure extends CreateUserState {}

class CreateUserSuccess extends CreateUserState {
  const CreateUserSuccess({
    required this.user,
  });

  final UserCreated user;

  @override
  List<Object?> get props => [
        user,
      ];
}
