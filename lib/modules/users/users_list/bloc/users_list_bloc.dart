import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_api_challenge/data/models/user.dart';
import 'package:flutter_api_challenge/data/models/user_page.dart';
import 'package:flutter_api_challenge/data/repositories/users_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'users_list_event.dart';
part 'users_list_state.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  UsersListBloc() : super(UsersListInitial()) {
    on<UsersListLoaded>((event, emit) {
      emit(UsersListLoadSuccess(
        pagingController: _pagingController,
      ));
    });
    on<GetUsersFailed>((event, emit) {
      emit(UsersListLoadFailure());
    });
    on<RetryTapped>((event, emit) {
      emit(UsersListInitial());
      _getUsers(pageIndex: 1);
    });
    on<RefreshTriggered>((event, emit) {
      emit(UsersListRefresh());
      _getUsers(pageIndex: 1);
    });

    _usersRepository = GetIt.I<UsersRepository>();

    _pagingController.addPageRequestListener((pageIndex) {
      _getUsers(pageIndex: pageIndex);
    });

    _getUsers(pageIndex: 1);
  }

  late final UsersRepository _usersRepository;
  final PagingController<int, User> _pagingController =
      PagingController<int, User>(firstPageKey: 1);
  final List<User> _users = [];

  Future<void> _getUsers({required int pageIndex}) async {
    try {
      UserPage userPage = await _usersRepository.getUsers(
        pageIndex: pageIndex,
      );
      _updatePagingController(userPage, pageIndex);
    } catch (e) {
      add(GetUsersFailed());
    }
  }

  void _updatePagingController(
    UserPage userPage,
    int pageIndex,
  ) {
    if (pageIndex == 1) _users.clear();

    _users.addAll(userPage.data);
    _pagingController.value = PagingState(
      itemList: _users,
      nextPageKey: userPage.page == userPage.totalPages ? null : pageIndex + 1,
    );

    add(UsersListLoaded());
  }
}
