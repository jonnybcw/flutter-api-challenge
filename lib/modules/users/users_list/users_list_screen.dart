import 'package:flutter/material.dart';
import 'package:flutter_api_challenge/data/models/user.dart';
import 'package:flutter_api_challenge/modules/users/create_user/create_user_dialog.dart';
import 'package:flutter_api_challenge/modules/users/users_list/bloc/users_list_bloc.dart';
import 'package:flutter_api_challenge/modules/users/users_list/components/user_tile.dart';
import 'package:flutter_api_challenge/util/components/empty_component.dart';
import 'package:flutter_api_challenge/util/components/error_component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  late UsersListBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = UsersListBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<UsersListBloc, UsersListState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Users'),
              actions: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const CreateUserDialog(),
                    );
                  },
                  icon: const Icon(Icons.add_rounded),
                ),
              ],
            ),
            body: _getBody(context, state),
          );
        },
      ),
    );
  }

  Widget _getBody(BuildContext context, UsersListState state) {
    if (state is UsersListLoadFailure) {
      return ErrorComponent(
        onTapRetry: () {
          bloc.add(RetryTapped());
        },
      );
    } else if (state is UsersListLoadSuccess) {
      return RefreshIndicator(
        onRefresh: () async {
          bloc.add(RefreshTriggered());
        },
        child: PagedListView<int, User>(
          pagingController: state.pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) {
              return UserTile(user: item);
            },
            firstPageProgressIndicatorBuilder: (context) =>
                const Center(child: CircularProgressIndicator()),
            newPageProgressIndicatorBuilder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            noItemsFoundIndicatorBuilder: (context) => const EmptyComponent(),
          ),
        ),
      );
    } else if (state is UsersListRefresh) {
      return const Align(
        alignment: Alignment.topCenter,
        child: RefreshProgressIndicator(),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}
