import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_api_challenge/data/models/field_state.dart';
import 'package:flutter_api_challenge/data/models/user_created.dart';
import 'package:flutter_api_challenge/data/repositories/users_repository.dart';
import 'package:get_it/get_it.dart';

part 'create_user_event.dart';
part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  CreateUserBloc() : super(CreateUserInitial()) {
    on<FormChanged>((event, emit) {
      emit(_getIdleState());
    });
    on<CreateButtonTapped>((event, emit) {
      emit(CreateUserInitial());
      _createUser();
    });
    on<CreateUserFailed>((event, emit) {
      emit(CreateUserFailure());
    });
    on<RetryTapped>((event, emit) {
      emit(_getIdleState());
    });
    on<NewUserCreated>((event, emit) {
      emit(CreateUserSuccess(user: event.user));
    });

    _usersRepository = GetIt.I<UsersRepository>();

    add(FormChanged());
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  late final UsersRepository _usersRepository;

  CreateUserIdle _getIdleState() {
    return CreateUserIdle(
      nameFieldState: _getNameFieldState(),
      jobFieldState: _getJobFieldState(),
      isCreateButtonEnabled: _isCreateButtonEnabled(),
    );
  }

  FieldState _getNameFieldState() {
    return FieldState(
      controller: _nameController,
      text: _nameController.text,
    );
  }

  FieldState _getJobFieldState() {
    return FieldState(
      controller: _jobController,
      text: _jobController.text,
    );
  }

  bool _isCreateButtonEnabled() {
    return _nameController.text.isNotEmpty && _jobController.text.isNotEmpty;
  }

  Future<void> _createUser() async {
    try {
      UserCreated user = await _usersRepository.createUser(
        name: _nameController.text,
        job: _jobController.text,
      );
      add(NewUserCreated(user: user));
    } catch (e) {
      add(CreateUserFailed());
    }
  }
}
