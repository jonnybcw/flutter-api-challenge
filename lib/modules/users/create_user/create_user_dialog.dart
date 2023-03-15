import 'package:flutter/material.dart';
import 'package:flutter_api_challenge/modules/users/create_user/bloc/create_user_bloc.dart';
import 'package:flutter_api_challenge/util/components/error_component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateUserDialog extends StatefulWidget {
  const CreateUserDialog({Key? key}) : super(key: key);

  @override
  State<CreateUserDialog> createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends State<CreateUserDialog> {
  late CreateUserBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CreateUserBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<CreateUserBloc, CreateUserState>(
        listener: (context, state) {
          if (state is CreateUserSuccess) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "The user has been created successfully [id ${state.user.id}]",
                ),
                backgroundColor: Colors.green[800],
              ),
            );
          }
        },
        builder: (context, state) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Create user',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  _getBody(context, state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getBody(BuildContext context, CreateUserState state) {
    if (state is CreateUserFailure) {
      return ErrorComponent(
        onTapRetry: () {
          bloc.add(RetryTapped());
        },
      );
    } else if (state is CreateUserIdle) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
            controller: state.nameFieldState.controller,
            onChanged: (t) {
              bloc.add(FormChanged());
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Job',
            ),
            controller: state.jobFieldState.controller,
            onChanged: (t) {
              bloc.add(FormChanged());
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('CANCEL'),
              ),
              const Spacer(),
              TextButton(
                onPressed: state.isCreateButtonEnabled
                    ? () {
                        bloc.add(CreateButtonTapped());
                      }
                    : null,
                child: const Text('CREATE'),
              ),
            ],
          )
        ],
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}
